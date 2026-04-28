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

Task 4
-----------------------------------------------------------------------------------------


Task 5
-----------------------------------------------------------------------------------------


Task 6
-----------------------------------------------------------------------------------------


Task 7
-----------------------------------------------------------------------------------------


Task 8
-----------------------------------------------------------------------------------------


[^1]: https://app.hackthebox.com/sherlocks/Unit42?tab=play_sherlock
[^2]: https://github.com/williballenthin/python-evtx
