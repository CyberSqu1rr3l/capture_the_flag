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

We open the `harvest` binary in a new *Ghidra* project in the VM and proceed to 
automatically analyze it. Having done this, we can investigate the `main()` function
which lists `id = &DAT_00107246`. Therefore, it becomes clear to us, to click on that
memory snippet and thus get a reference to the four digit victim ID.

```text
                             DAT_00107246                  XREF[2]:     main:00103e60(*), 
                                                                        main:00103e75(*)  
        00107246 31              ??         31h    1
        00107247 36              ??         36h    6
        00107248 30              ??         30h    0
        00107249 36              ??         36h    6
        0010724a 00              ??         00h
```

**What is the absolute path of the file where the malware writes collected system 
information before exfiltration?**

After calculating the file's MD5 hash using the `HashMyFiles.exe` in the Virtual Machine, 
we can query the hash in VirusTotal [^2] which provides us with further information on 
the *harvest* binary. In particular, under *files dropped* in the behaviour section of 
the ransomware, we can spot the file `/tmp/1606.txt` which appears to be the absolute 
path of the temporary storage location before the exfiltration. We could have also found
out that information in the static analysis of the binary in *Ghidra*, but through
VirusTotal we also found out several reports in the community tab, that give us an
interesting backstory to this exercise. We find out that the `harvest` ransomware was
part of a *Conti* campaign from a real-life incident [^4] to which researchers already 
put up several YARA rules in order to protect systems. [^3] Further, we can read the
analysis of the *ESXi* variant and forensics [^5] and watch a dynamic execution 
demo. [^6]

**Which command-line option supplies the list of file extensions the ransomware targets 
for encryption?**

Following the data stream from the first task, we further discover the `DAT_0010726b`
array containing the string *exts* which makes us suspicious of the command-line option
to supply a list of file extensions that the ransomware targets for encryption.

**What system file does the malware read to enumerate user accounts on the victim host?**

Following the analysis in VirusTotal of the binary, we are informed via the following 
insight that this file is malicious.
From this we are already informed about the name of the file, from which extensive system
metadata is collected.

> The analyzed ELF binary is a Linux ransomware sample that performs both data
> exfiltration and file encryption. The malware first gathers extensive system metadata,
> including hardware specifications, environment variables, and the contents of
> '/etc/passwd', saving this to a temporary file (e.g., '/tmp/1606.txt'). It then
> recursively traverses the filesystem (targeting '/home/') to exfiltrate files to a
> remote FTP server (92.255.57.58) using libcurl. Following exfiltration, it encrypts
> user files using AES-256-CBC and RSA (OpenSSL) and appends a custom extension. Finally,
> it drops a ransom note ('README') containing extortion demands and instructions to
> contact the attackers via a Tor-based leak site (kd24u5e4ggp2m4k4w23lm5fu1...). The
> binary also includes a self-deletion ('destruct') feature to hinder forensics. [^2]

**What printf-style format string does the ID-generation function use to serialise its 
random value into the 5-byte buffer it allocates?**

In the ID-generation function `lp_generate_id.c`, we can spot the printf formatting 
"%04d" that serialises the random value `iVar2 = rand()` into a five byte buffer.

```c
snprintf(__s,5,"%04d",(ulong)(uint)(iVar2 % 10000));                          
```

**When the confirm flag is nonzero and quit is clear, what signal number causes the 
malware to clear confirm instead of requesting traversal to stop?**

The signal number to clear confirm is two instead of stopping the requesting which can
be seen in `lp_traverser_free()`.

**What is the chunk size in bytes passed to `read()` during the per-file encryption 
loop?**

After opening `lp_encrypt_handler.c` and searching for the `read()` function, we can
spot the following line, that allocates *0x100*, i.e. *4096* bytes of memory for the
incoming data in the per-file encryption loop.

```c
uVar5 = read(local_144c,local_1018,0x1000);
```

**What .onion hostname string is embedded in the ransom note the sample writes to the 
victim's home directory?**

In the decompiled `main()` method by Ghidra, we can discover the creation of a
ransomware notice through a *README* file that contains the following text with an
onion link address to send the ransom money to.

> Attention!!! Your servers are all encrypted. And We have downloaded all you data.
> Contact us or we will leak your data on internet.
> Open kd24u5e4ggp2m4k4w23lm5fu1[REDACTED].onion in the Tor
> Browser.

**What command-line flag must be passed to prevent the malware from deleting itself after
execution?**

We already found out about the `--destruct` flag in the VirusTotal insight from task
four. But, we can also spot it in the `decompiled_main_harvest.c` and a listing of the
clear-text strings in `clear_text_strings_harvest.txt` with a description to self
destruct (delete) the program.

**What character is used to replace spaces in filenames before FTP upload?**

Commonly, we would use an underscore (_) to replace spaces in filenames before a FTP
upload and so it is the case here too.

[^1]: https://app.letsdefend.io/challenge/harvest-ransomware
[^2]: https://www.virustotal.com/gui/file/54f17a9549c48a2c27c061ef16d1c51d89cc19d32b3b71b772ab531f296a4376/detection
[^3]: https://valhalla.nextron-systems.com/info/rule/SUSP_LNX_Ransomware_Dec22_2
[^4]: https://www.fortiguard.com/threat-signal-report/4736/new-conti-ransomware-campaign-observed-in-the-wild-1
[^5]: https://www.trellix.com/blogs/research/conti-group-targets-esxi-hypervisors-with-its-linux-variant/
[^6]: https://www.youtube.com/watch?v=f6qKmbCOveU
