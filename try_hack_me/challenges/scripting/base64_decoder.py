#!/usr/bin/python3
import sys
import base64

if len(sys.argv) > 1:
    filename = sys.argv[1]
else:
    sys.exit("[USAGE] ./base64_decoder.py b64_1550406728131.txt")

with open(filename, 'r') as file_reader:
    base64_encoded = file_reader.readline()

for i in range(50):
    print("[NOTE] Iteration " + str(i).zfill(2) +
        " out of 50 for the decoding of the base64 encoded file.")
    base64_encoded_bytes = base64.b64decode(base64_encoded)
    base64_encoded = base64_encoded_bytes.decode('ascii')

print("\n[SOLUTION] The decoding of the file for 50 times resulted in: " +
    base64_encoded)

