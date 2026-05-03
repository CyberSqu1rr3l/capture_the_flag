```
 __  __  __  _ __  _ _____   _   ___ _   _  ___ _     __ __   
|  \/  \|  \| | _\| |_   _| | | | __| \ / || __| |   /  |__`. 
| -< /\ | | ' | v | | | |   | |_| _|`\ V /'| _|| |_  `7 ||_ | 
|__/_||_|_|\__|__/|_| |_|   |___|___| \_/  |___|___|  |_|__.'
```
The password for the next level is stored in the file `data.txt`, which is a hexdump of
a file that has been repeatedly compressed. For this level it may be useful to create a
directory under `/tmp` in which you can work. Use `mkdir` with a hard to guess directory
name or use the command `mktemp -d`. Copy the datafile using `cp`, and rename it using
`mv`. [^1]

Solution
----------------------------------------------------------------------------------------
First, we create a temporary


[^1]: https://overthewire.org/wargames/bandit/bandit13.html
