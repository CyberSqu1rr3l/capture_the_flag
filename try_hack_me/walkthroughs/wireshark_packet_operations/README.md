```
▖  ▖▘      ▌     ▌    ▄▖    ▌   ▗   ▄▖        ▗ ▘      
▌▞▖▌▌▛▘█▌▛▘▛▌▀▌▛▘▙▘▖  ▙▌▀▌▛▘▙▘█▌▜▘  ▌▌▛▌█▌▛▘▀▌▜▘▌▛▌▛▌▛▘
▛ ▝▌▌▌ ▙▖▄▌▌▌█▌▌ ▛▖▖  ▌ █▌▙▖▛▖▙▖▐▖  ▙▌▙▌▙▖▌ █▌▐▖▌▙▌▌▌▄▌
                                      ▌
```
In this THM walkthrough, we learn the fundamentals of packet analysis with Wireshark and
how to find the needle in the haystack! [^1]

Statistics | Summary
-----------------------------------------------------------------------------------------
**Investigate the resolved addresses. What is the IP address of the host name starting
with "bbc"?**

Therefore, we open *Statistics > Resolved Addresses > Hosts* and then enter "bbc" which
yields the name "bbc.map.fastly.net" with the IP address we are looking for.

**What is the number of IPv4 conversations?**

In the header of the *Statistics > Conversations > IPv4* tab, there is the number
of IPv4 conversations already indicated with *435* unique conversations.

**How many bytes (k) were transferred from the "Micro-St" MAC address?**

First, we select the *Statistics > Endpoints > Ethernet* information, then we click on
the name resolution and sort the MAC address names alphabetically. This way, we can
easily search for the `Micro-St_9a:f1:f5` address and see that *7474* kilo bytes were
transferred from and to this endpoint.

**What is the number of IP addresses linked with "Kansas City"?**

Since the lab machine does not have an active internet connection, we download the GeoIP
map HTML site on this local machine and open it in the web browser. Now, we can zoom in
to Kansas City on the map and find out that there are *four* IP addresses linked with
this region. Alternatively, we could have sorted the City in the IPv4 header for the
Endpoints Statistics to find out the unique endpoints.

**Which IP address is linked with "Blicnet" AS Organisation?**

For this, we search for the term "blicnet" in the string packet finder and find out,
that the organization is located in Bosnia and Herzegovina with the source IP address
for this traffic.

Statistics | Protocols Filters
-----------------------------------------------------------------------------------------
**What is the most used IPv4 destination address?**

For this question, we open the *Statistics > IPv4 Statistics > Source* and *Destination
Addresses* to then sort the destination addresses upwards with the count item. This way,
we find out the most used destination address.

**What is the max service request-response time of the DNS packets?**

Upon opening the *Statistics > DNS* window, we can see the request-response time service
stats and see that the maximum is *0.467897*.

**What is the number of HTTP Requests accomplished by "rad[.]msn[.]com?**

The number of HTTP Requests made by the HTTP host "rad.msn.com" is found under the
*Statistics > HTTP > Load Distribution* and then the *HTTP Requests by Server* and
*HTTP Requests by HTTP Host* which then counts *39* requests in total.

Packet Filtering | Principles
-----------------------------------------------------------------------------------------
**What is the number of IP packets?**

For this question we enter the filter `ip` to find out that there are "*81420* IP packets
in total for this sample capture.

**What is the number of packets with a "TTL value less than 10"?**

Using the filter `ip.ttl < 10` we find out that there are *66* such packets.

**What is the number of packets which uses "TCP port 4444"?**

The filter for `tcp.port == 4444`, which results in *632* displayed packets.

**What is the number of "HTTP GET" requests sent to port "80"?**

With the filter `(http.request.method == "GET") and (tcp.dstport == 80)` we find out,
that there are *527* such packets filtered.

**What is the number of "type A DNS Queries"?**

The filter `(dns) and (dns.qry.type == 1) and (dns.flags.response == 0)` filters only
*51* packets which are of type A DNS queries.

Advanced Filtering
-----------------------------------------------------------------------------------------
**Find all Microsoft IIS servers. What is the number of packets that did not originate
from "port 80"?**

First, we want to select only HTTP packets that contain the *Microsoft* keyword in the
server frame. Then, we need to select only packets originating of a port other than *80*,
so `(http.server contains "Microsoft") and !(tcp.srcport == 80)` which displays *21*
filtered packets with the above specifications.

**What is the number of packets that have "version 7.5"?**

We search the frame, that could be stating the version number and find it in the server
frame, so it must be the filtering syntax `http.server matches "7.5"`. This display
filter lists a total of *71* packets that have the version "7.5".

**What is the total number of packets that use ports 3333, 4444 or 9999?**

The display filter `tcp.port in {3333 4444 9999}` returns *2235* such packets.

**What is the number of packets with "even TTL numbers"?**

The display filter `string(ip.ttl) matches "[24680]$"` yields *77289* packets.

**Change the profile to "Checksum Control". What is the number of "Bad TCP Checksum"
packets?**

We change the default profile to *Checksum Control* with *Edit > Configuration
Profiles* but can't find any appropriate filters for this task. We open the *Analyze >
Expert Information* window and find out, that there are *34185* bad checksum severity
packets for the TCP protocol found.

**Use the existing filtering button to filter the traffic. What is the number of
displayed packets?**

For this task, the change to the *Checksum Control* profile was useful, as we now have
the option to select the `gif/jpeg with http-200` filtering button, which selects *261*
packets from the total of *81530* packets to be images.

[^1]: https://tryhackme.com/room/wiresharkpacketoperations
