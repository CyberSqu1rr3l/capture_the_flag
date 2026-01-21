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
hash value and we can check our mail inbox for the flag and next steps.

What is the second flag you receive after successfully detecting sample2.exe?
-----------------------------------------------------------------------------------------
The new email informs us that solely relying on hashes for detection mechanisms is not
always enough as an adversary simply has to change a single bit in the file, and the
detection rule will fail. Again, we upload the `sample2.exe` in the *Malware Sandbox*

What is the third flag you receive after successfully detecting sample3.exe?
-----------------------------------------------------------------------------------------

What is the fourth flag you receive after successfully detecting sample4.exe?
-----------------------------------------------------------------------------------------

What is the fifth flag you receive after successfully detecting sample5.exe?
-----------------------------------------------------------------------------------------

What is the final flag you receive from Sphinx?
-----------------------------------------------------------------------------------------


[^1]: https://tryhackme.com/room/summit
