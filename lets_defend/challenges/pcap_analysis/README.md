```                       
,------.  ,-----.  ,---.  ,------.       ,---.                  ,--.               ,--.        
|  .--. ''  .--./ /  O  \ |  .--. '     /  O  \ ,--,--,  ,--,--.|  |,--. ,--.,---. `--' ,---.  
|  '--' ||  |    |  .-.  ||  '--' |    |  .-.  ||      \' ,-.  ||  | \  '  /(  .-' ,--.(  .-'  
|  | --' '  '--'\|  | |  ||  | --'     |  | |  ||  ||  |\ '-'  ||  |  \   ' .-'  `)|  |.-'  `) 
`--'      `-----'`--' `--'`--'         `--' `--'`--''--' `--`--'`--'.-'  /  `----' `--'`----'  
                                                                    `---'    
```
We have captured this traffic from P13's computer. Can you help him? [^1]

Analyze the network traffic. 
-----------------------------------------------------------------------------------------
**In network communication, what are the IP addresses of the sender and receiver?**

We begin, by opening the file `/root/Desktop/ChallengeFile/Pcap_Analysis.pcapng` with the
*Wireshark Network Analyzer* tool. Since there are many entities in the conversations
statistic, we are not sure which one to focus on. Using the hint, we are informed to
find the chat with the sender *P13* and thus query `frame contains "P13"`. This returns
... TODO

**P13 uploaded a file to the web server. What is the IP address of the server?**

**What is the name of the file that was sent through the network?**

**What is the name of the web server where the file was uploaded?**

**What directory was the file uploaded to?**

**How long did it take the sender to send the encrypted file?**

[^1]: https://app.letsdefend.io/challenge/pcap-analysis
