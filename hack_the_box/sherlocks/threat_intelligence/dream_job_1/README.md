```
:::::::::  :::::::::  ::::::::::     :::     ::::    ::::       ::::::::::: ::::::::  :::::::::         :::   
:+:    :+: :+:    :+: :+:          :+: :+:   +:+:+: :+:+:+          :+:    :+:    :+: :+:    :+:      :+:+:   
+:+    +:+ +:+    +:+ +:+         +:+   +:+  +:+ +:+:+ +:+          +:+    +:+    +:+ +:+    +:+        +:+   
+#+    +:+ +#++:++#:  +#++:++#   +#++:++#++: +#+  +:+  +#+          +#+    +#+    +:+ +#++:++#+         +#+   
+#+    +#+ +#+    +#+ +#+        +#+     +#+ +#+       +#+          +#+    +#+    +#+ +#+    +#+        +#+   
#+#    #+# #+#    #+# #+#        #+#     #+# #+#       #+#      #+# #+#    #+#    #+# #+#    #+#        #+#   
#########  ###    ### ########## ###     ### ###       ###       #####      ########  #########       #######
```
You are a junior threat intelligence analyst at a Cybersecurity firm. You have been
tasked with investigating a Cyber espionage campaign known as Operation Dream Job.
The goal is to gather crucial information about this operation. [^1]

Task 1
-----------------------------------------------------------------------------------------
**Who conducted Operation Dream Job?**

At first, we download the archived file and upon extracting the only text file from it,
we are prompted with three hashes. This leads us to enter them in the VirusTotal search
bar, where we are informed about their malicious nature. [^2] Here, we can already
discover the `lazarus.doc` in the information and get suspicious that this might be a
file sponsored by the North Korean state. And indeed, by searching for the name of the
phishing campaign "Salary_Lockheed_Martin_job_opportunities_confidential" in a search
engine, we are prompted with several articles on operation dream job's malware analysis.
For example, in a news article [^3], we are informed about the fake Lockheed Martin job
offering phishing campaign, as it was conducted by the state-sponsored, North
Korean hacking group. This hacking group has been famous in the past for the notorious
*WannaCry* ransomware outbreak, million-dollar Bangladesh bank heist and Sony breach, to
name a few. [^4]

Task 2
-----------------------------------------------------------------------------------------
**When was this operation first observed?**

Finally, we search for *Operation Dream Job* directly in a search engine, and discover
a *MITRE ATT&CK* campaign entry. [^5]

Task 3
-----------------------------------------------------------------------------------------
**There are 2 campaigns associated with Operation Dream Job. One is Operation North
Star, what is the other?**

In the previous campaign entry, we can directly see the first seen date, as well as the
associated campaign descriptions.

Task 4
-----------------------------------------------------------------------------------------
**During Operation Dream Job, there were the two system binaries used for proxy
execution. One was `Regsvr32`, what was the other?**

In the campaign description, we search for the `Regsvr32` binary and discover it along
with another system binary proxy execution of malware in the form of a *Dynamic Link
Library* (DLL) file.

Task 5
-----------------------------------------------------------------------------------------
**What lateral movement technique did the adversary use?**

For that, we want to open the *ATT&CK Navigation Layers* [^6] for the Operation Dream
Job attack in a separate tab. In here, we can move to the *Lateral Movement* techniques
and find out phishing sub-category that was used on the organization.

Task 6
-----------------------------------------------------------------------------------------
**What is the technique ID for the previous answer?**

By hovering over the lateral movement technique in the navigation layers, we can find out
the ATT&CK technique ID.

Task 7
-----------------------------------------------------------------------------------------
**What Remote Access Trojan did the Lazarus Group use in Operation Dream Job?**

Task 8
-----------------------------------------------------------------------------------------
**What technique did the malware use for execution?**

Again, in the MITRE ATT&CK navigation layers view [^6], we can move to the *Execution*
techniques, and identify how the victim's User-Agent could be obtained and used to
connect to their *Command and Control* (C2) server.

Task 9
-----------------------------------------------------------------------------------------
**What technique did the malware use to avoid detection in a sandbox?**

Task 10
-----------------------------------------------------------------------------------------
**To answer the remaining questions, utilize VirusTotal and refer to the IOCs.txt file.
What is the name associated with the first hash provided in the IOC file?**

Task 11
-----------------------------------------------------------------------------------------
**When was the file associated with the second hash in the IOC first created?**

Task 12
-----------------------------------------------------------------------------------------
**What is the name of the parent execution file associated with the second hash in the
IOC?**

Task 13
-----------------------------------------------------------------------------------------
**Examine the third hash provided. What is the file name likely used in the campaign that
aligns with the adversary's known tactics?**

Task 14
-----------------------------------------------------------------------------------------
**Which malicious URL in the contacted URLs is used to fetch a secondary .docx file?**

[^1]: https://app.hackthebox.com/sherlocks/Dream%2520Job-1?tab=play_sherlock
[^2]: https://www.virustotal.com/gui/file/0160375e19e606d06f672be6e43f70fa70093d2a30031affd2929a5c446d07c1/details
[^3]: https://www.zdnet.com/article/lazarus-hackers-target-defense-industry-with-fake-lockheed-martin-job-offers/
[^4]: https://en.wikipedia.org/wiki/Lazarus_Group
[^5]: https://attack.mitre.org/campaigns/C0022/
[^6]: https://mitre-attack.github.io/attack-navigator//#layerURL=https%3A%2F%2Fattack.mitre.org%2Fcampaigns%2FC0022%2FC0022-enterprise-layer.json
