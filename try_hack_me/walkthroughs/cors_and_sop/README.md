```
 ________  ________  ________  ________           ________             ________  ________  ________   
|\   ____\|\   __  \|\   __  \|\   ____\         |\   __  \           |\   ____\|\   __  \|\   __  \  
\ \  \___|\ \  \|\  \ \  \|\  \ \  \___|_        \ \  \|\  \  /\      \ \  \___|\ \  \|\  \ \  \|\  \ 
 \ \  \    \ \  \\\  \ \   _  _\ \_____  \        \ \__     \/  \      \ \_____  \ \  \\\  \ \   ____\
  \ \  \____\ \  \\\  \ \  \\  \\|____|\  \        \|_/  __     /|      \|____|\  \ \  \\\  \ \  \___|
   \ \_______\ \_______\ \__\\ _\ ____\_\  \         /  /_|\   / /        ____\_\  \ \_______\ \__\   
    \|_______|\|_______|\|__|\|__|\_________\       /_______   \/        |\_________\|_______|\|__|   
                                 \|_________|       |_______|\__\        \|_________|                 
                                                            \|__|                                    
```
In this THM walkthrough, we examine *Cross-Origin Resource Sharing* (CORS) and
*Same-Origin Policy* (SOP). [^1]

What is the flag from `arbitrary.php`?
-----------------------------------------------------------------------------------------
First, we add the `<TARGET_IP_ADDRESS>` followed by the domain names `corssop.thm`,
`exploit.evilcors.thm` and `corssop.thm.evilcors.thm` in the `/etc/hosts` file to
simulate the interaction between different domain names. Then, we write PHP code to
exfiltrate the response the victim is receiving from the target website and save it in
`/var/www/html/receiver.php`. Also, make sure to create a `data.txt` file in the same
directory with write permissions with `chmod 0777 data.txt`. In the network inspector of
the Firefox developer tools, we can see a request to `corssop.thm` and then resend it
with *Origin* set to `any.com`. This results in the server response header
`Access-Control-Allow-Origin: any.com` and the ACAC true. The CORS policy implementation
is obviously flawed since the ACAO header is echoed without proper validation. \
Now, we go to `exploit.evilcors.thm` which hosts existing JavaScript code that makes
cross-origin requests to the target. We now want to change the attacking machine's IP
address to our own and make sure the GET requests points to the `arbitrary.php` file on
the target web site.
```php
if (isset($_SERVER['HTTP_ORIGIN'])){
    header("Access-Control-Allow-Origin: ".$_SERVER['HTTP_ORIGIN']."");
    header('Access-Control-Allow-Credentials: true');
}
```
Then, we can start the attack which begins with a victim visiting the attacker
controlled website exploit.evilcors.thm/exploit.html. This then sends a request to the
target `corssop.thm/arbitrary.php` website which then respondes sensitive data to the
victim and the exploit automatically exfiltrates the response from the target website to
our attacking machine. Finally, we can look at `/logs.php` and
`tail -n1 /var/log/apache2/access.log`. The response as it was initially received by the
victim is now saved in the `/var/www/html/data.txt` file and contains the flag.

What is the flag from `badregex.php`?
-----------------------------------------------------------------------------------------
Again, we inspect the network traffic and resend the request with a `test.com` origin,
but don't get a `Access-Control-Allow-Origin` in response. So, we try 
`corssop.thm.evilcors.thm` as an origin and get the ACAO response header.
```php
if (isset($_SERVER['HTTP_ORIGIN']) && preg_match('#corssop.thm#',
    $_SERVER['HTTP_ORIGIN'])) {
    header("Access-Control-Allow-Origin: ".$_SERVER['HTTP_ORIGIN']."");
    header('Access-Control-Allow-Credentials: true');
}
```
It is obvious now, that the server is vulnerable due to a poorly implemented regex
pattern. We can reuse the exploit code from the previous task and change the target URL
to `http://corssop.thm/badregex.php`, modify the attacking box IP and utilize the
`corssop.thm.evilcors.thm` website this time. Then, we can send the exploit code to the
victim once again. The victim then automatically visits the `corssop.thm.evilcors.thm`
website and we receive the exfiltrated POST request with the flag from the victim.

What is the flag from `null.php`?
-----------------------------------------------------------------------------------------
The *null* origin usually occurs when a HTML page is loaded locally using the
`file:///` protocol (opening a file directly in the browser) or inside an iframe.
```php
<?php
    header('Access-Control-Allow-Origin: null');
    header('Access-Control-Allow-Credentials: true');
?>
```
The attacker can now create a malicious webpage with an iframe containing a JavaScript
code that makes cross-origin requests to the target application. For this cause, we rely
on the vulnerable link `http://corssop.thm/xss.php` which accepts JavaScript or HTML
code and saves it to the database. We can thus inject JavaScript into the application and
once the victim visits the web app, the payload will be executed. We rely on the
`null.php` script but modify the attack box IP to our own followed by the default port for
apache services. Then, we save the code and verify the `Access-Control-Allow-Origin: null`
header. Finally, we can open the `data.txt` file as it contains the POST response and flag
as it was exfiltrated from the victim after they visited the XSS page.

[^1]: https://tryhackme.com/room/corsandsop
