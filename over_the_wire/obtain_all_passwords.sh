#!/bin/bash

MODE="$1"

if [[ -z "$MODE" ]]; then
  echo -e "\e[31m[ERROR]\e[0m Missing argument, must provide one of these catagories $0 {bandit|krypton|leviathan|natas}"
  exit 1
fi

if [[ "$MODE" == "bandit" ]]; then

  PASSWORD="bandit0"

  HARDCODED_PASSWORDS=(
    [26]="s0773xxkk0MXfdqOfPRVr9L3jJBUOgCZ"
    [27]="upsNCc7vzaRDx6oZC6GiR6ERwe1MowGB"
    [28]="Yz9IpL0sBcCeuG7m9uQFt8ZNpS4HZRcN"
    [29]="4pT1t5DENaYuqnqvadYs1oE4QLCdjmJ7"
    [30]="qp30ex3VLz5MDG1n91YowTv4Q8l7CDZL"
    [31]="fb5S2xb7bRyFmAvQYQGEqsbhVyJqhnDy"
    [32]="3O9RfhqyAlVBEZpVb6LYStshZoqoSx5K"
    [33]="tQdtbs5D5i2vJwkO8mEyYEyTL8izoeJ0"
  )

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

  for i in {0..33}; do
    if [[ $i -ge 26 ]]; then
      PASSWORD="${HARDCODED_PASSWORDS[$i]}"
      echo -e "\e[33m[NOTE]\e[0m Stored the user \e[32mbandit$i\e[0m with password \e[31m$PASSWORD\e[0m"
      continue
    fi
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

elif [[ "$MODE" == "natas" ]]; then

  HARDCODED_PASSWORDS=(
    "natas0"
    "0nzCigAq7t2iALyvU9xcHlYN4MlkIwlq"
    "TguMNxKo1DSa1tujBLuZJnDUlCcUAPlI"
    "3gqisGdR0pjm6tpkDKdIWO2hSvchLeYH"
    "QryZXc2e0zahULdHrtHxzyYkj59kUxLQ"
    "0n35PkggAPm2zbEpOU802c0x0Msn1ToK"
    "0RoJwHdSKWFTYR5WuiAewauSuNaBXned"
    "bmg8SvU1LizuWjx3y7xkNERkHxGre0GS"
    "xcoXLmzMkoIP9D7hlgPlh9XD7OgLAe5Q"
    "ZE1ck82lmdGIoErlhQgWND6j2Wzz6b6t"
    "t7I5VHvpa14sJTUGV0cbEsbYfFP2dmOu"
    "UJdqkK1pTu6VLt9UHWAgRZz6sVUZ3lEk"
    "yZdkjAYZRd3R7tq7T5kXMjMJlOIkzDeB"
    "trbs5pCjCrkuSknBBKHhaBxq6Wm1j3LC"
    "z3UYcr4v4uBpeX8f7EZbMHlzK4UR2XtQ"
    "SdqIqBsFcz3yotlNYErZSZwblkm0lrvx"
  )

  for i in "${!HARDCODED_PASSWORDS[@]}"; do
    echo -e "\e[33m[NOTE]\e[0m Use \e[32mnatas$i\e[0m to connect to \e[34mhttp://natas$i.natas.labs.overthewire.org/\e[0m with password \e[31m${HARDCODED_PASSWORDS[$i]}\e[0m"
  done

elif [[ "$MODE" == "leviathan" ]]; then

  PASSWORD="leviathan0"

  COMMANDS=(
    "grep -oiP 'the password for leviathan1 is \K[^\"]+' ~/.backup/bookmarks.html"
    "{ printf 'sex\n'; sleep 1; printf 'cat /etc/leviathan_pass/leviathan2\n'; } | ./check"
    "echo 'For this level the password is stored and has to be obtained manually.'"
  )

  for i in {0..2}; do
    printf "\e[33m[NOTE]\e[0m Connecting to \e[32mleviathan%d\e[0m with password \e[31m%s\e[0m and executing \e[34m%s\e[0m\n" \
      "$i" "$PASSWORD" "${COMMANDS[$i]}"
    OUTPUT=$(sshpass -p "$PASSWORD" ssh -q \
      -o PreferredAuthentications=password -o PubkeyAuthentication=no \
      leviathan$i@leviathan.labs.overthewire.org -p 2223 \
      "${COMMANDS[$i]}" 2> /dev/null)
    case $i in
      1) PASSWORD=$(echo "$OUTPUT" | head -n1) ;;
      *) PASSWORD=$OUTPUT ;;
    esac
  done

elif [[ "$MODE" == "krypton" ]]; then

  PASSWORD="KRYPTONISGREAT"

  COMMANDS=(
    "echo 'The level zero is not used in krypton, so this should not appear.'"
    "tr 'A-Za-z' 'N-ZA-Mn-za-m' <<< \$(cat /krypton/krypton1/krypton2)"
    "cat /krypton/krypton2/krypton3 | tr 'M-ZA-L' 'A-Z'"
    "cat /krypton/krypton3/krypton4 | tr 'SYQUUKBNWVGCJDIXMA' 'epasswordlnithvfub'"
    "echo 'For this level the password is stored and has to be obtained manually.'"
  )

  for i in {1..4}; do
    printf "\e[33m[NOTE]\e[0m Connecting to \e[32mkrypton%d\e[0m with password \e[31m%s\e[0m and executing \e[34m%s\e[0m\n" \
      "$i" "$PASSWORD" "${COMMANDS[$i]}"
    OUTPUT=$(sshpass -p "$PASSWORD" ssh -q \
      -o PreferredAuthentications=password -o PubkeyAuthentication=no \
      krypton$i@krypton.labs.overthewire.org -p 2231 \
      "${COMMANDS[$i]}" 2> /dev/null)
    case $i in
      1) PASSWORD=$(echo "$OUTPUT" | awk '{print $NF}') ;;
      3) PASSWORD=$(echo "$OUTPUT" | awk '{print toupper($NF)}') ;;
      *) PASSWORD=$OUTPUT ;;
    esac
  done

else
  echo -e "\e[31m[ERROR]\e[0m Invalid argument \"$MODE\" use either of these catagories $0 {bandit|krypton|leviathan|natas}"
  exit 1
fi
