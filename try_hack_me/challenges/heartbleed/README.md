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

First, we scan the target IP address to make sure the default port 443 for the
HeartBleed vulnerability is open with `nmap -sC -sV <TARGET_IP_ADDRESS>`. Then,
we start `msfconsole` and search for "heartbleed". This way, we can select the
auxiliary/scanner/ssl/openssl_heartbleed module to exploit the vulnerability.
But, first we need to set the RHOST to the target IP address and verbose to true
for detailed output. Finally, we can "run" the module and get the flag.


[^1]: https://tryhackme.com/room/heartbleed
[^2]: https://heartbleed.com/
[^3]: https://www.seancassidy.me/diagnosis-of-the-openssl-heartbleed-bug.html
[^4]: https://stackabuse.com/how-to-exploit-the-heartbleed-bug/
