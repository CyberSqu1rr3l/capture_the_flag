```
 __                                  _     ___ _     _     _           _                 __ _            
/ _\_ __   __ _ _ __  _ __   ___  __| |   / _ \ |__ (_)___| |__       (_)_ __   __ _    / /(_)_ __   ___ 
\ \| '_ \ / _` | '_ \| '_ \ / _ \/ _` |  / /_)/ '_ \| / __| '_ \ _____| | '_ \ / _` |  / / | | '_ \ / _ \
_\ \ | | | (_| | |_) | |_) |  __/ (_| | / ___/| | | | \__ \ | | |_____| | | | | (_| | / /__| | | | |  __/
\__/_| |_|\__,_| .__/| .__/ \___|\__,_| \/    |_| |_|_|___/_| |_|     |_|_| |_|\__, | \____/_|_| |_|\___|
               |_|   |_|                                                       |___/
```
In this THM challenge, we apply learned skills to probe malicious emails and URLs,
exposing a vast phishing campaign. [^1]

Who is the individual who received an email attachment containing a PDF?
-----------------------------------------------------------------------------------------
In the `phishing-emails` folder on the desktop, we discover five emails, that we can
investigate with `thunderbird`. For this task, we want to discover an email with an
attached PDF file, so we use `grep -r "pdf"`  to find such an email and are prompted with
*Quote for Services Rendered processed on June 29 2020 100132 AM.eml*. Upon opening this
email in `thunderbird`, we can then see the individual for whom the email with the
"Quote.pdf" attachment was addressed.

What email address was used by the adversary to send the phishing emails?
-----------------------------------------------------------------------------------------
In the *from* header of the emails, we can discover the sender's email address who sent
all the phishing emails with the name "Group Marketing Online Accounts Payable".

What is the redirection URL to the phishing page for Zoe Duncan?
-----------------------------------------------------------------------------------------
For this task, we open the phising email direct at Zoe Duncan, i.e. "Group Marketing
Online Direct Credit Advice - zoe[.]duncan[@]swiftspend[.]finance.eml" and discover a
"Direct Credit Advice" HTML file, which upon inspecting it in a file editor, redirects
to a malicious URL which appears to be a fake *Office 365* instance. It can also be noted
that the redirection link for every user contains a HTML parameter with the victim's
email address, possibly used for identifying them.

What is the URL to the .zip archive of the phishing kit?
-----------------------------------------------------------------------------------------
In our controlled attacking machine, we visit the spam website, the `/data/` directory to
be exact. Here, we discover a ZIP archive and log the defanged full file path to this
archive as our flag. Further, if we follow the directory path for the unzipped folder,
there is a `log.txt` file with sensitive user passwords and their matching email address.  

What is the SHA256 hash of the phishing kit archive?
-----------------------------------------------------------------------------------------
For this, we download the suspicious ZIP file from the previous discovery, and are then
able to obtain the SHA256 hash with the command `sha256sum` followed by the name of the
archive.
  
When was the phishing kit archive first submitted?
-----------------------------------------------------------------------------------------
We can use the SHA256 hash from the last result to submit to the public knowledge website
*VirusTotal* [^2] under the search bar.


When was the SSL certificate the phishing domain used to host the phishing kit archive first logged?
-----------------------------------------------------------------------------------------

What was the email address of the user who submitted their password twice?
-----------------------------------------------------------------------------------------
From our previous directory traversal, we already discovered the log file in task four.
This file collects all the user credentials, one of which entered their password twice.
In the first and third log entry, we can view this email address.

What was the email address used by the adversary to collect compromised credentials?
-----------------------------------------------------------------------------------------

The adversary used other email addresses in the obtained phishing kit. What is the email address that ends in "@gmail.com"?
-----------------------------------------------------------------------------------------

What is the hidden flag?
-----------------------------------------------------------------------------------------

[^1]: https://tryhackme.com/room/snappedphishingline
[^2]: 
