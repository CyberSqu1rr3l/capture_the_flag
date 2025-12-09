```
▙ ▌   ▐            ▌   ▛▀▖▗                           ▞▀▖            ▐      ▞▀▖▜             
▌▌▌▞▀▖▜▀ ▌  ▌▞▀▖▙▀▖▌▗▘ ▌ ▌▄ ▞▀▘▞▀▖▞▀▖▌ ▌▞▀▖▙▀▖▌ ▌ ▄▄▖ ▚▄ ▞▀▖▝▀▖▛▀▖▄▄▖▜▀ ▝▀▖ ▌  ▐ ▝▀▖▌ ▌▞▀▘▞▀▖
▌▝▌▛▀ ▐ ▖▐▐▐ ▌ ▌▌  ▛▚  ▌ ▌▐ ▝▀▖▌ ▖▌ ▌▐▐ ▛▀ ▌  ▚▄▌     ▖ ▌▌ ▖▞▀▌▌ ▌   ▐ ▖▞▀▌ ▌ ▖▐ ▞▀▌▌ ▌▝▀▖▛▀ 
▘ ▘▝▀▘ ▀  ▘▘ ▝▀ ▘  ▘ ▘ ▀▀ ▀▘▀▀ ▝▀ ▝▀  ▘ ▝▀▘▘  ▗▄▘     ▝▀ ▝▀ ▝▀▘▘ ▘    ▀ ▝▀▘ ▝▀  ▘▝▀▘▝▀▘▀▀ ▝▀▘
```
In this THM roob, we discover how to scan network ports and uncover what is hidden behind
them. [^1]

What evil message do you see on top of the website?
-----------------------------------------------------------------------------------------
Upon scanning the target IP address with `nmap`, we discover that there are two ports
open. A SSH port for remote machine access and a HTTP port for a website. Therefore, we
open the website by visiting the target IP address in the browser and obtain the evil
message next to the crossed out title "TBFC QA" and a note by the King Malhare.

What is the first key part found on the FTP server?
-----------------------------------------------------------------------------------------

What is the second key part found in the TBFC app?
-----------------------------------------------------------------------------------------

What is the third key part found in the DNS records?
-----------------------------------------------------------------------------------------

Which port was the MySQL database running on?
-----------------------------------------------------------------------------------------

Finally, what's the flag you found in the database?
-----------------------------------------------------------------------------------------


[^1]: https://tryhackme.com/room/networkservices-aoc2025-jnsoqbxgky
