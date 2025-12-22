```
▛▀▖                     ▌        ▞▀▖ ▞▀▖         ▌  ▗        ▞▀▖▌     ▗    ▐            
▙▄▘▝▀▖▞▀▘▞▀▘▌  ▌▞▀▖▙▀▖▞▀▌▞▀▘ ▄▄▖ ▙▄▌ ▌  ▙▀▖▝▀▖▞▀▖▌▗▘▄ ▛▀▖▞▀▌ ▌  ▛▀▖▙▀▖▄ ▞▀▘▜▀ ▛▚▀▖▝▀▖▞▀▘
▌  ▞▀▌▝▀▖▝▀▖▐▐▐ ▌ ▌▌  ▌ ▌▝▀▖     ▌ ▌ ▌ ▖▌  ▞▀▌▌ ▖▛▚ ▐ ▌ ▌▚▄▌ ▌ ▖▌ ▌▌  ▐ ▝▀▖▐ ▖▌▐ ▌▞▀▌▝▀▖
▘  ▝▀▘▀▀ ▀▀  ▘▘ ▝▀ ▘  ▝▀▘▀▀      ▘ ▘ ▝▀ ▘  ▝▀▘▝▀ ▘ ▘▀▘▘ ▘▗▄▘ ▝▀ ▘ ▘▘  ▀▘▀▀  ▀ ▘▝ ▘▝▀▘▀▀
```
In this THM room from the Advent of Cyber 2025 event, we learn how to crack
password-based encrypted files. [^1]

What is the flag inside the encrypted PDF?
-----------------------------------------------------------------------------------------
Both the `flag.pdf` and `flag.zip` files are located on the desktop. Just to make sure
the file types actually match with the real ones, we can use the `file` command. Next, we
choose to pick one of the following tools based on the file type:

- PDF document: pdfcrack, john (via pdf2john)
- ZIP archive: fcrackzip, john (via zip2john)
- General: john (very flexible) and hashcat (GPU acceleration, more advanced)

For the first flag, we have a PDF document, so we can use the `pdfcrack` command and the
common wordlist `rockyou.txt`: `pdfcrack -f flag.pdf -w /usr/share/wordlists/rockyou.txt`
This tool already yields the found user password *naughtylist* which we can then use to
`open` the file in the PDF viewer of our choice.

What is the flag inside the encrypted zip file?
-----------------------------------------------------------------------------------------
For the ZIP archive, we choose to use `john` and therefore first create a hash for John
to work with: `zip2john flag.zip > ziphash.txt` Now, we can apply `john` on this hash:
`john -w=/usr/share/wordlists/rockyou.txt ziphash.txt`
This dictionary attack rewards us with the password *winter4ever* which we then use to
`unzip` the archive and read the flag in the text file.

Have a look around the VM to get access to the key for Side Quest 2.
-----------------------------------------------------------------------------------------


[^1]: https://tryhackme.com/room/attacks-on-ecrypted-files-aoc2025-asdfghj123
