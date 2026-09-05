```                                                                                
▄▄▄▖        ▗  ▖        ▐    ▄▄ ▗  ▖         ▄▄     ▐                ▝  ▐       
 ▐   ▖▄ ▗ ▗ ▐  ▌ ▄▖  ▄▖ ▐ ▗ ▝ ▝▌▐▌▐▌        ▐▘ ▘▗ ▗ ▐▄▖  ▄▖  ▄▖  ▖▄ ▗▄  ▐▄▖  ▄▖ 
 ▐   ▛ ▘▝▖▞ ▐▄▄▌▝ ▐ ▐▘▝ ▐▗▘  ▗▄▘▐▐▌▌ ▐      ▝▙▄ ▐ ▐ ▐▘▜ ▐ ▝ ▐▘▝  ▛ ▘ ▐  ▐▘▜ ▐▘▐ 
 ▐   ▌   ▙▌ ▐  ▌▗▀▜ ▐   ▐▜    ▝▌▐▝▘▌          ▝▌▐ ▐ ▐ ▐  ▀▚ ▐    ▌   ▐  ▐ ▐ ▐▀▀ 
 ▐   ▌   ▜  ▐  ▌▝▄▜ ▝▙▞ ▐ ▚ ▝▄▟▘▐  ▌ ▐      ▝▄▟▘▝▄▜ ▐▙▛ ▝▄▞ ▝▙▞  ▌  ▗▟▄ ▐▙▛ ▝▙▞ 
         ▞                                                                      
        ▝▘
```
In this THM special CTF room, we want to help Hack3M reach 3 million subscribers. [^1]

Exploitation
-----------------------------------------------------------------------------------------
**What is the invite code for the `hackme.thm` website?**

We begin by visiting the web application of the target IP address and try to understand
the problem of the unkown invitation code. In the source code of the website, we notice
an `/img/` folder which is accessible and contains multiple images for us to see. Also,
we discover the cookie value of the current session stored in `PHPSESSID` but nothing
further susceptible there. Then, we move on to the `/sign_up.php` page and investigate it
in the developer tools. Along with this PHP script, the web server also sends an 
`invite.js` script from which we can see the instructions on how to get the invite code.
```js
function e() {
    var e = window.location.hostname;
    if (e === "capture3millionsubscribers.thm") {
        var o = new XMLHttpRequest;
        o.open("POST", "inviteCode1337HM.php", true);
        o.onload = function() {
            if (this.status == 200) {
                console.log("Invite Code:", this.responseText)
            } else {
                console.error("Error fetching invite code.")
            }
        };
        o.send()
    } else if (e === "hackme.thm") {
        console.log("This function does not operate on hackme.thm")
    } else {
        console.log("Lol!! Are you smart enough to get the invite code?")
    }
}
```
This script performs a hostname check followed by a hidden HTTP POST request to
`http://capture3millionsubscribers.thm/inviteCode1337HM.php` and prints the server's
response code into the browser's developer console if the hostname was correct. Since we
previously accessed the website over the IP address only, we will now add two entries to
`/etc/hosts` that contain the `<TARGET_IP_ADDRESS> hackme.thm` and
`<TARGET_IP_ADDRESS> capture3millionsubscribers.thm` domains. Having done this, we can
navigate to the `http[://]capture3millionsubscribers[.]thm/sign_up.php` sign up page and
execute the `e()` function. This provokes a POST request to the invite page which
results in us obtaining the desired invitation code.

**What is the password for the user `guest@hackme.thm`?**

After entering the invite code from the previous task in the sign up page, we get the
guest login credentials for `guest@hackme.thm:[REDACTED_PASSWORD]` with which we can
access the dashboard.

**What is the secure token for accessing the admin panel?**

After logging in with the guest credentials from the previous task, we look at the 
cookies in the developer tools of the dashboard and notice am `isVIP` boolean value
which can be set to "true" without further do.  Having done that, we are able to access
the "Training Room 2: Advanced Red Teaming" which normally only subscribers could
deploy. Here, we can try to start the virtual machine but a popup alerts us that this
is only possible for *VIP* users (although we could already access this premium room
with the cookie alteration). However, upon further inspection of the network traffic,
we notice a suspicious GET request to 
`http://capture3millionsubscribers[.]thm/BBF813FA941496FCE961EBA46D754FF3.php`
in which a shell was opened. So, we open this page in a new tab and see the machine
with the *Ubuntu* shell. A quick `ls` listing leads us to read the configuration with
`cat config.php`. In it, we can discover the `$SECURE_TOKEN` to access the admin panel
and the `$urlAdminPanel` which we want to add to `/etc/hosts` with the target IP address
for subsequent access. 

```php
<?php
$SECURE_TOKEN= "[REDACTED]";
$urlAdminPanel= "http://admin1337special.hackme.thm:40009";
?>
```

**What is the flag value after enabling the registration feature and getting 3M 
subscribers on the platform?**

After having added the domain of the admin panel without the port from the previous task
in `/etc/hosts`, we can navigate to the admin panel URL and are automatically redirected 
to  `http://admin1337special.hackme.thm:40009/public/html/login`. This seems to be the
new root directory of the webserver for which we don't have access however. So, we fire
up a `gobuster` query to find out any hidden pages for the URL and are able to spot the
`/login` and `/logout` pages this way.
```sh
gobuster dir -u http://admin1337special.hackme.thm:40009/public/html -w /usr/share/wordlists/dirb/common.txt
```
After navigating to the `login.php` page we are prompted for an authentication code and
choose to submit the secure token from the previous task. With this, we are prompted with
another login screen. At first, we attempt `admin:admin` for the credentials but just
get a popup that either the username or password are invalid. And so, we ...tbc

Detection
-----------------------------------------------------------------------------------------
**How many logs are ingested in the Splunk instance?**


**What is the web hacking tool used by the attacker to exploit the vulnerability on the
website?**


**How many total events were observed related to the attack?**


**What is the observed IP address of the attacker?**


**How many events were observed from the attacker's IP?**


**What is the table used by the attacker to execute the attack?**

[^1]: https://tryhackme.com/room/subscribe
