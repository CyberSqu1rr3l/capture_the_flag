from scapy.all import rdpcap, ICMP
import hashlib

for i, packet in enumerate(rdpcap("ch6.pcap")):
    if ICMP in packet:
        data = bytes(packet[ICMP].payload)
        if data:
            md5 = hashlib.md5(data).hexdigest()

            print(f"Packet No: {i}")
            print(f"MD5: {md5}")
            print(f"Length: {len(data)}")
            print(f"Raw bytes: {data}")
            print(f"Hex: {data.hex()}")
            print("-" * 104)
