```
▄▖▌ ▘  ▌ ▘      ▄▖    ▜     ▘    ▄▖     ▌         ▗   ▜   
▙▌▛▌▌▛▘▛▌▌▛▌▛▌  ▌▌▛▌▀▌▐ ▌▌▛▘▌▛▘  ▙▖▌▌▛▌▛▌▀▌▛▛▌█▌▛▌▜▘▀▌▐ ▛▘
▌ ▌▌▌▄▌▌▌▌▌▌▙▌  ▛▌▌▌█▌▐▖▙▌▄▌▌▄▌  ▌ ▙▌▌▌▙▌█▌▌▌▌▙▖▌▌▐▖█▌▐▖▄▌
            ▄▌          ▄▌
```
In this THM room, we want to learn all the components that make up an email. [^1]

Questions
-----------------------------------------------------------------------------------------
**Email dates back to what time frame?**

The invention and first usage of emails dates back to the *1970s* for the ARPANET.

**What port is classified as Secure Transport for SMTP, IMAP and POP3?**

The SMTP, i.e. *Simple Mail Transfer Protocol*, is utilized to handle the sending of
emails and it is recommended to uses port 465 for the secure transport. The POP3, i.e.
*Post Office Protocol* and IMAP, i.e. *Internet Message Access Protocol* are responsible
for transferring emails between a client and mail server (they differ when it comes to
the email storage location on a single device as in POP3 or server as in IMAP for later
synchronization). The recommended secure port for IMAP is 993 and for POP3 it is 995.

**What email header is the same as "Reply-to"? Once you find the sender's IP address,
where can you retrieve more information about the email IP?**

This task relies on the mediatemplate article [^2]. So, we first find out, that the
"Reply-to" return email header is the same as the "Return-Path" email header. It
is then explained, that by looking up the X-Originating-IP header in arin [^3], we
should be given detailed results which ISP or webhost the IP address belongs to.

**In the above screenshots, what is the URI of the blocked image and what is the name
of the PDF attachment?**

The snippets of the HTML code shows the URI `https://i.imgur.com/LSOtDI.png` of the
blocked image along with the name `Payment-updateid.pdf`.

**In the attached virtual machine, view the information in email2.txt and reconstruct
the PDF using the base64 data. What is the text in the PDF?**

Upon opening the email2.txt file, we are presented with the header and content
which is encoded with base64. After copying the content to another file, we can
apply the decoding with `base64 -d base64content.txt > email2.pdf` and after
viewing the content with `less email2.pdf` the flag "THM{BENIGN_PDF_ATTACHMENT}"
presents itself without any further annotations.

**What trusted entity is this email masquerading as? What is the sender's email?
What is the subject line? What is the URL link for "CLICK HERE"?**

Upon opening the email3.eml file, we find two email inside, with the later one
being the suspicious one sent to Alexa. First, the sender's email is stated to
be `supportATteckbe[.]com` and the subject line is encoded in base64 as follows:
```
$ base64 -d
T3JkZXIgUGxhY2VkIDogWW91ciBPcmRlciBJRCBPRDIzMjE2NTcwODkyOTEgUGxhY2VkIFN1Y2Nlc3NmdWxseQ==
Order Placed : Your Order ID OD2321657089291 Placed Successfully
```
Similarly, the *From* header field was encrypted with base64 as well, so the *trusted*
entity from this phishing email is masquerading as is *Home Depot*. The URL link for
the *CLICK HERE* banner is containing repeated characters that can be left out and then
needs to be defanged. Use the CyberChef web tool to apply the "From Quoted Printable"
and "Defang URL" recipes and get this result:
```
hxxp[://]t[.]teckbe[.]com/p/?j3=EOo=wFcEwFHl6EOAyFcoUFVTVEchwFHlUFOo6lVTTDcATE7oUE7AUET==
```

[^1]: https://tryhackme.com/room/phishingemails1tryoe
[^2]: https://mediatemple.zendesk.com/hc/en-us/articles/204643950-Understanding-an-email-header
[^3]: http://www.arin.net/
