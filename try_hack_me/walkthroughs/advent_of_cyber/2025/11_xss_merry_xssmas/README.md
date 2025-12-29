```
▌ ▌▞▀▖▞▀▖     ▙▗▌             ▌ ▌▞▀▖▞▀▖▙▗▌      
▝▞ ▚▄ ▚▄  ▄▄▖ ▌▘▌▞▀▖▙▀▖▙▀▖▌ ▌ ▝▞ ▚▄ ▚▄ ▌▘▌▝▀▖▞▀▘
▞▝▖▖ ▌▖ ▌     ▌ ▌▛▀ ▌  ▌  ▚▄▌ ▞▝▖▖ ▌▖ ▌▌ ▌▞▀▌▝▀▖
▘ ▘▝▀ ▝▀      ▘ ▘▝▀▘▘  ▘  ▗▄▘ ▘ ▘▝▀ ▝▀ ▘ ▘▝▀▘▀▀
```
In this THM room from AoC 2025, we learn about the different types of XSS vulnerabilities
and how to prevent them [^1].

Which type of XSS attack requires payloads to be persisted on the backend?
-----------------------------------------------------------------------------------------
There are mainly two types of XSS attacks. In reflected XSS, vitims are targeted
individually, usually via phishing. In *stored* XSS however, the malicious script is
saved on the server, i.e. persistent on the backend.

What's the reflected XSS flag?
-----------------------------------------------------------------------------------------
By reading the introduction to reflected cross-site scripting, we get suspicious of the
URL payload `<script>alert(atob("VEhNe0V2aWxfQnVubnl9"))</script>` to be Base64-encoded.
And indeed, upon using `base64 -d` we find out that the string "VEhNe0V2aWxfQnVubnl9" is
the flag in the reflected XSS attack.

What's the stored XSS flag?
-----------------------------------------------------------------------------------------
Upon navigating to the target machine's IP address, we discover a website send Chrismas
wishes and questions to Santa's Chief Security elf McSkidy.

[^1]: https://tryhackme.com/room/xss-aoc2025-c5j8b1m4t6
