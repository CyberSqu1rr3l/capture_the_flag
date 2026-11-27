```
______           _        _____ _        _   _         ___              _           _     
| ___ \         (_)      /  ___| |      | | (_)       / _ \            | |         (_)    
| |_/ / __ _ ___ _  ___  \ `--.| |_ __ _| |_ _  ___  / /_\ \_ __   __ _| |_   _ ___ _ ___ 
| ___ \/ _` / __| |/ __|  `--. \ __/ _` | __| |/ __| |  _  | '_ \ / _` | | | | / __| / __|
| |_/ / (_| \__ \ | (__  /\__/ / || (_| | |_| | (__  | | | | | | | (_| | | |_| \__ \ \__ \
\____/ \__,_|___/_|\___| \____/ \__\__,_|\__|_|\___| \_| |_/_| |_|\__,_|_|\__, |___/_|___/
                                                                           __/ |          
                                                                          |___/
```
In this THM room, we want to learn about basic malware analysis techniques without
running the malware. [^1]

Which of them contains the string 'DbgView.exe'?
-----------------------------------------------------------------------------------------
**On the Desktop in the attached VM, there is a directory named 'mal' with malware
samples 1 to 6. Use floss to identify obfuscated strings found in the samples named 2, 5,
and 6.**

We call `pestudio` from the FLARE folder in the application menu and open the malware
samples 1 to 6. Then, we notice the hint that we should use `floss` and do that on the
malware samples 2,5 and 6. Only for the last sample, 6, we find quite a lot of
`DbgView.exe` string occurrences: `> floss --no-static-strings 6`

In the samples located at `Desktop\mal\` directory in the attached VM, which of the
samples has the same imphash as file 3?
-----------------------------------------------------------------------------------------
For this, we rely on `pestudio` and can find out that the malware sample 1 has the same
*imphash* as the third malware sample.

Using the ssdeep utility, what is the percentage match of the above-mentioned files?
-----------------------------------------------------------------------------------------
We want to find out the percentage match of the malware samples and therefore use the
*SSDEEP* tool from the Desktop: `> ssdeep-2.14.1\ssdeep.exe -l -r -d mal\*`

How many matches for anti-VM execution techniques were identified?
-----------------------------------------------------------------------------------------
We use `capa` to analyse the `Desktop\mal\4` file and find out that there are 2 anti-vm
execution techniques to avoid virtual machine detection with 86 matches.

Does the sample have to capability to suspend or resume a thread?
-----------------------------------------------------------------------------------------
Yes, in the name space of the listed capabilities we can see a *resume* and *continue*
thread host interaction functionality for this malware sample.

What MBC behavior is observed against the MBC Objective 'Anti-Static Analysis'?
-----------------------------------------------------------------------------------------
In the anti-static analysis MBC objective we can see the "Disassembler Evasion:: Argument
Obfuscation [B0012.001]" behavior listed.

At what address is the function that has the capability 'Check HTTP Status Code'?
-----------------------------------------------------------------------------------------
The HTTP status code is checked by the function `communication/http/client` and the
address *0x486921* can be found out by setting the (-vv) flag and `less`.

Open the `Desktop\mal\4` in PEstudio. Which library is blacklisted?
-----------------------------------------------------------------------------------------
Here, we can look at the selected libraries and see that the `rpcrt4.dll` marked.

What does this dll do?
-----------------------------------------------------------------------------------------
This library has the description *Remote Procedure Call Runtime*.

[^1]: https://tryhackme.com/room/staticanalysis1
