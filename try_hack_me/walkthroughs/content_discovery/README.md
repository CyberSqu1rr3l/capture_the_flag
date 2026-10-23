```
  ___  __   __ _  ____  ____  __ _  ____    ____  __  ____   ___  __   _  _  ____  ____  _  _ 
 / __)/  \ (  ( \(_  _)(  __)(  ( \(_  _)  (    \(  )/ ___) / __)/  \ / )( \(  __)(  _ \( \/ )
( (__(  O )/    /  )(   ) _) /    /  )(     ) D ( )( \___ \( (__(  O )\ \/ / ) _)  )   / )  / 
 \___)\__/ \_)__) (__) (____)\_)__) (__)   (____/(__)(____/ \___)\__/  \__/ (____)(__\_)(__/
```
Learn the various ways of discovering hidden or private content on a webserver that could
lead to new vulnerabilities. [^1]

Task 2 - Manual Discovery - Robots.txt
-----------------------------------------------------------------------------------------
**What is the directory in the `robots.txt` that isn't allowed to be viewed by web
crawlers?**

Upon accessing the `http://<MACHINE_IP_ADDRESS>/robots.txt` file in the browser we are
able to view the page "staff-portal" that search engines aren't allowed to present in
their search results. This page might be a link to an administrative portal or contain
files meant for the website's customers.

Task 3 - Manual Discovery - Favicon
-----------------------------------------------------------------------------------------
**What framework did the favicon belong to?**

Upon opening the website `https://static-labs[.]tryhackme[.]cloud/sites/favicon/` we are
able to see a basic website with a favicon. Next, we want to obtain the favicon and
compute the MD5 value of it with this command:
`curl https://static-labs.tryhackme.cloud/sites/favicon/images/favicon.ico | md5sum`

This returns the hashed value "f276b19aabcb4ae8cda4d22625c6735f" and after searching
for it in the *OWASP favicon database* [^2], we get the "cgiirc" (0.5.9) framework.

Task 4 - Manual Discovery - Sitemap.xml
-----------------------------------------------------------------------------------------
**What is the path of the secret area that can be found in the `sitemap.xml` file?**

In contrast to the `robots.txt` file, the `sitemap.xml` file gives a list of all the
files a website owner wishes to be listed on the public search results. One such secret
area, is the path `/s3cr3t-area` on the target machine as found there.

Task 5 - Manual Discovery - HTTP Headers
-----------------------------------------------------------------------------------------
**What is the flag value from the X-FLAG header?**

By running the verbose `curl` command as follows, we are able to obtain useful
information about what (possibly vulnerable) versions of software are being
used on the webserver: `curl http://<MACHINE_IP_ADDRESS> -v`
And there, for the *X-Flag* header, the flag can be found.

Task 6 - Manual Discovery - Framework Stack
-----------------------------------------------------------------------------------------
**What is the flag from the framework's administration portal?**

Looking at the page source of the `http://<MACHINE_IP_ADDRESS>` website, we are able to
spot a comment at the end of the page with a load time and link to the framework's 
website: `https://static-labs.tryhackme.cloud/sites/thm-web-framework`
There, we can browse to the documentation linking to the `/thm-framework-login`
page with the username "admin" and password "admin". On the target website, we
try to login in this manner and thus get the flag.

Task 12 - Automated Discovery
-----------------------------------------------------------------------------------------
**What is the name of the directory beginning "/mo..."?**

Using the following commands we get similar results of enumerated directories
and files on the webserver that were found using pre curated wordlists:

```text
$ ffuf -w /usr/share/wordlists/SecLists/Discovery/Web-Content/common.txt \
    -u http://<MACHINE_IP_ADDRESS>/FUZZ

assets                  [Status: 301, Size: 178, Words: 6, Lines: 8]
contact                 [Status: 200, Size: 3108, Words: 747, Lines: 65]
customers               [Status: 302, Size: 0, Words: 1, Lines: 1]
development.log         [Status: 200, Size: 27, Words: 5, Lines: 1]
monthly                 [Status: 200, Size: 28, Words: 4, Lines: 1]
news                    [Status: 200, Size: 2538, Words: 518, Lines: 51]
private                 [Status: 301, Size: 178, Words: 6, Lines: 8]
robots.txt              [Status: 200, Size: 46, Words: 4, Lines: 3]
sitemap.xml             [Status: 200, Size: 1383, Words: 260, Lines: 43

$ dirb http://<MACHINE_IP_ADDRESS> /usr/share/wordlists/SecLists/Discovery/Web-\
    Content/common.txt

==> DIRECTORY: http://<MACHINE_IP_ADDRESS>/assets/
+ http://<MACHINE_IP_ADDRESS>/contact (CODE:200|SIZE:3108)
+ http://<MACHINE_IP_ADDRESS>/customers (CODE:302|SIZE:0)
+ http://<MACHINE_IP_ADDRESS>/development.log (CODE:200|SIZE:27)
+ http://<MACHINE_IP_ADDRESS>/monthly (CODE:200|SIZE:28)
+ http://<MACHINE_IP_ADDRESS>/news (CODE:200|SIZE:2538)
==> DIRECTORY: http://<MACHINE_IP_ADDRESS>/private/
+ http://<MACHINE_IP_ADDRESS>/robots.txt (CODE:200|SIZE:46)
+ http://<MACHINE_IP_ADDRESS>/sitemap.xml (CODE:200|SIZE:1383)

---- Entering directory: http://<MACHINE_IP_ADDRESS>/assets/ ----
==> DIRECTORY: http://<MACHINE_IP_ADDRESS>/assets/avatars/

---- Entering directory: http://<MACHINE_IP_ADDRESS>/private/ ----
+ http://<MACHINE_IP_ADDRESS>/private/index.php (CODE:200|SIZE:49)

---- Entering directory: http://<MACHINE_IP_ADDRESS>/assets/avatars/ ----
```
So, we can see, that the directory "/monthly" was discovered by `dirb`.

**What is the name of the log file that was discovered?**

By applying the `gobuster` tool we can enumerate directories and files on the
webserver that might not be known yet:
```text
$ gobuster dir --url http://<MACHINE_IP_ADDRESS> -w /usr/share/wordlists/\
    SecLists/Discovery/Web-Content/common.txt

/assets (Status: 301)
/contact (Status: 200)
/customers (Status: 302)
/development.log (Status: 200)
/monthly (Status: 200)
/news (Status: 200)
/private (Status: 301)
/robots.txt (Status: 200)
/sitemap.xml (Status: 200)
```
As we already saw previously too the log file `/development.log` was found here.

[^1]: https://tryhackme.com/room/contentdiscovery
[^2]: https://wiki.owasp.org/index.php/OWASP_favicon_database
