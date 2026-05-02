```
'||'  '|'           ||    .     ,       
 ||    |  .. ...   ...  .||.   /|   /\  
 ||    |   ||  ||   ||   ||   / |  (  ) 
 ||    |   ||  ||   ||   ||   __|_   // 
  '|..'   .||. ||. .||.  '|.' ----  //  
                                |  /(   
                               '-' {___ 
```
In this Sherlock, we'll familiarize ourselves with Sysmon logs and various useful
EventIDs for identifying and analyzing malicious activities on a Windows system.
Palo Alto's Unit42 recently conducted research on an UltraVNC campaign, wherein
attackers utilized a backdoored version of UltraVNC to maintain access to systems.
This lab is inspired by that campaign and guides us through the initial access stage of
the campaign. [^1]

Task 1
-----------------------------------------------------------------------------------------
**How many Event logs are there with Event ID 11?**

After downloading the `unit42.zip` file, we try to `unzip` it but get an error message,
that it could not be uncompressed due to method 99. This tells us that the file was
archived using AES, for which `7z x` extraction is favorable.
And indeed, with the 7-Zip extraction command, we are able to extract the
`Microsoft-Windows-Sysmon-Operational.evtx` content.

Since we are on a Linux operating system, we first research how to open a *Windows Event
Log* file. For this task, we rely on `python-evtx`, a pure Python parser for *.evtx*
files. [^2] Now, we use the `evtx_dump.py` script to print the full event logs in human
readable ASCII XML format. This way, we find out the structuring with the *Event ID*
and can directly search for it.
```bash
evtx_dump.py Microsoft-Windows-Sysmon-Operational.evtx | grep '<EventID Qualifiers="">11</EventID>' | nl
```

Task 2
-----------------------------------------------------------------------------------------
**What is the malicious process that infected the victim's system?**

Whenever a process is created in memory, an event with Event ID 1 is recorded with
details such as the command line, hashes, process path, parent process path, etc.
This information is very useful for an analyst because it allows us to see all programs
executed on a system, which means we can spot any malicious processes being executed.
There are six events with the *Event ID* in the logging file, so we print all the
detailed information for each one and analyze them all manually.
```bash
evtx_dump.py Microsoft-Windows-Sysmon-Operational.evtx | grep -A 38 '<EventID Qualifiers="">1</EventID>'
```
In the first event looks normal, as it is a legitimate component of Firefox to send
crash reports in the background. The second event however, is unusual due to the double
*.exe.exe* extension and mismatched naming as a "Photo and vn Installer", yet *Fattura*
later (which Italian for invoice). Further, we can see that it is tagged with *User
Execution*, suggesting that it was manually run, which is common for phishing or malware
components. And indeed, immediately after, the suspicious *.exe.exe* spawns multiple
`msiexec.exe` MSI installer processes, possibly to deploy its payload later.

Task 3
-----------------------------------------------------------------------------------------
**Which Cloud drive was used to distribute the malware?**

For this task, we want to browse the *Sysmon Event ID* 3 for network connections of all
kind. But we can't find a cloud drive being used this way, just an event after the
malware executed, possibly to a *Command and Control* (C2) server.

Finally, we have a look at the hint and are informed that the *Event ID 22* can be used
to look for any *DNS Queries* on the system.
```bash
evtx_dump.py Microsoft-Windows-Sysmon-Operational.evtx | grep -A 38 '<EventID Qualifiers="">22</EventID>'
```
And indeed, in the query name and result fields, we can spot a popular Cloud drive name
that was used for distribution.

Task 4
-----------------------------------------------------------------------------------------
**What was the timestamp changed to for the PDF file?**

For many of the files it wrote to disk, the initial malicious file used a defense evasion
technique called *Time Stomping*, where the file creation date is changed to make it
appear older and blend in with other files. In order to find out such a *File Creation
Time Change*, we search for its *Event ID* in the official Microsoft documentation [^3],
and can then search for it in the event logging file.
```bash
evtx_dump.py Microsoft-Windows-Sysmon-Operational.evtx | grep -A 38 '<EventID Qualifiers="">2</EventID>'
```
However, we can discover quite many such timestamp changes for the malicious file. But
then, we remember to search for the *PDF* file and discover only one such time stomping
action, for which we note the *Creation UTC Time* with seconds.

Task 5
-----------------------------------------------------------------------------------------
**The malicious file dropped a few files on disk. Where was `once.cmd` created on disk?**

Task 6
-----------------------------------------------------------------------------------------
**The malicious file attempted to reach a dummy domain, most likely to check the internet
connection status. What domain name did it try to connect to?**

Task 7
-----------------------------------------------------------------------------------------
**Which IP address did the malicious process try to reach out to?**

Task 8
-----------------------------------------------------------------------------------------
**The malicious process terminated itself after infecting the PC with a backdoored
variant of UltraVNC. When did the process terminate itself?**


[^1]: https://app.hackthebox.com/sherlocks/Unit42?tab=play_sherlock
[^2]: https://github.com/williballenthin/python-evtx
[^3]: https://learn.microsoft.com/en-us/windows/security/operating-system-security/sysmon/sysmon-events
