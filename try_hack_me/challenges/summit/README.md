```
      ___           ___           ___           ___                             
     /  /\         /__/\         /__/\         /__/\        ___           ___   
    /  /:/_        \  \:\       |  |::\       |  |::\      /  /\         /  /\  
   /  /:/ /\        \  \:\      |  |:|:\      |  |:|:\    /  /:/        /  /:/  
  /  /:/ /::\   ___  \  \:\   __|__|:|\:\   __|__|:|\:\  /__/::\       /  /:/   
 /__/:/ /:/\:\ /__/\  \__\:\ /__/::::| \:\ /__/::::| \:\ \__\/\:\__   /  /::\   
 \  \:\/:/~/:/ \  \:\ /  /:/ \  \:\~~\__\/ \  \:\~~\__\/    \  \:\/\ /__/:/\:\  
  \  \::/ /:/   \  \:\  /:/   \  \:\        \  \:\           \__\::/ \__\/  \:\ 
   \__\/ /:/     \  \:\/:/     \  \:\        \  \:\          /__/:/       \  \:\
     /__/:/       \  \::/       \  \:\        \  \:\         \__\/         \__\/
     \__\/         \__\/         \__\/         \__\/                            
```
This THM challenge we chase a simulated adversary up the Pyramid of Pain until they
finally back down. Following the Pyramid of Pain's ascending priority of indicators, our
objective is to increase the simulated adversaries' cost of operations and chase them
away for good. Each level of the pyramid allows us to detect and prevent various
indicators of attack. [^1]

What is the first flag you receive after successfully detecting sample1.exe?
-----------------------------------------------------------------------------------------
After starting the target machine, we navigate to the provided link and discover an
interface with a mail application, malware sandbox, firewall manager, dns filter and
sigma rule builder. The first email describes the penetration test, we are about to
perform. Upon clicking on the attached `sample1.exe` executable, we are redirected to the
*Malware Sandbox* where we can submit the file for analysis on a *Windows 10x64 v1803*
system. The analysis results in suspicious activity to connect to an unusual port and
usage of Metasploit, leading to the assumption that this sample is a Trojan. Next, we
can copy the SHA256 value and paste it in the search bar of the *Detect Hashes* tab.
After entering the hash value for the malware sample and selecting the hash algorithm
SHA256, we have successfully added the potentially malicious file to the blocklist.
This has prevented `sample1.exe` from executing in the future by detecting its unique
hash value and we can check our mail for the flag and next steps.

What is the second flag you receive after successfully detecting sample2.exe?
-----------------------------------------------------------------------------------------
The new email informs us that solely relying on hashes for detection mechanisms is not
always enough as an adversary simply has to change a single bit in the file, and the
detection rule will fail. Again, we upload the `sample2.exe` in the *Malware Sandbox*,
but this time we investigate the network activity. In here, we find out that the malware
sample establishes connection to the *Autonomous System Number* (ASN) "Intrabuzz Hosting
Limited". Therefore, we want to prevent this HTTP request and copy the IP address to then
paste into the firewall rule destination IP. The firewall rule we want to create is going
to *deny* any outgoing, i.e. *egress*, traffic from *any* source IP to the malicious
destination IP address from the sample analysis. After having done this, we have set a
firewall rule that prevents `sample2.exe` from connecting to the penetration tester's
*command-and-control* (C2) server.

What is the third flag you receive after successfully detecting sample3.exe?
-----------------------------------------------------------------------------------------
The new mail in our inbox informs us that we successfully found the IP address to which
the malware sample was connected to. Now, we begin by scanning the new malware sample
`sample3.exe` in our malware sandbox. In the DNS requests, we find a suspicious domain
besides the `services[.]microsoft[.]com` that we copy for the DNS filter tab of
PicoSecure. While creating a new DNS rule, we also need to specify the rule name and a
matching category that the sample might belong to. Herefore, we simply select the
*malware* category as the trojan we investigated earlier does not have any other visible
use-case. Thus, we get the third flag in a new email.

What is the fourth flag you receive after successfully detecting sample4.exe?
-----------------------------------------------------------------------------------------
This time, we are informed, blocking hashes, IPs, or domains won't help us. Rather, we
want to detect what artifacts or changes the `sample4.exe` leaves on the victim's host
system. There are three modification events in the *Registry Activity* of the malware
analysis. The first one is performed by the `sample4.exe` process, whereas the other two
are performed by the `explorer.exe` and `notepad.exe`. We are obviously interested in the
modification, that the malware sample performs. It writes the value 1 to the following
key to disable real time monitoring:
`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\Real-Time Protection`

In the *Sigma Rule Builder*, we can now create a new sigma rule to focus on *Sysmon Event
Logs* to monitor the malicious system activity. Therefore, we target one that detects
changes to registry keys or values, and select the *Registry Modifications* step. Now, we
input the target registry key from above and the name `DisableRealtimeMonitoring`. Note,
that the targeted registry value is 1 and the *ATT&CK ID* can be classified as `TA0005`,
i.e. Defense Evasion. The final sigma rule validation, can be seen as below and we are
prompted with the fourth flag and an `outgoing_connections.log` in a new email.

```
title: Modification of Windows Defender Real-Time Protection
id: windows_registry_defender_disable_realtime
description: Detects modifications or creations of the Windows Defender Real-Time Protection DisableRealtimeMonitoring registry value.

references:
  - https://attack.mitre.org/tactics/TA0005/

tags:
  - attack.ta0005
  - sysmon

detection:
  selection:
    EventID: 4663
    ObjectType: Key
    ObjectName: 'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\Real-Time Protection'
    NewValue: 'DisableRealtimeMonitoring=1'
  condition: selection

falsepositives:
  - Legitimate changes to Windows Defender settings.

level: high
```

What is the fifth flag you receive after successfully detecting sample5.exe?
-----------------------------------------------------------------------------------------
The last step in the pyramid left us with logging information of the outgoing network
from the last 12 hours on the victim machine. 


What is the final flag you receive from Sphinx?
-----------------------------------------------------------------------------------------


[^1]: https://tryhackme.com/room/summit
