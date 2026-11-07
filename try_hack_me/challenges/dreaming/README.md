```
   .-.                                                         
  (_) )-.                                    .-.               
    .:   \    .;.::..-.  .-.    . ,';.,';.   `-' . ,';.  ,:.,' 
   .:'    \   .;  .;.-' ;   :   ;;  ;;  ;;  ;'   ;;  ;; :   ;  
 .-:.      ).;'    `:::'`:::'-'';  ;;  ';_.;:._.';  ;;   `-:'  
(_/  `----'                   _;        `-'     ;    `.-._:'   
```
While the king of dreams was imprisoned, his home fell into ruins.
Can you help Sandman restore his kingdom? Solve the riddle that dreams have woven. [^1]

What is the Lucien Flag?
-----------------------------------------------------------------------------------------
We begin with a nmap search on the target machine's IP address and discover an open `ssh`
service on port *22* and `http` on port *80*. Then, we visit the website and discover an
*Apache2 Ubuntu Default Page* which already makes us suspicious of a known vulnerability.
And indeed, for *Apache2* there are are several known *CVEs* [^2] on Ubuntu that we can
exploit. But first, we want to fuzz the server for common directory names with the
following `ffuf` command or similar.
```
ffuf -w /usr/share/wordlists/SecLists/Discovery/Web-Content/common.txt -u http://<TARGET_MACHINE_IP>/FUZZ
```
This way, we can discover the `/app` folder, as well as the `.htpasswd` and `.htaccess`
files which are restricted. Here, in the `/app` folder, we discover a `pluck-4.7.14` web
application for which we can already discover a file upload vulnerability. [^3]
By clicking on it, we are redirected to the `/app/pluck-4.7.13/?file=dreaming` static web
page. However, in the source code, we discover the `/app/pluck-4.7.13/login.php` login
page where we can submit a password, possibly to a restricted admin panel. Here, we try
a couple common passwords out, like *admin* and *password* and are able to log in with
the later one. Having gained access to the *pluck* admin page, we are now able to submit
files and remember the file upload vulnerability for the CVE `2020-29607` [^3] on pluck
services for the version `4.7.13`. So, we proceed to download the exploit script on our
attacking machine with `wget www.exploit-db.com/download/49909`

```
python3 49909 <TARGET_MACHINE_IP> 80 password /app/pluck-4.7.13/
```
This uploaded a malicious file to the server through which we can get shell access on
`http://<TARGET_MACHINE_IP>:80/app/pluck-4.7.13//files/shell.phar`. From here, we can
perform some lateral movement and inspect the `/etc/passwd` file where we discover the
*lucien*, *death* and *morpheus* users.

`ssh lucien@<TARGET_MACHINE_IP>`

What is the Death Flag?
-----------------------------------------------------------------------------------------

What is the Morpheus Flag?
-----------------------------------------------------------------------------------------

[^1]: https://tryhackme.com/room/dreaming
[^2]: https://ubuntu.com/security/notices/USN-7639-1
[^3]: https://www.exploit-db.com/exploits/49909
