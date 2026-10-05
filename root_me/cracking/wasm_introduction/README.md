```
╻ ╻┏━┓┏━┓┏┳┓         ╻┏┓╻╺┳╸┏━┓┏━┓╺┳┓╻ ╻┏━╸╺┳╸╻┏━┓┏┓╻
┃╻┃┣━┫┗━┓┃┃┃   ╺━╸   ┃┃┗┫ ┃ ┣┳┛┃ ┃ ┃┃┃ ┃┃   ┃ ┃┃ ┃┃┗┫
┗┻┛╹ ╹┗━┛╹ ╹         ╹╹ ╹ ╹ ╹┗╸┗━┛╺┻┛┗━┛┗━╸ ╹ ╹┗━┛╹ ╹
```
Do you know WebAssembly? Find the password that validates this crackme. [^1]

Solution
----------------------------------------------------------------------------------------- 
*WebAssembly* (WASM) is a safe, portable, low-level compiled fromat of code that the 
browser can execute sequentially. WASM code consists of a sequence of *instructions*, 
that are manipulated through a *stack machine*. [^2] The *WebAssembly* instantiate can be
found in the debugger of the developer tool, under `wasm://`. Here, we can also spot the
`index.js` file, from which a WASM file was created in line 1626. We try to download the
WASM file, but instead have to rely on *CTRL+A* to select the full text and copy it. In
a file editor of our choice, we can now inspect the file, and discover various module and
function creations that seem too low-level to analyze, especially due to the file's size.
Nevertheless, we suspect the password to be saved as a constant here, and thus search for
`cost` and `password` values. On a hunch, that it might be useful, we discover the string
`936fff76f378ace4cf83a4360cafcc20` at the end of the file which appears to be a MD5 hash.
Following this suspicion, we can enter the hash into one of the online tools, such as 
[^6] and thus obtain the password *babaaurhum*. Finally, we can enter this password into 
the bar of the *WASM - Introduction* website [^5] and get the flag for this challenge.
Note, that this was probably not the intended solution, as we could have also used the
*WebAssembly Binary Toolkit* [^4] (WABT) to decrypt the code into a more readable WAT
format. However, the demo for this WASM to WAT conversion [^3] did not suffice, so we
would have to compile the project and then run `bin/wasm2wat` on the `index.wasm` file.

[^1]: https://www.root-me.org/en/Challenges/Cracking/WASM-Introduction
[^2]: https://webassembly.github.io/spec/core/syntax/instructions.html
[^3]: https://webassembly.github.io/wabt/demo/wasm2wat/
[^4]: https://github.com/WebAssembly/wabt/
[^5]: http://challenge01.root-me.org/cracking/ch41/
[^6]: https://hashes.com/en/decrypt/hash
