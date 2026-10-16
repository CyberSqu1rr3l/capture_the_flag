```
┃ ┃┏━┃┏━┃┃ ┃┏━┛┏━┛━┏┛  ┏━┃┏━┃┏━ ┏━┛┏━┃┏┏ ┃┃┃┏━┃┏━┃┏━┛
┏━┃┏━┃┏┏┛┃ ┃┏━┛━━┃ ┃   ┏┏┛┏━┃┃ ┃━━┃┃ ┃┃┃┃┃┃┃┏━┃┏┏┛┏━┛
┛ ┛┛ ┛┛ ┛ ┛ ━━┛━━┛ ┛   ┛ ┛┛ ┛┛ ┛━━┛━━┛┛┛┛━━┛┛ ┛┛ ┛━━┛
```
Your incident-response team recovered a suspicious Linux executable named harvest from a
compromised server. The sample appears to collect host information, upload data over FTP,
and encrypt files before leaving a ransom note. [^1]


Perform static analysis of the provided binary to uncover its configuration, encryption 
logic, signal handling, and self-deletion behavior.
-----------------------------------------------------------------------------------------
**What is the hardcoded 4-digit victim ID embedded in the binary and used to name its
on-disk artifacts?**

**What is the absolute path of the file where the malware writes collected system 
information before exfiltration?**

**Which command-line option supplies the list of file extensions the ransomware targets 
for encryption?**

**What system file does the malware read to enumerate user accounts on the victim host?**

**What printf-style format string does the ID-generation function use to serialise its 
random value into the 5-byte buffer it allocates?**

**When the confirm flag is nonzero and quit is clear, what signal number causes the 
malware to clear confirm instead of requesting traversal to stop?**

**What is the chunk size in bytes passed to `read()` during the per-file encryption 
loop?**

**What .onion hostname string is embedded in the ransom note the sample writes to the 
victim's home directory?**

**What command-line flag must be passed to prevent the malware from deleting itself after
execution?**

**What character is used to replace spaces in filenames before FTP upload?**


[^1]: https://app.letsdefend.io/challenge/harvest-ransomware
