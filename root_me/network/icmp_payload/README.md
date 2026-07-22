```
╷╭─╴╭┬╮╭─╮   ╭─╮╭─╮╷ ╷╷  ╭─╮╭─╮╶┬╮
││  │││├─╯   ├─╯├─┤╰┬╯│  │ │├─┤ ││
╵╰─╴╵ ╵╵     ╵  ╵ ╵ ╵ ╰─╴╰─╯╵ ╵╶┴╯
```
This challenge comes from the 18th DEFCON CTF’s qualification. Note, that an information
is hidden in the capture of ICMP packets and the validation password is a MD5 hash. [^1]

Solution
-----------------------------------------------------------------------------------------
After opening the challenge resource in `wireshark ch6.pcap`, we can observe *34* ICMP
packets that were intercepted from the network. They all seem to feature a ping request 
and reply from the source IP `192.168.0.2` to the destination IP `192.168.0.1`. Next, we
analyze the ICMP contents for every packet but can not observe anything abnormal or
interesting. Also, we filter all the *MD5* hashes from the payloads and attempt to find
any collisions through a hash lookup [^2] but without any success. Since all the ICMP
messages are very uniform too, we can not discover any interesting error codes either. 
[^3]

**TBC**

[^1]: https://www.root-me.org/en/Challenges/Network/ICMP-payload-107
[^2]: https://inventivehq.com/tools/security/hash-lookup
[^3]: https://learningnetwork.cisco.com/s/article/Understanding-the-ICMP-Protocol-with-Wireshark-in-Real-Time
