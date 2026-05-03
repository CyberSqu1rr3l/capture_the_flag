PASSWORD="bandit0"

COMMANDS=(
  "cat readme"
  "cat ./-"
  "cat ./--spaces\ in\ this\ filename--"
  "cat inhere/...Hiding-From-You"
  "cat inhere/-file07"
  "cat inhere/maybehere07/.file2"
  "cat /var/lib/dpkg/info/bandit7.password"
  "grep -i "millionth" data.txt"
  "cat data.txt | sort | uniq -u"
  "strings data.txt | grep \"==\" | tail -n 1"
  "base64 -d data.txt"
  "tr 'A-Za-z' 'N-ZA-Mn-za-m' < data.txt"
  "mkdir /tmp/test-dir; cp data.txt /tmp/test-dir; cd /tmp/test-dir; mv data.txt hexdump; xxd -r hexdump compressed; mv compressed compressed.gz; gzip -d compressed.gz; bzip2 -d compressed; mv compressed.out data4.gz; gzip -d data4.gz; tar -xvf data4; tar -xvf data5.bin; bzip2 -d data6.bin; tar -xvf data6.bin.out; mv data8.bin data8.bin.gz; gzip -d data8.bin.gz; cat data8.bin"
)

for i in {0..13}; do
  echo "[Note] Connecting to bandit$i with password $PASSWORD and executing \$(${COMMANDS[$i]})"
  OUTPUT=$(sshpass -p "$PASSWORD" ssh -q \
    -o PreferredAuthentications=password -o PubkeyAuthentication=no \
    bandit$i@bandit.labs.overthewire.org -p 2220 \
    "${COMMANDS[$i]}" 2> /dev/null)
  case $i in
    0) PASSWORD=$(echo "$OUTPUT" | grep "password" | awk '{print $NF}') ;;
    5) PASSWORD=$(echo "$OUTPUT" | tr -d '\r' | xargs) ;;
    7) PASSWORD=$(echo "$OUTPUT" | awk '{print $2}') ;;
    9) PASSWORD=$(echo "$OUTPUT" | awk '{print $NF}') ;;
    10) PASSWORD=$(echo "$OUTPUT" | awk '{print $NF}') ;;
    11) PASSWORD=$(echo "$OUTPUT" | awk '{print $NF}') ;;
    12) PASSWORD=$(echo "$OUTPUT" | tail -n 1 | awk '{print $NF}') ;;
    *) PASSWORD=$OUTPUT ;;
  esac
done
