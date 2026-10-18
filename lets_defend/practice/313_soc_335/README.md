```
 ⣏⡉ ⡀⢀ ⢀⡀ ⣀⡀ ⣰⡀   ⢉⡹ ⢺  ⢉⡹        ⢎⡑ ⡎⢱ ⡎⠑ ⢉⡹ ⢉⡹ ⣏⡉
 ⠧⠤ ⠱⠃ ⠣⠭ ⠇⠸ ⠘⠤   ⠤⠜ ⠼⠄ ⠤⠜   ⠉⠉   ⠢⠜ ⠣⠜ ⠣⠔ ⠤⠜ ⠤⠜ ⠤⠜
```
This alert was triggered due to unusual or suspicious patterns of behavior linked to the
identified hash, indicating potential exploitation of CVE-2024-49138. Its type is
classified to be a *Privilege Escalation* attack with a medium difficulty rating.

```text
Event Time : 2025-01-22T02:37:00+03:00
Role : Security Analyst
MITRE ATT&CK : T1059.001 T1055 T1068 T1548 T1110
Hostname : Victor
File Hash : b432dcf4a0f0b601b1d79848467137a5e25cab5a0b7b1224be9d3b6540122db9
Ip Address : 172.16.17.207
Process ID : 7640
Command Line : \??\C:\Windows\system32\conhost.exe 0xffffffff -ForceV1
Process Name : svohost.exe
Process Path : "C:\temp\service_installer\svohost.exe"
Process User : EC2AMAZ-ILGVOIN\LetsDefend
Device Action : Allowed
Parent Process : C:\Windows\System32\WINDOWSPOWERSHELL\V1.0\powershell.exe
```

SOC335 - CVE-2024-49138 Exploitation Detected
-----------------------------------------------------------------------------------------
By taking ownership of the incident, we move the event to our investigation channel
and aim to determine if it was a *true positive* (TP) or *false positive* (FP). We begin
by copying the file hash into VirusTotal [^1] and immmediately discover that 50 vendors
flagged this file as malicious. This strengthens our assumption that this is a TP indeed
and proceed to create a ticket for this event. By creating a playbook we are then asked
to define the threat indicator. Here, we select "Unknown or unexpected services and
applications configured to launch automatically on system boot" because `svohost.exe` is
an anomalous process, closely resembling the legitimate *Service Host* `svchost.exe`.
This core part of Windows is often used by Malware to mislead high CPU consumption
suspicion. [^2] However, since we already checked the file signature, we know that our
lookalike `svohost.exe` file is malicious by nature and we must proceed to quarantine it
and all it's entry points from our system. For that, we check for the IP address in the
log management of or SOC dashboard ... tbc



[^1]: https://www.virustotal.com/gui/file/b432dcf4a0f0b601b1d79848467137a5e25cab5a0b7b1224be9d3b6540122db9
[^2]: https://malwaretips.com/blogs/svchost-exe-service-host-is-it-a-virus-or-a-legit-windows-process/
