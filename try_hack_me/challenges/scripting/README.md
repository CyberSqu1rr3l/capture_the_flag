```
    o__ __o                             o                o        o                          
   /v     v\                          _<|>_             <|>     _<|>_                        
  />       <\                                           < >                                  
 _\o____            __o__  \o__ __o     o    \o_ __o     |        o    \o__ __o     o__ __o/ 
      \_\__o__     />  \    |     |>   <|>    |    v\    o__/_   <|>    |     |>   /v     |  
            \    o/        / \   < >   / \   / \    <\   |       / \   / \   / \  />     / \ 
  \         /   <|         \o/         \o/   \o/     /   |       \o/   \o/   \o/  \      \o/ 
   o       o     \\         |           |     |     o    o        |     |     |    o      |  
   <\__ __/>      _\o__</  / \         / \   / \ __/>    <\__    / \   / \   / \   <\__  < > 
                                             \o/                                          |  
                                              |                                   o__     o  
                                             / \                                  <\__ __/>
```
In this TryHackMe room, we learn some basic scripting by solving some challenges! [^1]

[Easy] Base64 - What is the final string?
-----------------------------------------------------------------------------------------
**This file has been base64 encoded 50 times, write a script to retrieve the flag.**

We are given the following procedure to decode the file `b64_1550406728131.txt` that can
be downloaded from the task description and are asked to do this both in Bash and Python.

1. Read input from the file
2. Use function to decode the file
3. Do the process in a loop

So, we write two scripts, to repeatedly base64-decode the file and thus obtain the flag.
Note, that we can proceed to either execute `./base64_decoder.sh b64_1550406728131.txt`
or `./base64_decoder.py b64_1550406728131.txt`

[Medium] Gotta Catch em All - What number do you get after all operations?
-----------------------------------------------------------------------------------------
**We need to write a script that connects to a webserver, do an operation on a number
and then move onto the next port.**


[^1]: https://tryhackme.com/room/scripting
