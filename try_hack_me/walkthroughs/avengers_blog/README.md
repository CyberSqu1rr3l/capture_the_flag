```
     **                                                                    ******    **                 
    ****                               *****                              /*////**  /**           ***** 
   **//**   **    **  *****  *******  **///**  *****  ******  ******      /*   /**  /**  ******  **///**
  **  //** /**   /** **///**//**///**/**  /** **///**//**//* **////       /******   /** **////**/**  /**
 **********//** /** /******* /**  /**//******/******* /** / //*****       /*//// ** /**/**   /**//******
/**//////** //****  /**////  /**  /** /////**/**////  /**    /////**      /*    /** /**/**   /** /////**
/**     /**  //**   //****** ***  /**  ***** //******/***    ******       /*******  ***//******   ***** 
//      //    //     ////// ///   //  /////   ////// ///    //////        ///////  ///  //////   /////  
```
Learn to hack into Tony Stark's machine! You will enumerate the machine, bypass a login
portal via SQL injection and gain root access by command injection. [^1]

[Task 2] - Cookies
-----------------------------------------------------------------------------------------
**On the deployed Avengers machine you recently deployed, get the `flag1` cookie value.**

Having deployed the target machine, we are prompted with the *Official Avengers Blog*
for which we want to inspect the cookie values. And indeed, after navigating to *Storage*
in the *Developer Tools*, we can obtain the `flag1` cookie value.

[Task 3] - HTTP Headers
-----------------------------------------------------------------------------------------
**Look at the HTTP response headers and obtain `flag2`.**

For this task, we want to investigate the *Network* tab of the *Developer Tools* and are
able to spot multiple *GET* requests, one of which to direct to the index file `/`. Here,
under the response headers, we are able to spot the `flag2` value.

[Task 4] - Enumeration and FTP
-----------------------------------------------------------------------------------------
**Look around the FTP share and read `flag3`!**

Scanning the target machine with `nmap` or similar *Network Scanners* is a normal part
of every penetration test. We begin with the simple `nmap -v <TARGET_IP_ADDRESS>` command
and are able to discover a *FTP* service under port 21, *SSH* under port 22 and *HTTP*
under port *80*. Now, we want to log in to the *FTP* service with the `ftp` command and
having read Rocket's post about Groot's password to be reset, we already know the
credentials to be *groot* and *iamgroot*. Having logged in with these, we can now browse
the `files` directory in which we find the third flag. Finally, we can obtain it with 
`get flag3.txt` and print its contents in our attacking machine.

[Task 5] - GoBuster
-----------------------------------------------------------------------------------------
**What is the directory that has an Avengers login?**

For this task, we want to use `gobuster`, which is a directory discovery tool, to 
brute-force URIs, DNS subdomains and virtual host names. With
`gobuster dir -u http://<TARGET_IP_ADDRESS> -w /usr/share/wordlists/dirb/common.txt`
we are able to discover the hidden `/portal` in which avengers can sign in.

[Task 6] - SQL Injection
-----------------------------------------------------------------------------------------
**Log into the Avengers site. View the page source, how many lines of code are there?**

In order to log in, we want to make use of a SQL injection attack and begin by providing
`' or 1=1--` for both the username and password. This way, we are able to log in and
print the page source to find out how many lines of code it contains.

[Task 7] - Remote Code Execution and Linux
-----------------------------------------------------------------------------------------
**Read the contents of `flag5.txt`**

Given access to the *J.A.R.V.I.S* development environment enables us to run commands
interactively. Therefore, we find out the location of the fifth flag to be one directory
above us with the `ls` command. However, the `cat` and `more` commands are disallowed
and so we proceed to use `less ../flag5.txt` which allows us to see the file contents.

[^1]: https://tryhackme.com/room/avengers
