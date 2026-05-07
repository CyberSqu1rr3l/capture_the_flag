PASSWORD="bandit0"

COMMANDS=(
  "cat readme"
  "cat ./-"
  "cat ./--spaces\ in\ this\ filename--"
  "cat inhere/...Hiding-From-You"
  "cat inhere/-file07"
  "cat inhere/maybehere07/.file2"
  "cat /var/lib/dpkg/info/bandit7.password"
  "grep -i 'millionth' data.txt"
  "cat data.txt | sort | uniq -u"
  "strings data.txt | grep \"==\" | tail -n 1"
  "base64 -d data.txt"
  "tr 'A-Za-z' 'N-ZA-Mn-za-m' < data.txt"
  "mkdir /tmp/test-dir; cp data.txt /tmp/test-dir; cd /tmp/test-dir; mv data.txt hexdump; xxd -r hexdump compressed; mv compressed compressed.gz; gzip -d compressed.gz; bzip2 -d compressed; mv compressed.out data4.gz; gzip -d data4.gz; tar -xvf data4; tar -xvf data5.bin; bzip2 -d data6.bin; tar -xvf data6.bin.out; mv data8.bin data8.bin.gz; gzip -d data8.bin.gz; cat data8.bin"
  "cat sshkey.private"
  "cat /etc/bandit_pass/bandit14 | nc localhost 30000"
  "cat /etc/bandit_pass/bandit15 | openssl s_client -connect localhost:30001 -ign_eof 2>/dev/null | grep -E '^[a-zA-Z0-9]{32}$'"
  "cat /etc/bandit_pass/bandit16 | openssl s_client -connect localhost:31790 -ign_eof 2>/dev/null | awk '/BEGIN RSA PRIVATE KEY/{flag=1} flag; /END RSA PRIVATE KEY/{flag=0}'"
  "diff --new-line-format='%L' --old-line-format='' --unchanged-line-format='' passwords.old passwords.new"
  "cat readme"
  "./bandit20-do cat /etc/bandit_pass/bandit20"
  "{ echo '0qXahG8ZjOVMN9Ghs7iOWsCfZyXOUbYO'; sleep 2; } | nc -lp 2222 & ./suconnect 2222"
  "cat /tmp/t7O6lds9S0RqQh9aMcz6ShpAoZKF7fgv"
  "cat /tmp/8ca319486bfbbc3663ea0fbe81326349"
  "echo 'Final Level'"
)

for i in {0..23}; do
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
    13) echo "$OUTPUT" > sshkey.private; chmod 600 sshkey.private;
        PASSWORD=$(ssh -i sshkey.private -q -o IdentitiesOnly=yes \
          bandit14@bandit.labs.overthewire.org -p 2220 \
          "cat /etc/bandit_pass/bandit14" 2> /dev/null) ;;
    14) PASSWORD=$(echo "$OUTPUT" | awk 'NR==2') ;;
    16) echo "$OUTPUT" > sshkey.private; chmod 600 sshkey.private;
        PASSWORD=$(ssh -i sshkey.private -q -o IdentitiesOnly=yes \
          bandit17@bandit.labs.overthewire.org -p 2220 \
          "cat /etc/bandit_pass/bandit17" 2> /dev/null) ;;
    20) PASSWORD=$(echo "$OUTPUT" | awk -F'Read:' '/Read:/ {print $1}') ;;
    *) PASSWORD=$OUTPUT ;;
  esac
done
