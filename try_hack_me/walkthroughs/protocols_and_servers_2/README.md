```
┏┓          ┓        ┓  ┏┓             ┏┓
┃┃┏┓┏┓╋┏┓┏┏┓┃┏  ┏┓┏┓┏┫  ┗┓┏┓┏┓┓┏┏┓┏┓┏  ┏┛
┣┛┛ ┗┛┗┗┛┗┗┛┗┛  ┗┻┛┗┗┻  ┗┛┗ ┛ ┗┛┗ ┛ ┛  ┗━
```
Learn about attacks against passwords and cleartext traffic and explore options for
mitigation via SSH and SSL/TLS. [^1]

Task 2 - Sniffing Attack
-----------------------------------------------------------------------------------------
**What do you need to add to the command `sudo tcpdump` to capture only Telnet traffic?**

Telnet typically runs on port *23*, so we want to add this to the command.

**What is the simplest display filter you can use with Wireshark to show only IMAP
traffic?**

We can use the `imap` filter in Wireshark to show only IMAP traffic.

Task 3 - MITM Attack
-----------------------------------------------------------------------------------------
**How many different interfaces does Ettercap offer?**

In the about section of the ettercap website, we can see that it offers *three*
interfaces, the command-line, GUI, and NCURSES.

**How many ways can you invoke Bettercap?**

Similarly, we find out that the bettercap tool can be invoked with a Web UI, an
interactive mode and scripting.

Task 4 - TLS
-----------------------------------------------------------------------------------------
**What is the three-letter acronym of the DNS protocol that uses TLS?**

*DNS over TLS* (DoT) is the network security protocol for encrypting and wrapping *Domain
Name System* (DNS) queries and answers via the *Transport Layer Security* (TLS).

Task 5 - SSH
-----------------------------------------------------------------------------------------
**Use SSH to connect to the target IP as mark with the password XBtc49AB.
Using `uname -r`, find the Kernel release.**


We use the command `ssh mark@<TARGET_IP_ADDRESS>` with the provided password and
then find the kernel release "5.4.0-84-generic" with `uname -r`. 

**Use SSH to download the file `book.txt` from the remote system. How many KBs did `scp`
display as download size?**

Then, we use `scp mark@<TARGET_IP_ADDRESS>:/home/mark/book.txt` and see that 415 KBytes
were downloaded from the server for the eBook of Meditations by Marcus Aurelius.

Task 6 - Password Attack
-----------------------------------------------------------------------------------------
**We learned that one of the email accounts is *lazie*. What is the password used to
access the IMAP service on the target IP address?**

We will use `hydra` with the standard "rockyou.txt" wordlist on the IP address with:
`hydra -l lazie -P /usr/share/wordlists/rockyou.txt <TARGET_IP_ADDRESS> imap`
This way, we find out in seconds, that the password of *lazie* is *butterfly*.


[^1]: https://tryhackme.com/room/protocolsandservers2
