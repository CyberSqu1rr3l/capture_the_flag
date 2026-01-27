```
______ _          _     _____ _     _  __ _     _____ ___________ 
|  ___(_)        | |   /  ___| |   (_)/ _| |   /  __ \_   _|  ___|
| |_   _ _ __ ___| |_  \ `--.| |__  _| |_| |_  | /  \/ | | | |_   
|  _| | | '__/ __| __|  `--. \ '_ \| |  _| __| | |     | | |  _|  
| |   | | |  \__ \ |_  /\__/ / | | | | | | |_  | \__/\ | | | |    
\_|   |_|_|  |___/\__| \____/|_| |_|_|_|  \__|  \____/ \_/ \_|    
```
This THM challenge, is a beginner-friendly CTF featuring six unique scenarios, starting
from quick warmups and classic SOC investigations, escalating to cases that push well
beyond the typical L1 role. [^1]

[Task 3] Probably Just Fine
-----------------------------------------------------------------------------------------
In the first task, we want to investigate the following alert on the SOC dashboard. The
SOC handover notes did mention, that Susan is going to attend a conference in Singapore
but according to the SOC procedure, we still want to verify each IP address. Thus, we
find out that the IP looks suspicious indeed, and upon contacting Susan, we find out that
she did not log in to the company VPN. While using a public WiFi hotspot at a café, she
was however prompted to install a "security check" tool, which she did.

> Unusual VPN login of susan.martin[@]probablyfine[.]thm from 37[.]19[.]201[.]132
> (Singapore) and a suspicious binary with the hash
> b8e02f2bc0ffb42e8cf28e37a26d8d825f639079bf6d948f8debab6440ee5630.

For this, we are given a threat intelligence database, similar to VirusTotal to check the
reputation and other details of IP addresses, domains and file hashes. The host telemetry
further reveals a suspicious binary with the hash.

### What is the ASN number related to the IP?
First, we run a lookup scan of the IP address with `whois <IP_ADDRESS>` to get the 
*Autonomous System Number* (ASN) number in the origin information. And indeed, we thus
discover the AS followed by the number that we can enter for this task.

### Which service is offered from this IP?
From simply reading the introduction to this task, we are informed what service is
offered from this IP address.

### What is the filename of the file related to the hash?
This task requires us to copy the filehash from the introduction and paste it into the
search bar of *TryDetectThis 2.0* [^2] and from this public knowledge, we can now see the
file name as it is listed under the basic properties.

### What is the threat signature that Microsoft assigned to the file?
Under the *Vendor Analysis* there is also *Microsoft* listed as a vendor and under the
detection name, we can discover the threat signature.

### Based on its HTTPS certificate, how many domains are linked to the same campaign?
One of the contacted domains is part of a large malicious infrastructure cluster. From
the list of contacted domains that the file is communicating with, there are a few that
stand out to be a possible C2 endpoint, payload delivery or secondary redirect. So, we
start by analyzing the domain `gadgethgfub[.]icu` in our custom VirusTotal instance. And
under the HTTPS Certificate Data, we can click on the latest certificate with a whole
list of alternative names, as can be seen in `subject_alternative_names.txt`. The total
amount of alternative names equals the count of domains that are linked to this very same
campaign for this task.

### What line is present in the YARA rule's "condition" field by "kevoreilly"?
For the file hash, there is one YARA rule "Lumma Payload" from the author "kevoreilly".
We further investigate this rule in the GitHub page [^3] and present it below together
with the condition field:
```
rule Lumma {
  meta:
    author = "kevoreilly"
    description = "Lumma Payload"
    cape_type = "Lumma Payload"
    packed = "0ee580f0127b821f4f1e7c032cf76475df9724a9fade2e153a69849f652045f8"
    packed = "23ff1c20b16d9afaf1ce443784fc9a025434a010e2194de9dec041788c369887"
  strings:
    $decode1 = {C1 (E9|EA) 02 [0-3] 0F B6 (44|4C) ?? FF 83 (F8|F9) 3D 74 05 83 (F8|F9) 2E 75 01 (49|4A) [0-30] 2E 75}
    $decode2 = {B0 40 C3 B0 3F C3 89 C8 04 D0 3C 09 77 06 80 C1 04 89 C8 C3 89 C8 04 BF 3C}
    $decode3 = {B0 40 C3 B0 3F C3 80 F9 30 72 ?? 80 F9 39 77 06 80 C1 04 89 C8 C3}
    $decode4 = {89 C8 04 D0 3C 09 77 ?? [3-11] 89 C8 [0-1] C3 89 C8 04 BF 3C 1A 72 ?? 89 C8 04 9F 3C}
  condition:
    uint16(0) == 0x5a4d and any of them
}
```

### What is the title of the TI report mentioning this hash?
In the *Detections and Reports* tab of TryDetectThis 2.0, we can discover the report [^4]
that presents the Lumma infostealer threat analysis. This report analyzes in detail, how
Lumma operates as part of a decentralized cybercrime ecosystem, showing a wide range of
tools and underground services to steal credentials, evade detection, run multiple scams,
and monetize stolen data.

### Which team did the author of the malware start collaborating with in early 2024?
By reading the report, we find out the crucial information on the team, that Lumma began
collaborating with in early 2024. This affiliated SOCKS5 proxies from infected bots, as
the team provided a residential proxy plugin.

### Which mentioned infostealer targets Android systems?
A Mexican-based affiliate related to the malware family also uses other infostealers.
Following the use of additional infostealers alongside Lumma in the article, we also
discover an Android-based *Remote Access Trojan* (RAT), based on Telegram profile images
likely tied to the affiliate.

### Which MITRE ATT&CK sub-technique does this align with?
The report states that the affiliates behind the malware use the services of AnonRDP. In
the *Appendix C - MITRE ATT&CK Techniques*, we discover a listing of techniques and their
matching ATT&CK code. Since this service focuses on VPN's we choose the *Acquire
Infrastructure: Virtual Private Server* sub-tactic to be best aligned with the described
attack on "Probably Just Fine".

[Task 4] Phishing Books
-----------------------------------------------------------------------------------------

[Task 5] Portal Drop
-----------------------------------------------------------------------------------------

[Task 6] Zero Tolerance
-----------------------------------------------------------------------------------------

[Task 7] The Crown Jewel
-----------------------------------------------------------------------------------------

[Task 8] Promotion Night
-----------------------------------------------------------------------------------------

### What was the network share path where ransomware was placed?

### What is the value ransomware created to persist on reboot?

### What was the most likely extension of the encrypted files?

### Which MITRE technique ID was used to deploy ransomware?

### What ports of SRV-ITFS did the adversary successfully scan?

### What is the full path to the malware that performed the Discovery?

### Which artifact did the adversary create to persist on the beachhead?

### What is the MD5 hash of the embedded initial shellcode?

### Which C2 framework was used by the adversary in the intrusion?

### What hostname did the adversary log in from on the beachhead?

### What was the UNC path that likely contained AWS credentials?

### From which IP address did the adversary access AWS?

### Which two sensitive files did the adversary exfiltrate from AWS?

### What file did the adversary upload to S3 in place of the wiped ones?


[^1]: https://tryhackme.com/room/first-shift-ctf
[^2]: https://static-labs.tryhackme.cloud/apps/trydetectthis/
[^3]: https://github.com/kevoreilly/CAPEv2/blob/master/data/yara/CAPE/Lumma.yar
[^4]: https://www.recordedfuture.com/research/behind-the-curtain-how-lumma-affiliates-operate
