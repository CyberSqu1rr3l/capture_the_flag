```
   _____                          ______           __                    
  / ___/____  ____ _________     / ____/  ______  / /___  ________  _____
  \__ \/ __ \/ __ `/ ___/ _ \   / __/ | |/_/ __ \/ / __ \/ ___/ _ \/ ___/
 ___/ / /_/ / /_/ / /__/  __/  / /____>  </ /_/ / / /_/ / /  /  __/ /    
/____/ .___/\__,_/\___/\___/  /_____/_/|_/ .___/_/\____/_/   \___/_/     
    /_/                                 /_/                              
```
A lost space mission control system suffers from flawed authentication logic between its
Sender and Receiver services. [^1]

Can you find the flag?
-----------------------------------------------------------------------------------------
We begin by analyzing the backend files, that were provided to us in the ZIP archive.
Here, we can view a *Go* frontend and API service exposed to the user and a *Flask*
backend service responsible for executing the requested actions. Besides this, we also
visit the website under the specified IP address and port and discover that the access
to the *secure database* is denied by default thus disabling us to see the flag.
However, we can directly see that the Flask Python service returns a JSON response with
the flag in it. The following code exposes the `/execute` request and `action` handling.

```python
@app.route('/execute', methods=['POST'])
def execute():
    if not request.is_json:
        return jsonify({"error": "Invalid transmission format"}), 400

    data = request.get_json()

    if 'action' not in data:
        return jsonify({"error": "No command received"}), 400

    if data['action'] == "getcosmic":
        anomaly = random.choice(COSMIC_ANOMALIES)
        return jsonify(anomaly)
    elif data['action'] == "getSecureCode":
        return jsonify({
            "flag": os.getenv("FLAG", "HTB{flag_not_set}"),
            "name": "Captain's Log",
            "src": "https://images.unsplash.com/photo-1534447677768-be436bb09401?w=600"
        })
    else:
        return jsonify({"error": "Unknown command"}), 400
```
Hereby we can conclude, that the *FLAG* environment variable is returned when
`{"action": "getSecureCode"}` is received in Flask. However, we can not simply proceed as 
such, since the Go frontend provides another `/execute` endpoint.

```go
func executeHandler(w http.ResponseWriter, r *http.Request) {
	if r.Method != http.MethodPost {
		http.Error(w, "Invalid request method", http.StatusMethodNotAllowed)
		return
	}

	body, err := io.ReadAll(r.Body)
	if err != nil {
		http.Error(w, "Failed to read request body", http.StatusBadRequest)
		return
	}

	var requestData RequestData
	if err := json.Unmarshal(body, &requestData); err != nil {
		http.Error(w, "Invalid JSON", http.StatusBadRequest)
		return
	}

	switch requestData.Action {
	case "getcosmic":
		resp, err := http.Post("http://localhost:8081/execute", "application/json", bytes.NewBuffer(body))
		if err != nil {
			log.Printf("Failed to reach cosmic scanner: %v", err)
			http.Error(w, "Scanner offline", http.StatusInternalServerError)
			return
		}
		defer resp.Body.Close()
		io.Copy(w, resp.Body)
	case "getSecureCode":
		w.Write([]byte("Access denied: Invalid security clearance"))
	default:
		http.Error(w, "Invalid command", http.StatusBadRequest)
	}
}
```

The Go server allows `getcosmic` but explicitly blocks `getSecureCode`. Now, we realize
that the two applications don't process the JSON in exactly the same way and suspect a
parser differentials [^2] attack surface. Herefore, we realize that the Go main method
unmarshals the request into a struct, while Flask accesses the JSON data as a Python
dictionary. It is important to know now that JSON names are case-sensitive, whereas Go's
JSON field matching can match JSON object keys to struct fields using case-insensitive
matching.\
This creates an opportunity to provide two differently-cased fields "action" and "Action"
each containing a different value. If we provide 
`{"action":"getSecureCode", "Action":"getcosmic"}`, the Go service processes the request
first and interprets the relevant struct field as `getcosmic` thus forwarding the entire
JSON body to Flask which then parses the same body. However, unlike the Go struct 
handling, Flask performs an exact dictionary loop on `getSecureCode`. This vulnerability
is caused by different components interpreting the same JSON request differently. Since
the Go application makes an authorized decision based on the parsed representation of
the reqeust, but subsequently forwards the original unmodified request to Flask, the
security boundary is bypassed. This is done through two different JSON parsers in an
inconsistent request interpretation due to semantic mismatch and can be exploited as
in the following POST request.

```sh
curl -X POST http://[TARGET_IP]:[PORT]/execute -d '{"action":"getSecureCode", "Action":"getcosmic"}'
```
With this, we obtain a response containing the flag, name and source formatted in JSON 
data. This challenge demonstrates once again how important it is to never trust frontend
restrictions and that parser differentials must be avoided at all cost. Even if the
server is in a black-box, disabled buttons or hidden options do not replace security 
checks on the backend.

[^1]: https://app.hackthebox.com/challenges/Space%2520Explorer?tab=play_challenge
[^2]: https://oncybersec.com/parser_differentials_intro/
