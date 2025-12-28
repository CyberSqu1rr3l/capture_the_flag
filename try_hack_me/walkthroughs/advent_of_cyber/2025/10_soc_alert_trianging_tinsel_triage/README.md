```
▞▀▖▞▀▖▞▀▖ ▞▀▖▜       ▐   ▀▛▘  ▗       ▗            ▀▛▘▗          ▜  ▀▛▘  ▗          
▚▄ ▌ ▌▌   ▙▄▌▐ ▞▀▖▙▀▖▜▀   ▌▙▀▖▄ ▝▀▖▞▀▌▄ ▛▀▖▞▀▌ ▄▄▖  ▌ ▄ ▛▀▖▞▀▘▞▀▖▐   ▌▙▀▖▄ ▝▀▖▞▀▌▞▀▖
▖ ▌▌ ▌▌ ▖ ▌ ▌▐ ▛▀ ▌  ▐ ▖  ▌▌  ▐ ▞▀▌▚▄▌▐ ▌ ▌▚▄▌      ▌ ▐ ▌ ▌▝▀▖▛▀ ▐   ▌▌  ▐ ▞▀▌▚▄▌▛▀ 
▝▀ ▝▀ ▝▀  ▘ ▘ ▘▝▀▘▘   ▀   ▘▘  ▀▘▝▀▘▗▄▘▀▘▘ ▘▗▄▘      ▘ ▀▘▘ ▘▀▀ ▝▀▘ ▘  ▘▘  ▀▘▝▀▘▗▄▘▝▀▘
```
In this THM room from the Advent of Cyber 2025 event, we investigate and triage alerts
through Microsoft Sentinel. [^1]

How many entities are affected by the Linux PrivEsc Polkit exploit attempt?
-----------------------------------------------------------------------------------------
The content deployment is located in the Microsoft Azure portal [^2] where we can log in
with one of the usernames and temporary access passwords according to our location. At
first, we get comfortable with the Azure Services and open the Microsoft Sentinel, where
there is one such entry that upon opening lets us browse several threat management tools.
Here, we are interested in the logs and in the table symbol we can select a custom query
`Syslog_CL` that is of particular interest for us.
In Microsoft Sentinel, a *Security Information and Event Management* (SIEM) and *Security
Orchestration, Automation and Response* (SOAR) system, we can further investigate the
incidents in the treat management of the defender portal. Here, we search for the "Linux
PrivEsc Polkit Exploit Attempt" and see that there are *10 assets*, who were affected in
two alerts that affected five devices each. The exposure level of all 10 devices is low
and the risk level is none because the incident is a sign of a potential privilege
escalation attempt that was not successful.

What is the severity of the Linux PrivEsc - Sudo Shadow Access alert?
-----------------------------------------------------------------------------------------
Again, we search for "Linux PrivEsc - Sudo Shadow Access" alert, and discover two such
incidents with the ID 1547 and 1552. This indicates that there were two different stages
of intrusion. In both cases, they are classified with a *high* priority due to the
occurence of sudo commands that read or modify `/etc/shadow` or set SUID bits.

How many accounts were added to the sudoers group in the according alert?
-----------------------------------------------------------------------------------------
For this task, we search for the "Linux PrivEsc - User Added to Sudo Group" alert and
upon clicking on the incident graph, we can see that there were *4 users* associated to
11 devices in the sudoers group. The names of the users are "backupuser", "serviceacct",
"deploy" and "alice".

What is the name of the kernel module installed in websrv-01?
-----------------------------------------------------------------------------------------

What is the unusual command executed within websrv-01 by the ops user?
-----------------------------------------------------------------------------------------

What is the source IP address of the first successful SSH login to storage-01?
-----------------------------------------------------------------------------------------

What is the external source IP that successfully logged in as root to app-01?
-----------------------------------------------------------------------------------------

What is the name of the user added to the sudoers group inside app-01?
-----------------------------------------------------------------------------------------

[^1]: https://tryhackme.com/room/azuresentinel-aoc2025-a7d3h9k0p2
[^2]: https://portal.azure.com/
