```
 .-') _      ('-.     _  .-')  _ .-') _                       _  .-')     ('-.     _ .-') _     ('-.   
(  OO) )    ( OO ).-.( \( -O )( (  OO) )                     ( \( -O )   ( OO ).-.( (  OO) )  _(  OO)  
/     '._   / . --. / ,------. \     .'_   ,-.-')   ,----.    ,------.   / . --. / \     .'_ (,------. 
|'--...__)  | \-.  \  |   /`. ',`'--..._)  |  |OO) '  .-./-') |   /`. '  | \-.  \  ,`'--..._) |  .---' 
'--.  .--'.-'-'  |  | |  /  | ||  |  \  '  |  |  \ |  |_( O- )|  /  | |.-'-'  |  | |  |  \  ' |  |     
   |  |    \| |_.'  | |  |_.' ||  |   ' |  |  |(_/ |  | .--, \|  |_.' | \| |_.'  | |  |   ' |(|  '--.  
   |  |     |  .-.  | |  .  '.'|  |   / : ,|  |_.'(|  | '. (_/|  .  '.'  |  .-.  | |  |   / : |  .--'  
   |  |     |  | |  | |  |\  \ |  '--'  /(_|  |    |  '--'  | |  |\  \   |  | |  | |  '--'  / |  `---. 
   `--'     `--' `--' `--' '--'`-------'   `--'     `------'  `--' '--'  `--' `--' `-------'  `------' 
```
A server has been compromised, and the security team has decided to isolate the machine
until it's been thoroughly cleaned up. Initial checks by the Incident Response team
revealed that there are five different backdoors. It's your job to find and remediate
them before giving the signal to bring the server back to production. Can you find all
the basic persistence mechanisms in this Linux endpoint? [^1]

QUESTION 1
-----------------------------------------------------------------------------------------
**What is the server's OS version?**

First, we start by connecting to the machine with `ssh` and the given user credentials
*giorgio* and *armani*. Upon successfully connecting to the server, we are prompted with
a welcome message with the operating system version.

QUESTION 2
-----------------------------------------------------------------------------------------
**What's the most interesting file you found in giorgio's home directory?**

A simple scan in giorgio's home directory with `ls` does not yield any result but then we
search with `ls -a` and discover a suspicious ELF 64-bit executable bash file under the
root userspace.

QUESTION 3
-----------------------------------------------------------------------------------------
**Another file that can be found in every user's home directory is the `.bashrc` file.
Can you check if you can find something interesting in giorgio's `.bashrc`?**

We open the `.bashrc` shell configuration file in an editor of our choice and then spot
a suspicious *alias* to change the `ls` command into a reverse shell backdoor. With
every directory listing, a hidden reverse shell is launched, error messages are supressed
and the real `ls` is run. Note, that the remote shell is not detected because it runs in
the background and redirects all inputs and outputs to a TCP connection.

QUESTION 4
-----------------------------------------------------------------------------------------
**It's time to check the scheduled tasks that he owns. Did you find anything interesting
about scheduled tasks?**

The `crontab -l` inspection lead us to the malicious task which seems to be linked to
the alias. The last scheduled task creates a persistent reverse shell backdoor to enable
remote command access. First, it is scheduled to run every minute to keep re-establishing
if it drops. Then, it deletes any existing file at `/tmp/f` and creates a named pipe at
its place. Finally, it sets up a loop to read input from the pipe, feed it into an
interactive shell, send any errors and output with it and then send everything to a
remote host. Since it's hidden in cron and runs automatically, it's hard to spot yet a
severe system compromise due to the full remote control and continuous reconnection.

QUESTION 5
-----------------------------------------------------------------------------------------


QUESTION 6
-----------------------------------------------------------------------------------------


QUESTION 7
-----------------------------------------------------------------------------------------


QUESTION 8
-----------------------------------------------------------------------------------------


QUESTION 9
-----------------------------------------------------------------------------------------


[^1]: https://tryhackme.com/room/tardigrade
