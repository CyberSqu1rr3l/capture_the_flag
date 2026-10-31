```
┏┓          ┓        ┓  ┏┓             
┃┃┏┓┏┓╋┏┓┏┏┓┃┏  ┏┓┏┓┏┫  ┗┓┏┓┏┓┓┏┏┓┏┓┏  
┣┛┛ ┗┛┗┗┛┗┗┛┗┛  ┗┻┛┗┗┻  ┗┛┗ ┛ ┗┛┗ ┛ ┛  
```
Learn about common protocols such as HTTP, FTP, POP3, SMTP and IMAP, along with related
insecurities. [^1]

Task 2 - Telnet
-----------------------------------------------------------------------------------------
**To which port will `telnet` with the default parameters try to connect?**

In the manpage for the `telnet` command, we can search for the port and see that the
default port is "23" when not otherwise specified.

Task 3 - HTTP
-----------------------------------------------------------------------------------------
**Connect using Telnet on port 80 and retrieve the file "flag.thm".**

First, we wan to connect to port 80 using `telnet <TARGET_IP_ADDRESS> <PORT>`. Then, we
want to type "GET /flag.thm HTTP/1.1" followed by "host: telnet" and press the enter key
twice to get the flag.

Task 4 - FTP
-----------------------------------------------------------------------------------------
**Using an FTP client, connect to the VM and try to recover the flag file with the
credentials. What is the flag?**

FTP servers listen on port 21 by default, so we specify it when connecting to a server
with `telnet <TARGET_IP_ADDRESS> 21`. Then, we provide the username with the "USER frank"
followed by the password "PASS D2xc9CgD" and get logged in. The *STAT* command provides
some additional information and *SYST* shows the system type of the target, e.g. Unix.
The *PASV* switches the mode to passive, and there are two modes for FTP: In the active
mode, the data is sent over a separate channel originating from the FTP server's port 20
and in the passive mode, the data is sent over a separate channel originating from an
FTP client's port number above 1023. The `TYPE A` command switches the file transfer mode
to ASCII and `TYPE I` switches to binary. We cannot transfer a file using a simple client
such as Telnet, because FTP creates a separate connection for the file transfer. Instead,
use the `ftp` client to get the flag with `get ftp_flag.thm`.

Task 5 - SMTP
-----------------------------------------------------------------------------------------
**Connect to the SMTP port of the target VM. What is the flag you get?**

We will connect to the default SMTP port 25 using `telnet` on the target IP and then 
issue `helo hostname` followed by "mail from:" and "rcpt to:" to indicate the sender and
the recipient. Then, we can type the message body and send it.

Task 6 - POP3
-----------------------------------------------------------------------------------------
**Connect to the POP3 port of the VM, how many messages are available?**\

Upon connecting to the default port 110 for POP3, we will authorize as the user "frank"
with the commands "USER frank" and "PASS D2xc9CgD". Then, we can use the *STAT* command
to see, that there are 0 messages with a size of 0 bytes in the inbox, so the response
is "+OK 0 0". Similarly, we can list the empty inbox with *LIST*. If we were to have a
message, we could have opened it with *RETR 1*.

Task 7 - IMAP
-----------------------------------------------------------------------------------------
**What is the default port used by IMAP?**

The default port of the Internet Message Access Protocol (IMAP) is *143*.

[^1]: https://tryhackme.com/room/protocolsandservers
