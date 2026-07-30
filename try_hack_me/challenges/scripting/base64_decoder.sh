#!/bin/bash

if [[ $# -eq 0 ]]
  then
    echo "[USAGE] ./base64_decoder.sh b64_1550406728131.txt"
    exit 1
fi

base64_encoded=$(cat $1)

for i in 0{1..9} {10..50}
do
  echo "[NOTE] Iteration $i out of 50 for the decoding of the base64 encoded file."
  base64_encoded=$(base64 -d <<< $base64_encoded)
done

echo -e "\n[SOLUTION] The decoding of the file for 50 times resulted in: $base64_encoded"
