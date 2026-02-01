#!/usr/bin/env python3

sequence = [1, 2, 4, 6, 10, 12, 16, 18, 22, 28, 30, 36, 40]

print('Distance between each number in the sequence: ')
for i in range(len(sequence)):
    if i != 0:
        print(sequence[i] - sequence[i-1], end=' ')
print()
