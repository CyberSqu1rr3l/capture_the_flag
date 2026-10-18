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
log management of or SOC dashboard and discover several unsuccessful login attempts
followed by a successful login as the *Victor* user account. Then we check the *Victor*
host name in the endpoint security of our SOC dashboard and discover that the user is
still running the malware. After indicating that the malware is malicious, we are asked
to check if someone requested the C2 address of the malicious file. And indeed, the C2
server has been accessed with a successful connection following in remote code execution.
Next, we are prompted to contain the user machine in the EDR page and do so for the
*Victor* (`172[.]16[.]17[.]207`) machine. Finally, we can finish the playbook by adding
the following artifacts. For that, we also provide URL from the command execute under the
*Victor* host.

```text
0e66fce898aceb3f3f84e3b8a09d3367 - Malicious File Hash (svohost.exe) - MD5 Hash
172.16.17.207 - C2 Destination Address (Victor) - IP Address
https://files-ld.s3.us-east-2.amazonaws.com - Malicious Service Installer (service-installer.zip) - URL Address
```
For the analysist notes, we write the following and then close the alert with a *true
positive* classification.

> The alert was investigated as a potential exploitation and privilege escalation incident
> on the host Victor. Initial analysis identified a suspicious executable named
> `svohost.exe` located at `C:\\temp\\service\_installer\\svohost.exe`, with the SHA-256
> hash `b432dcf4a0f0b601b1d79848467137a5e25cab5a0b7b1224be9d3b6540122db9`. The process was
> launched by `powershell.exe` rather than the expected `services.exe process`, and its
> name closely resembles the legitimate Windows process `svchost.exe`, suggesting an
> attempt to evade detection but it was flagged as malicious by VirusTotal. A case was
> created in the SOC case management system, and the investigation playbook was initiated.
> Log analysis identified multiple failed authentication attempts from an external IP
> address, followed by a successful login to the Victor account on the eighth attempt.
> Endpoint Security logs showed that `svohost.exe` remained active under PID `7640`,
> indicating that the malicious payload was still executing and had not been quarantined.
> Further investigation of command-line and terminal history revealed that PowerShell was
> used to download and execute the payload. The activity also included account
> enumeration and potential privilege escalation following the download of a ZIP archive.
> The associated download URL and file hash were identified as malicious by threat
> intelligence analysis. The evidence indicates a confirmed compromise, with suspicious
> external authentication, malicious payload execution, and reported communication with a
> command-and-control (C2) infrastructure. These findings support classifying the alert
> as a true positive associated with suspected CVE-2024-49138 exploitation. As the
> malicious process was still running and the host had not been contained, the affected
> system was isolated to prevent further attacker activity and potential lateral
> movement. Relevant artifacts, including the executable hash, external IP address,
> malicious download URL, process details, and authentication events, were documented
> in the case study.

This incident represented a confirmed endpoint compromise involving a malicious executable
delivered and executed through PowerShell. Host containment was initiated to limit further
impact. The follow-up actions should include investigating the source of the successful 
login, reviewing C2 network traffic, validating privilege escalation, checking for 
persistence mechanisms, and performing remediation and credential resets as for *Victor*.

[^1]: https://www.virustotal.com/gui/file/b432dcf4a0f0b601b1d79848467137a5e25cab5a0b7b1224be9d3b6540122db9
[^2]: https://malwaretips.com/blogs/svchost-exe-service-host-is-it-a-virus-or-a-legit-windows-process/
