```                                                                                              
_-_-                          ,  ,,                      _-_-                     ,,        /\\  
 /,           ;     '   _    ||  ||      _                /,           ;          ||       || || 
 ||      _-_  \\/\ \\  < \, =||= ||/\\  < \, \\/\\        ||      _-_  \\/\  _-_  ||       || || 
~||     || \\ || | ||  /-||  ||  || ||  /-|| || ||       ~||     || \\ || | || \\ ||       || || 
 ||     ||/   || | || (( ||  ||  || || (( || || ||        ||     ||/   || | ||/   ||       || || 
(  -__, \\,/  \\/  \\  \/\\  \\, \\ |/  \/\\ \\ \\       (  -__, \\,/  \\/  \\,/  \\        \\/  
                                   _/                                                                                                                                                                                                                            
```
Leviathan is a wargame that has been rescued from the demise of `intruded.net`,
previously hosted on `leviathan.intruded.net`. This wargame doesn't require any
knowledge about programming, just a bit of common sense and some knowledge about basic
**nix* commands. Leviathan's levels are called *leviathan0*, *leviathan1*, etc. and can
be accessed on `leviathan.labs.overthewire.org` through SSH on port *2223*. To login to
the first level use the username `leviathan0` and password `leviathan0`. Data for the
levels can be found in the homedirectories and the various passwords are located under
`/etc/leviathan_pass`. This wargame should be solved using dynamic [^2] and static
program analysis [^3] with tools such as `ltrace`, `strace`, `gdb`, `gef`, `pwndbg`,
`radare2`, `strings`, `hexdump`, `objdump` and `ghidra`. While Leviathan [^1] can
technically be solved using pure dynamic analysis, i.e. by just running the programs in
some way, and without looking at the insides and the execution in the machine
(involving assembly language), those skills are useful for the wargames following
Leviathan, so be sure to learn them here.

Solution
----------------------------------------------------------------------------------------

[^1]: https://overthewire.org/wargames/leviathan/
[^2]: https://en.wikipedia.org/wiki/Dynamic_program_analysis
[^3]: https://en.wikipedia.org/wiki/Static_program_analysis
