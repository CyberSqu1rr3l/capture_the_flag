from scapy.all import rdpcap, ICMP, Raw


"""Extract the payloads from all ICMP echo request packets"""
def extract_icmp_payloads(filename):
    packets = rdpcap(filename)
    payloads = []

    for packet in packets:
        if ICMP not in packet or Raw not in packet:
            continue

        # Extract only ICMP echo requests with the type 8
        if packet[ICMP].type != 8:
            continue

        payload = bytes(packet[Raw].load)

        # The expected payload length is 256 for the data
        if len(payload) == 256:
            payloads.append(payload)

    return payloads


"""Check if a value does not occur in any other payload"""
def byte_is_alone(value, payloads, current_index):

    for index, payload in enumerate(payloads):
        if index == current_index:
            continue

        if value in payload:
            return False

    return True


"""Extract bytes that occur in one payload but in none other"""
def extract_unique_bytes(payloads):
    unique = bytearray()

    for payload_index, payload in enumerate(payloads):
        for value in payload:
            if byte_is_alone(value, payloads, payload_index):
                unique.append(value)

    return bytes(unique)


"""Add a rotation value do every byte, wrapping values at 256"""
def rotate_bytes(data, rotation):
    return bytes((value + rotation) % 256 for value in data)


"""Helper method to count how many bytes a printable ASCII characters"""
def printable_score(data):
    return sum(32 <= value <= 126 for value in data)


"""Helper method to check if data is a 32 character hexadecimal MD5 string"""
def is_md5_hash(data):
    if len(data) != 32:
        return False

    try:
        text = data.decode("ascii")
    except UnicodeDecodeError:
        return False

    return all(character in "0123456789abcdefABCDEF" for character in text)


def main():
    payloads = extract_icmp_payloads("ch6.pcap")
    unique = extract_unique_bytes(payloads)

    results = []
    for rotation in range(256):
        decoded = rotate_bytes(unique, rotation)
        score = printable_score(decoded)
        results.append((score, rotation, decoded))

    results.sort(reverse=True, key=lambda result: result[0])

    for score, rotation, decoded in results[:20]:
        signed_rotation = rotation if rotation <= 127 else rotation - 256
        md5_match = is_md5_hash(decoded)

        print(
            f"Rotation {rotation:3}"
            f"{signed_rotation:+4} "
            f"[{score}/{len(decoded)} printable] "
            f"{decoded!r}"
            f"{' <-- possible MD5 hash' if md5_match else ''}"
        )


if __name__ == "__main__":
    main()

