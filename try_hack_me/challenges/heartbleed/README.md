```                                                                                                          
 .-. .-.,---.    .--.  ,---.  _______ ,---.   ,-.    ,---.  ,---.   ,'|"\   
 | | | || .-'   / /\ \ | .-.\|__   __|| .-.\  | |    | .-'  | .-'   | |\ \  
 | `-' || `-.  / /__\ \| `-'/  )| |   | |-' \ | |    | `-.  | `-.   | | \ \ 
 | .-. || .-'  |  __  ||   (  (_) |   | |--. \| |    | .-'  | .-'   | |  \ \
 | | |)||  `--.| |  |)|| |\ \   | |   | |`-' /| `--. |  `--.|  `--. /(|`-' /
 /(  (_)/( __.'|_|  (_)|_| \)\  `-'   /( `--' |( __.'/( __.'/( __.'(__)`--' 
(__)   (__)                (__)      (__)     (_)   (__)   (__)               
```
In this THM room, we want to exploit a web server's OpenSSL implementation by finding the
*secure socket layer* (SSL) vulnerability. [^1]

Obtain the flag using a very well-known vulnerability.
-----------------------------------------------------------------------------------------
**Make sure you pay attention to all the information and errors displayed and to how web
servers are configured.**

Upon accessing the web server, we are prompted with a static page showing a music video.
First, we scan the server with `nmap -sC -sV <TARGET_IP_ADDRESS>` and discover that there
is an OpenSSL instance running on port *443*. Next, we start the Metasploit `msfconsole`
and `search heartbleed`. The matching modules include
`auxiliary/scanner/ssl/openssl_heartbleed`, a module to exploit the OpenSSL Heartbeat
vulnerability. We can proceed to print `info 4` usage help about the module and thus
discover that we need to set *RHOSTS* with `set RHOSTS` followed by the target IP 
address. Further, we want to `set verbose true` and activate the module with `use 4`.
Finally, we can `run` the module and investigate the heartbeat response throughly. The
info leaked thus contains a user message with the flag.<br>
Alternatively, we can use the command line checker tool [^5] or Python PoC script [^4]
but we were not able to succeed this way. 

[^1]: https://tryhackme.com/room/heartbleed
[^2]: https://heartbleed.com/
[^3]: https://www.seancassidy.me/diagnosis-of-the-openssl-heartbleed-bug.html
[^4]: https://stackabuse.com/how-to-exploit-the-heartbleed-bug/
[^5]: https://github.com/FiloSottile/Heartbleed
