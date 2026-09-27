```
 ________          _        __                     ___                           _    _                      
|_   __  |        (_)      |  ]                  .'   `.                        / |_ (_)                     
  | |_ \_|_ .--.  __   .--.| |  ,--.    _   __  /  .-.  \ _   __  .---.  _ .--.`| |-'__   _ .--..--.  .---.  
  |  _|  [ `/'`\][  |/ /'`\' | `'_\ :  [ \ [  ] | |   | |[ \ [  ]/ /__\\[ `/'`\]| | [  | [ `.-. .-. |/ /__\\ 
 _| |_    | |     | || \__/  | // | |,  \ '/ /  \  `-'  / \ \/ / | \__., | |    | |, | |  | | | | | || \__., 
|_____|  [___]   [___]'.__.;__]\'-;__/[\_:  /    `.___.'   \__/   '.__.'[___]   \__/[___][___||__||__]'.__.' 
                                       \__.'
```
Step into the shoes of a Cyber Threat Intelligence Analyst and put your investigation 
skills to the test. [^1]

Who shared the malware samples?
-----------------------------------------------------------------------------------------
Upon opening the Chrome we browser in our virtual machine, we can already find a bookmark
to the *DocIntel* login screen [^2] with the *ericatracy* credentials saved. Having
logged in, we are shown an urgent email detailing the detected malware samples by an
employee from the Cybersecurity division of *SwiftSpend Finance*. Here, we are informed
that the malware was detected on December 8th, 2023 and infected over 9000 systems. The
nature of the malware is not yet known, but it is suspected to be a *Remote Access 
Trojan* (RAT). 

What is the SHA1 hash of the file `pRsm.dll` inside `samples.zip`?
-----------------------------------------------------------------------------------------
Upon clicking on the email, we can obtain the `samples.zip` archive with the password
*Panda321!*. After extracting the files from the archive, we can open a terminal in the
folder and execute `sha1sum pRsm.dll` to view the SHA1 hash of the *dynamic-link library*
(DLL) file.

Which malware framework utilizes these DLLs as add-on modules?
-----------------------------------------------------------------------------------------
Following the hint, we research for a blog article on the *pRsm dll* and discover the
article on how the "Evasive Panda APT group delivers malware via updates for popular
Chinese software". [^3] Reading the introduction alone already informs us on how the
malware framework is called. Later, the plugins are listed, and we find out, that the
`pRsm.dll` library is responsible for the capture of input and output audio streams.

Which MITRE ATT&CK Technique is linked to using `pRsm.dll` in this malware framework?
-----------------------------------------------------------------------------------------
For this, we can research the modular malware framework from the previous task in the
MITRE ATT&CK collection and search for "capture input and output audio streams" which
the `pRsm.dll` is responsible for. This way, we are refered to the *Audio Capture*
technique with an ID that is the answer to this task.

What is the CyberChef defanged URL of the malicious download location first seen on
2020-11-02?
-----------------------------------------------------------------------------------------
Again, we refer to the blog article [^3] detailing the malicious download locations
according to ESET telemetry and search for the date "2020-11-02". Here, we can observe
the URL and enter it into CyberChef with a defang URL recipe. [^5] 

What is the CyberChef defanged IP address of the C&C server first detected on 2020-09-14
using these modules?
-----------------------------------------------------------------------------------------
After the conclusion of the Evasive Panda APT group campaign detailed in the blog article
we are given several *Indicators of Compromise* (IOC). In the *Network* section, we are
given the IP address that was first seen on "2020-09-14" and is connected to the C&C 
server. In order to defang this IP address, we can simply enclose every dot with `[.]`
brackets.

What is the md5 hash of the spyagent family spyware hosted on the same IP targeting 
Android devices in June 2025?
-----------------------------------------------------------------------------------------
This task asks us to investigate the IP address from the previous tasks and find a
connecting link to another spyware targeting Android devices. We proceed to search for it
in *VirusTotal* [^7] and have a look at the communicating files, one of which is 
targeting Android. Therefore, we investigate this file [^8] further and find out, that it
is targeting Android devices in June 2025 since 2022. The MD5 hash to this file is the
answer to this task because several security vendors label it as *spyware* and *spyagent*
in the Android environment.

[^1]: https://tryhackme.com/room/fridayovertime
[^2]: http://docintel.pandaprobeintelligence.thm/Account/Login
[^3]: https://www.welivesecurity.com/2023/04/26/evasive-panda-apt-group-malware-updates-popular-chinese-software/
[^4]: https://attack.mitre.org/software/S1146/
[^5]: https://cyberchef.org/#recipe=Defang_URL(true,true,true,'Valid%20domains%20and%20full%20URLs')
[^6]: https://cyberchef.org/#recipe=Defang_IP_Addresses()
[^7]: https://www.virustotal.com/gui/ip-address/122.10.90.12/relations
[^8]: https://www.virustotal.com/gui/file/bbef5975a0483220cfec379c44a487ed4146e0af9205f00dbc0eb53de8a63533/details
