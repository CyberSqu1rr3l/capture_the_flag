```
▞▀▖   ▜       ▌   ▛▀▖      ▗            ▛▀▖▗   ▌           ▞▀▖▜▘▛▀▘▙▗▌▞▀▖
▚▄ ▛▀▖▐ ▌ ▌▛▀▖▌▗▘ ▙▄▘▝▀▖▞▀▘▄ ▞▀▖▞▀▘ ▄▄▖ ▌ ▌▄ ▞▀▌ ▌ ▌▞▀▖▌ ▌ ▚▄ ▐ ▙▄ ▌▘▌ ▗▘
▖ ▌▙▄▘▐ ▌ ▌▌ ▌▛▚  ▌ ▌▞▀▌▝▀▖▐ ▌ ▖▝▀▖     ▌ ▌▐ ▌ ▌ ▚▄▌▌ ▌▌ ▌ ▖ ▌▐ ▌  ▌ ▌ ▘ 
▝▀ ▌   ▘▝▀▘▘ ▘▘ ▘ ▀▀ ▝▀▘▀▀ ▀▘▝▀ ▀▀      ▀▀ ▀▘▝▀▘ ▗▄▘▝▀ ▝▀▘ ▝▀ ▀▘▀▀▘▘ ▘ ▘
```
In this THM room, we learn how to ingest and parse custom log data using Splunk.
Splunk is a platform for collecting, storing, and analysing machine data. It provides
various tools for analysing data, including search, correlation, and visualisation. [^1]

What is the attacker IP found attacking and compromising the web server?
-----------------------------------------------------------------------------------------
In this exercise, we are provided with a direct link to a Splunk instance. On the Splunk
interface, we click on the search and reporting application. Next, we want to investigate
all logs with the `index=main` search on the all time frame. In the sourcetype field, we
are prompted with two datasets, the `web_traffic` which contains events related to the
web connections to and from the server, and the `firewall_logs` which contains firewall
logging for allowed and blocked traffic. For now, we are interested in the web traffic
and from the interesting fields, we also investigate the `user_agent`. It becomes clear,
that apart from legitimate user agents, like Mozilla agents, we are counting suspicious
values, like `wget`, `python`, `sqlmap` and `Havij`, all hinting towards a SQL exploit
attack. Further, we can investigate the `client_ip` address to see one standing out in
particular, which is responsible for 45% of requests and proving to be the attack
actor's IP address.

Which day was the peak traffic in the logs? (Format: YYYY-MM-DD)
-----------------------------------------------------------------------------------------
For this question we select the time field and then the top values by time.
The resulting search query to get the peak traffic over time is
`index=main sourcetype=web_traffic| timechart count by time limit=10`.
This leads us to a visualization graph, where we can see that the most traffic of 2,264
events was on October 12, 2025. Alternatively, we can use the search query
`index=main sourcetype=web_traffic | timechart span=1d count | sort by count | reverse`

What is the count of Havij user_agent events found in the logs?
-----------------------------------------------------------------------------------------

How many path traversal attempts to access sensitive files on the server were observed?
-----------------------------------------------------------------------------------------

How many bytes were transferred to the C2 server IP from the compromised web server?
-----------------------------------------------------------------------------------------
Examine the firewall logs. 

[^1]: https://tryhackme.com/room/splunkforloganalysis-aoc2025-x8fj2k4rqp
