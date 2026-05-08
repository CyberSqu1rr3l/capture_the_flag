```
 __  __  __  _ __  _ _____   _   ___ _   _  ___ _     ___  ___  
|  \/  \|  \| | _\| |_   _| | | | __| \ / || __| |   (_  || __| 
| -< /\ | | ' | v | | | |   | |_| _|`\ V /'| _|| |_   / / `._`. 
|__/_||_|_|\__|__/|_| |_|   |___|___| \_/  |___|___| |___|!__.'
```
A daemon is listening on port *30002* and will give us the password for *bandit25* if
given the password for *bandit24* and a secret numeric 4-digit pincode. There is no way
to retrieve the pincode except by going through all of the *10000* combinations, called
brute-forcing. We may not need to create a new connection each time. [^1]

Solution
----------------------------------------------------------------------------------------

[^1]: https://overthewire.org/wargames/bandit/bandit25.html
