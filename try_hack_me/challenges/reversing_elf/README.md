```
__________                                .__                 ___________.____   ___________
\______   \ _______  __ ___________  _____|__| ____    ____   \_   _____/|    |  \_   _____/
 |       _// __ \  \/ // __ \_  __ \/  ___/  |/    \  / ___\   |    __)_ |    |   |    __)  
 |    |   \  ___/\   /\  ___/|  | \/\___ \|  |   |  \/ /_/  >  |        \|    |___|     \   
 |____|_  /\___  >\_/  \___  >__|  /____  >__|___|  /\___  /  /_______  /|_______ \___  /   
        \/     \/          \/           \/        \//_____/           \/         \/   \/    
```
In this THM room aimed at beginners, we aim to practice our reverse engineering skills. 
[^1]

Crackme 1
-----------------------------------------------------------------------------------------
**Let's start with a basic warmup, can you run the binary?**

It is of high importance to never run any untrusted binaries in our own workstation.
Instead, we can use the virtual attacking machine provided by TryHackMe, to run the 
binary file there. After transferring the downloaded binary file to the attacking machine
with the website tool *Send Anywhere* [^2], we can execute the binary after setting the
permissions to executable with `chmod +x crackme1` and then run it with `./crackme1`.
This directly returns the flag for this task and seems pretty straightforward.

Crackme 2
-----------------------------------------------------------------------------------------
**What is the super secret password?**

Once again, we begin by executing the `./crackme2` binary as before but this time, we are
prompted with a super secret password. Instead of trying the super obvious password
"super_secret_password", we open *Ghidra* and investigate the main method. Therefore, we
find out that the input is compared to the string value of the password.

**What is the flag?**

Now, we can provide the found password and thus get the solution with the flag to this
task.

Crackme 3
-----------------------------------------------------------------------------------------
**Use basic reverse engineering skills to obtain the flag.**

Our weapon of choice, is once again Ghidra, where we search for the entry point and 
discover the function `FUN_080484f4` to be likely the main method. In there, we can see,
that the input is compared to the *Base64*-encoded string value of
`ZjByX3kwdXJfNWVjMG5kX2xlNTVvbl91bmJhc2U2NF80bGxfN2gzXzdoMW5nNQ==`. After using
`base64 -d` we thus get the flag.

Crackme 4
-----------------------------------------------------------------------------------------
**Analyze and find the password for the binary?**

After attempting to execute this binary, we are given the hint, that the password string
is hidden and that `strcmp` is used. Further, we have a look at the hint and find out,
that dynamic analysis with *IDA* or `radare2` should be used for this task. At first, we
get familiar with `radare2 -d crackme4` debugging using the `aaa` command to analyze the
code fully and proceed to look at the main method with `pdf @ main`. In here, we can 
verify that the first command-line argument is passed to the function `compare_pwd`.

```assembly
0x00400746  mov rax, qword [var_10h]
0x0040074a  add rax, 8
0x0040074e  mov rax, qword [rax]
0x00400751  mov rdi, rax
0x00400754  call sym.compare_pwd
```
Next, we want to analyze `compare_pwd` with `pdf @ sym.compare_pwd` and see that the
function constructs an encoded string using the following three variables.

```assembly
0x00400695  movabs rax, 0x7b175614497b5d49 ; 'I]{I\x14V\x17{'
0x0040069f  mov qword [var_20h], rax
0x004006a3  movabs rax, 0x547b175651474157 ; 'WAGQV\x17{T'
0x004006ad  mov qword [var_18h], rax
0x004006b1  mov word [var_10h], 0x4053 ; 'S@'
```
Because, the binary is written in *x86-64* which we found out with `info` or `file`,
we know that the bytes in memory are assorted using little-endian format as follows.

> 49 5d 7b 49 14 56 17 7b
> 57 41 47 51 56 17 7b 54
> 53 40 00

The function subsequently passes this buffer to `get_pwd` through the following three
lines.
```assembly
0x004006bb  lea rax, [var_20h]
0x004006bf  mov rdi, rax
0x004006c2  call sym.get_pwd
```
Looking at `get_pwd` with `pdf @ sym.get_pwd` we find out that each byte in the buffer
is *XOR*ed with 36 as follows.
```assembly
0x00400658  movzx eax, byte [rax]
0x0040065b  xor   eax, 0x24 ; 36
0x0040065e  mov   byte [rdx], al
```
This way, we can now reconstruct the entire buffer to the secret password with
`49 XOR 24 = 6D = 'm'` and the other bytes. Alternatively, we can confirm this with
`strcmp` since `compare_pwd` calls `sym.imp.strcmp` directly. By setting a breakpoint
immediately before `strcmp` after providing a password with `db 0x4006d5` we know that
`rdi` is the first argument to `strcmp`, i.e. the generated password and `rsi` the second
one, i.e. the user input. Finally, we can run `psz @ rdi` to directly print the expected
password at runtime. From the *Official Radare2 Book* [^3] we further collected more
commands that are of use when reverse engineering binaries dynamically and statically
in `radare2`.
```
> aaa          # analyse the program (r2 -A)
> afl          # list all functions (try aflt, aflm)
> px 32        # print 32 byte hexdump current block
> s sym.main   # seek to main (using flag name)
> f~foo        # filter flags matching 'foo' (internal |grep)
> iS;is        # list sections and symbols (rabin2 -Ss)
> pdf; agf     # disassembly and ascii-art function graph
> oo+;w hello  # reopen in read-write and write a string
> ?*~...       # interactive filter in all command help
```

Crackme 5
-----------------------------------------------------------------------------------------



Crackme 6
-----------------------------------------------------------------------------------------
**Analyze the binary for the easy password.**

First, we open the `crackme6` file in Ghidra and navigate to the main function. This code
only provides us with the hint that we the password input is used in the `compare_pwd()`
function which then uses the `my_secure_test()` function. Upon having a look at this
function, we find out that the input string is given eight substantial character tests 
that compare all characters in the provided password to a hard-coded sequence of 
characters. By reading the hard-coded char sequence, we thus easily obtain the correct 
password for the guessing game.

Crackme 7
-----------------------------------------------------------------------------------------



Crackme 8
-----------------------------------------------------------------------------------------



[^1]: https://tryhackme.com/room/reverselfiles
[^2]: https://send-anywhere.com/
[^3]: https://book.rada.re/analysis/code_analysis.html
