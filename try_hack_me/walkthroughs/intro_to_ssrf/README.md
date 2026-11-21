```      
▄▄▄▄▄                                          ▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄ ▄▄▄▄▄▄▄    ▄▄▄▄▄▄▄ 
 ███         ██                  ██           █████▀▀▀ █████▀▀▀ ███▀▀███▄ ███▀▀▀▀▀ 
 ███  ████▄ ▀██▀▀ ████▄ ▄███▄   ▀██▀▀ ▄███▄    ▀████▄   ▀████▄  ███▄▄███▀ ███▄▄    
 ███  ██ ██  ██   ██ ▀▀ ██ ██    ██   ██ ██      ▀████    ▀████ ███▀▀██▄  ███▀▀    
▄███▄ ██ ██  ██   ██    ▀███▀    ██   ▀███▀   ███████▀ ███████▀ ███  ▀███ ███                                                                                      
```
In this THM room, we learn how to exploit *Server-Side Request Forgery* (SSRF)
vulnerabilities, allowing us to access internal server resources. [^1]

What does SSRF stand for? What is the other type of SSRF (not regular)?
-----------------------------------------------------------------------------------------
SSRF, i.e. *Server-Side Request Forgery* is a web vulnerability where an attacker
manipulates a vulnerable application to make requests to internal or external resources
on behalf of the server. This can lead to data exposure, unauthorized access to internal
systems or service disruptions. The regular SSRF type returns data to the attacker's
screen, but the *blind* SSRF vulnerability returns no information to the attacker's
screen after a successful SSRF exploit occurs.

For this, we need to change the default address from the webserver
`https://website.thm/item/2?server=api` to force the webserver to instead return data
from `"https://server.website.thm/flag?id=9`.
-----------------------------------------------------------------------------------------
First, we change the API value to the malicious webserver address and then set the ID
flag. Finally, we need to append `&x=` to ignore the rest of the URL.
```text
https://website.thm/item/2?server=server.website.thm/flag?id=9&x=
```

What website can be used to catch HTTP requests from a server?
-----------------------------------------------------------------------------------------
If working with a blind SSRF where no output is reflected to us, as the attacker we can
use an external HTTP logging tool like `requestbin.com` to monitor HTTP requests or use
Burp Suite's Collaborator client directly.

What method can be used to bypass strict rules?
-----------------------------------------------------------------------------------------
An *open redirect* is an endpoint on the sever where the website visitor gets
automatically redirected to another website address. This may have been created to record
clicked links for advertising purposes but can be utilized to redirect an internal HTTP
request to a domain of the attacker's choice to bypass rules.

What IP address may contain sensitive data in a cloud environment?
-----------------------------------------------------------------------------------------
In a cloud environment it could be beneficial to block access to the IP address
`169.254.169.254` as it typically contains metadata and sensitive data for the deployed
cloud server.

What type of list is used to permit only (or stop) certain input?
-----------------------------------------------------------------------------------------
A *deny list* accepts all requests apart from resources specified in the list that match
a particular pattern. An *allow list* on the other hand, denies all requests unless they
appear on a list or match a particular pattern.

What is the flag from the `/private` directory?
-----------------------------------------------------------------------------------------
The `/private` endpoint gives an error message explaining that the contents cannot be
viewed from our IP address. The `/customers/new-account-page` contains a new feature,
allowing customers to choose a new avatar for their account. Then, upon setting the
current avatar, the image content can be seen in the page source as a base64-encoded
style value. Now, we'll select one of the other avatars and change the value in the
inspection to `/private`. We click on *Update Avatar* but the web application has a deny
list in place that blocks access to this `/private` endpoint. But, if we were to change
the value to `sample/../private` we succeed in the base64-encoded contents of the
`/private` *image* file.
```html
<div class="avatar-image" style="background-image: url(data:image/png;base64,
    VEhNe1lPVV9XT1JLRURfT1VUX1RIRV9TU1JGfQ==)"></div>
```
Using `base64 -d` we can now obtain the flag from the `/private` file contents.

[^1]: https://tryhackme.com/room/ssrfqi
