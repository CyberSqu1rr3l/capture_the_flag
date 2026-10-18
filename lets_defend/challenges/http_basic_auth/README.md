```
 _   _ _____ ___________  ______           _         ___        _   _     
| | | |_   _|_   _| ___ \ | ___ \         (_)       / _ \      | | | |    
| |_| | | |   | | | |_/ / | |_/ / __ _ ___ _  ___  / /_\ \_   _| |_| |__  
|  _  | | |   | | |  __/  | ___ \/ _` / __| |/ __| |  _  | | | | __| '_ \ 
| | | | | |   | | | |     | |_/ / (_| \__ \ | (__  | | | | |_| | |_| | | |
\_| |_/ \_/   \_/ \_|     \____/ \__,_|___/_|\___| \_| |_/\__,_|\__|_| |_|
```
We receive a log indicating a possible attack, can you gather information from the 
`.pcap` file? [^1]

Gather information from the `webserver.em0.pcap` file.
-----------------------------------------------------------------------------------------
**How many HTTP GET requests are in pcap?**

Having located the packet capture file, we can open it in *Wireshark* and apply the
string `http.request.method == "GET"` to search for all HTTP GET requests.

**What is the server operating system?**

Since, we want to find out information about the server, we apply the `http.response`
filter and already find out the server operating system, which is a variant of *BSD*.

**What is the name and version of the web server software?**

From the previous filtering, we can also spot the name and version of the web server
software.

**What is the version of OpenSSL running on the server?**

From the previous tasks, we can also spot the *OpenSSL* version. Note, that the version
number may sometimes break due to the hexadecimal representation.

**What is the client's user-agent information?**

Again, we use a filtering of `http.request` to view more about the client-side and can
immediately spot the *User-Agent* in the *Hyper Transfer Protocol* tab.

**What is the username used for Basic Authentication?**

In the packet with the number *21*, we can spot a basic authentication with what appears
to be a base64-encoded string. After clicking on it, we are rewarded with the credentials

**What is the user password used for Basic Authentication?**

From the previous credentials, we can also obtain the user password.

[^1]: https://app.letsdefend.io/challenge/http-basic-auth
