#!/bin/python3

encrypted_flag = [
    102, 109, 99, 100, 127, 100, 53, 62, 105, 57, 61, 106, 62, 62, 55, 110, 113,
    114, 118, 39, 36, 118, 47, 35, 32, 125, 34, 46, 46, 124, 43, 124, 25, 71,
    26, 71, 21, 88
]

plaintext_flag = ""

# For i = 0 To UBound(a)
for i in range(len(encrypted_flag)):
    # b = b & Chr(a(i) Xor i)
    plaintext_flag += chr(encrypted_flag[i] ^ i)

print(plaintext_flag)

