```
 (                                                       (                            
 )\ )                  )         (                       )\ )                      )  
(()/(  (    )       ( /(  (      )\            (        (()/(  (  (  ( (     (  ( /(  
 /(_))))\  (     (  )\())))\  ((((_)(  (  (   ))\(  (    /(_))))\ )\))()(   ))\ )\()) 
(_)) /((_) )\  ' )\(_))//((_)  )\ _ )\ )\ )\ /((_)\ )\  (_)) /((_|(_))(()\ /((_|_))/  
| _ (_)) _((_)) ((_) |_(_))    (_)_\(_|(_|(_|_))((_|(_) | _ (_))  (()(_|(_|_)) | |_   
|   / -_) '  \() _ \  _/ -_)    / _ \/ _/ _|/ -_|_-<_-< |   / -_)/ _` | '_/ -_)|  _|  
|_|_\___|_|_|_|\___/\__\___|   /_/ \_\__\__|\___/__/__/ |_|_\___|\__, |_| \___| \__|  
                                                                 |___/                
```
On February 18, 2025, Margaret was browsing the web looking for Thanksgiving recipes when 
her browser suddenly displayed a full-screen warning. The page claimed her computer was 
infected with viruses and locked her browser. Frightened, Margaret called the phone 
number displayed on the screen. A man answered and  claimed to be from Microsoft 
Support. He convinced her that hackers were actively stealing her information and she
needed to act immediately.
The man instructed her to download a program that would let him "fix" the problem 
remotely. Once connected, he spent over an hour "cleaning" her computer while showing her
scary-looking windows and error messages. At the end, he demanded $500 for a "protection
plan" and insisted payment be made with gift cards for "security reasons". Margaret drove
to Target, purchased the cards, and read the numbers over the phone. [^1]

Analyze the Chrome browser data and AnyDesk application data.
-----------------------------------------------------------------------------------------
**What is the local AnyDesk ID assigned to the victim's computer?**

From the introduction, we proceed to decompress the 
`/root/Desktop/ChallengeFile/RemoteAccessRegret.zip` archive with the provided password.
After mounting the `intelvol.raw` volume, we are given a file system for the *Margaret*
user and all Windows application data.
By searching for the the *AnyDesk* application mentions in the system, we already discover
a binary `Users/Margaret/AppData/Local/Google/Chrome/User_Data/Default/History` which
seems to be the Chrome browsing history.

**Using the Chrome History database, what was the first website Margaret visited before
encountering the scam?**

From the previous task we already discovered the browsing history binary for Chrome and
proceed to view its most interesting entries with `strings`. Here, we can spot several
URLs ordered from the most recent ones to the oldest visited URLs. Margaret began with
a Google search for Thanksgiving Recipes and clicked on the `www[.]allrecipes[.]com`
domain before IoC can first be spotted. Note, that her search engine query on the Google
domain was the last website that was not involved in the scam.

**What is the domain of the initial malicious redirect that led Margaret to the scam 
page?**

Following her browsing of recipes on the recipes website, Margaret was automatically
redirected to the scam page with the domain `ww1[.]windows-security-alert[.]com`
following in a subsequent redirection to a *Windows Defender Alert* page.

**The scam page was cached by Chrome. Examining the cached HTML file, what phone number was displayed to the victim?**

**What is the AnyDesk ID of the remote machine that connected to Margaret's computer?**

**What alias did the scammer use for their AnyDesk connection?**

**According to the AnyDesk logs, what was the total session duration in seconds?**

**The AnyDesk logs show files were exfiltrated. What is the filename (not full path) of the first file stolen from Margaret's Desktop?**

**How many bytes total were uploaded (exfiltrated) to the remote attacker during the session?**

**How many total URLs were visited during the browsing session on the day of the incident?**

From the previous `grep -r "AnyDesk"` search, we already discovered the binary 
`Users/Margaret/AppData/Local/Google/Chrome/User_Data/Default/History` which contains
data about the browsing history for *Margaret*. Here, we can spot ten URLs starting from
the Thanksgiving recipes on `allrecipes[.]com` to the Windows Security Alerts and then
the attack timeline with the *AnyDesk* download, Bank of America sign-in and finally the
Target gift card purchase.

[^1]: https://app.letsdefend.io/challenge/remote-access-regret
