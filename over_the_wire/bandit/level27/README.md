```
 __  __  __  _ __  _ _____   _   ___ _   _  ___ _     ___ ___  
|  \/  \|  \| | _\| |_   _| | | | __| \ / || __| |   (_  |_  | 
| -< /\ | | ' | v | | | |   | |_| _|`\ V /'| _|| |_   / / / /  
|__/_||_|_|\__|__/|_| |_|   |___|___| \_/  |___|___| |___|_/
```
Good job getting a shell. Now hurry and grab the password for *bandit27*. [^1]

Solution
----------------------------------------------------------------------------------------

- `stty rows 10 cols 40`
- `ssh -o PreferredAuthentications=password -o PubkeyAuthentication=no bandit26@bandit.labs.overthewire.org -p 2220`
- press v
- `:set shell?` -> shell=/usr/bin/showtext
- `:set shell=/bin/bash`
- `:!ls -la`
- `:!./bandit27-do cat /etc/bandit_pass/bandit27`

[^1]: https://overthewire.org/wargames/bandit/bandit27.html
