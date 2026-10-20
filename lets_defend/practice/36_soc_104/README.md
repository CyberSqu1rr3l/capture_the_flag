```
 ⣏⡉ ⡀⢀ ⢀⡀ ⣀⡀ ⣰⡀   ⢉⡹ ⣎⡁        ⢎⡑ ⡎⢱ ⡎⠑ ⢺  ⣎⣵ ⢇⣸
 ⠧⠤ ⠱⠃ ⠣⠭ ⠇⠸ ⠘⠤   ⠤⠜ ⠣⠜   ⠉⠉   ⠢⠜ ⠣⠜ ⠣⠔ ⠼⠄ ⠫⠜  ⠸
```
This alert was triggered due to recognized malware with the *MITRE ATT&CK* classification
`T1204` [^1] User Execution. We are given the file hash for the potentially malicious
`Invoice.exe` file that was associated with *AdamPRD* on December 1st, 2020.
```text
Event Time : 2020-12-01T10:23:12+03:00
Role : Security Analyst
Alert Type : Malware
File Hash : f83fb9ce6a83da58b20685c1d7e1e546
File Name : Invoice.exe
File Size : 473.00 KB
Device Action : Allowed
Source Address : 10.15.15.18
Source Hostname : AdamPRD
```

SOC104 - Malware Detected
-----------------------------------------------------------------------------------------
Having moved the event to our investigation channel, by taking ownership, we can proceed
to create a ticket and then start the playbook. We begin to search for `Source Address
contains "10[.]15[.]15[.]18"` in the *Log Management* and discover the event.
```text
2020-12-01 08:30:22 | Proxy | 10.15.15.18:49832 -> 92.63.8.47:443 | URL: http://92.63.8.47/
```
This already resembles a communication between the infected host and a *Command & 
Control* (C2) server but we have to verify that.
Next, we proceed to find the malware in VirusTotal [^2] with the given hash and find out
that 63 vendors flagged this file as malicious. This reassures our suspicion, that the
finding we are analyzing, is a *true positive* (TP) indeed and discover the URL from the
logs in the *Memory Pattern URLs* of domains, the malware reaches out to. \
Further, we check out the *Endpoint Security* in our SOC dashboard and search for the
*AdamPRD* user. Here, we see that the machine is not contained and still running but we
can not spot any running processes or past network actions and history. Therefore, the
malware appears to have applied obfuscation mechanisms. This can be observed in the
*MITRE ATT&CK Tactics and Techniques* collected by VirusTotal, were the malware applies
indirect command execution, obfuscated software packaging, hijacks the execution flow
and hides its artifacts. We want to learn more about this malware and can find several
reports about it in the *Community* tab of VirusTotal. We find out that the malware is
part of the *Maze Ransomware* which encrypts files after exfiltrating the data. [^3]
It is highly obfuscated and evades security solutions using signature-based detections.
We learn from this that we must apply further measures, instead of just rule-based
detection and make sure the ransomware does not spread. The name of the file 
`Invoice.exe` suggests, that the victim was infected via a malicious e-mail, which is
the observed entry point of *Maze*. So, the next step would also be to find that
malicius phishing e-mail that *AdamPRD* clicked on and add it to the IoC list. We can
find even more detailed information in an analysis by JoeSandbox [^4], as well as in a
Hybrid Analysis [^5] report. \
Finally, we can fill out the playbook with our findings. For the *Thread Indicator*, we
select *Other*, as *Malware* was discovered in this event. Next, we have to specify
that the malware was not quarantined yet and that it is malware indeed. Further, we set
the C2 as requested and proceed to quarantine the *AdamPRD* machine. Then, we provide
the following artifacts and write our analyst notes.

```text
f83fb9ce6a83da58b20685c1d7e1e546 - Malicious File Hash (Invoice.exe) - MD5 Hash
http://92.63.8.47/ - C2 Destination URL Address - URL Address
10.15.15.18 - Infected Host Source Address - IP Address
```

> The investigation identified `Invoice.exe` as malicious, with 63 antivirus vendors
> flagging the file on VirusTotal. The file belongs to the Maze Ransomware campaign
> and was first observed on the AdamPRD host, which was not quarantined prior to this
> analysis. Network log analysis confirmed that the affected endpoint communicated
> with the C2 server at `92.63.8.47` via a HTTP POST request. Since the malware is
> known to encrypt files, delete volume shadow copies, steal browser information, and
> potentially spread across the network, further action must be taken to prevent a
> ransomware attack. Initial IoCs were collected, but it is yet to find out how the
> malware was obtained due to advanced obfuscation techniques. The host was contained
> during the investigation and is to be cleaned of the affected breach. This alert
> should be handled with high priority due to its potentially destructive capabilities.

With this, we can submit the case report and classify it as a *true positive*. The
follow-up actions should include finding the source of the malware download, checking
for persistence mechanisms and finding out why the host was not affected by the
ransomware already.

[^1]: https://attack.mitre.org/techniques/T1204/
[^2]: https://www.virustotal.com/gui/file/e8a091a84dd2ea7ee429135ff48e9f48f7787637ccb79f6c3eb42f34588bc684
[^3]: https://malpedia.caad.fkie.fraunhofer.de/details/win.maze
[^4]: https://www.joesandbox.com/analysis/1838802/0/html
[^5]: https://hybrid-analysis.com/sample/e8a091a84dd2ea7ee429135ff48e9f48f7787637ccb79f6c3eb42f34588bc684
