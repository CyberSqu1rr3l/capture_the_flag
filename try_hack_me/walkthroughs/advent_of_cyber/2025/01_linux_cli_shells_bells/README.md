```
▌  ▗           ▞▀▖▌  ▜▘     ▞▀▖▌     ▜▜     ▛▀▖   ▜▜    
▌  ▄ ▛▀▖▌ ▌▚▗▘ ▌  ▌  ▐  ▄▄▖ ▚▄ ▛▀▖▞▀▖▐▐ ▞▀▘ ▙▄▘▞▀▖▐▐ ▞▀▘
▌  ▐ ▌ ▌▌ ▌▗▚  ▌ ▖▌  ▐      ▖ ▌▌ ▌▛▀ ▐▐ ▝▀▖ ▌ ▌▛▀ ▐▐ ▝▀▖
▀▀▘▀▘▘ ▘▝▀▘▘ ▘ ▝▀ ▀▀▘▀▘     ▝▀ ▘ ▘▝▀▘ ▘▘▀▀  ▀▀ ▝▀▘ ▘▘▀▀ 
```
In this TryHackMe room, we explore the Linux command-line interface and use it to unveil
Christmas mysteries. [^1]

Which CLI command would you use to list a directory?
-----------------------------------------------------------------------------------------
The `ls` command enables us to list the contents of the current directory. Sometimes, we
want to discover hidden files and directories that start with a dot, and do that with
the `ls -a` command.

What flag did you see inside of the McSkidy's guide?
-----------------------------------------------------------------------------------------
Upon moving to the `Guide` directory, we reveal a hidden file `.guide.txt` that contains
the flag and instructions on checking the `/var/log/` log files with the `grep` command.

Which command helped you filter the logs for failed logins?
-----------------------------------------------------------------------------------------
With the `grep` command, we could look for a specific text inside the logging files.
Since we are interested in failed log in attempts, we can search in the `auth.log` file
for "Failed password" events.

What flag did you see inside the Eggstrike script?
-----------------------------------------------------------------------------------------
McSkidy left a hint in her message, that there is an "Eggsploit" on the server. In order
to find such a malicious exploit, we search for it with `find /home/socmas -name *egg*`
and discover the file under `/home/socmas/2025/eggstrike.sh`. This exploit-like script
copies unique items from the wishlist file to a temory file and then overwrites it with
an eastmas file. This results in the destruction of the wishlist file and thus an
invasion on Christmas preparations.

Which command would you run to switch to the root user?
-----------------------------------------------------------------------------------------
It is possible to switch to the root user with the `sudo su` command. 

Finally, what flag did Sir Carrotbane leave in the root bash history?
-----------------------------------------------------------------------------------------
After gaining root privileges with `sudo su`, we can move to the `/root` home directory
and print the `.bash_history` file to discover the flag and further details on the
exploit execution, in particular the file upload and download.

What is the key for the Side Quest 1 following the note in McSkidy's documents?
-----------------------------------------------------------------------------------------
From the `read-me-please.txt` note, we find out that there are further clues in the
`/home/eddi_knapp/Documents/` directory. For that, we are given the credentials to log in
as `eddi_knapp` with the password `S0mething1Sc0ming` and three more clues, so called
easter eggs, that will combine into a passcode to unlock the encrypted vault.

> 1) I ride with your session, not with your chest of files. Open the little bag your
> shell carries when you arrive.
> 2) The tree shows today; the rings remember yesterday. Read the ledger’s older pages.
> 3) When pixels sleep, their tails sometimes whisper plain words. Listen to the tail.

We are now tasked to find the fragments from these clues, join them together and use the
resulting passcode to decrypt the message.

IDEAS
-----
-> shell session: pstree -aps $$ to display a tree of processes

```
systemd,1
  └─tigervncserver,1346 /usr/bin/tigervncserver -xstartup /usr/bin/mate-session -SecurityTypes VncAuth,TLSVnc -depth 16 -geometry ...
      └─mate-session,1367
          └─mate-terminal,2234 --maximize
              └─bash,2478
                  └─sudo,2487 su mcskidy
                      └─sudo,2488 su mcskidy
                          └─su,2494 mcskidy
                              └─bash,2520
                                  └─su,2994 eddi_knapp
                                      └─bash,2995
                                          └─pstree,3805 -aps 2995
```
This output shows a chain of processes that began with systemd starting a VNC session. Users are switching between each other using sudo and su, likely for privilege escalation or changing user contexts. The final process, pstree, is just being executed to view the hierarchical structure of the running processes.
not suspicious?

https://www.publicdomainpictures.net/en/view-image.php?image=489172

printenv results in:
OLDPWD=/home/eddi_knapp/.secret

-> start up ledger, a command-line accounting system
TBC [^2]

[^1]: https://tryhackme.com/room/linuxcli-aoc2025-o1fpqkvxti
[^2]: https://tryhackme.com/adventofcyber25/sidequest
