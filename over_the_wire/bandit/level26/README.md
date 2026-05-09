```
 __  __  __  _ __  _ _____   _   ___ _   _  ___ _     ___ ___  
|  \/  \|  \| | _\| |_   _| | | | __| \ / || __| |   (_  / __| 
| -< /\ | | ' | v | | | |   | |_| _|`\ V /'| _|| |_   / / ,_ \ 
|__/_||_|_|\__|__/|_| |_|   |___|___| \_/  |___|___| |___\___/
```
Logging in to *bandit26* from *bandit25* should be fairly easy. The shell for user
*bandit26* is not `/bin/bash`, but something else. Find out what it is, how it works
and how to break out of it. Note, that if on a Windows system, we should use the
command prompt instead of Powershell to log in via SSH to *bandit25* and *bandit26*.
[^1]

Solution
----------------------------------------------------------------------------------------
In order to find out the shell for the user *bandit26*, we print the contents of the
`/etc/passwd` file and spot the line
`bandit26:x:11026:11026:bandit level 26:/home/bandit26:/usr/bin/showtext` that tells us
that the user *bandit26* uses the login shell `/usr/bin/showtext`. Since this shell is
not known to us, we print it's contents to see what it does.
```bash
#!/bin/sh

export TERM=linux

exec more ~/text.txt
exit 0
```
This tells us, that when we want to login to *bandit26*, the shell sets the environment
variable to *linux* and executes the `more` command displaying `/home/bandit26/text.txt`
after which it quits.

[^1]: https://overthewire.org/wargames/bandit/bandit26.html
