#!/usr/bin/env expect

# CONFIGURATION ================================================================
set KEY "bandit26.sshkey"
set HOST "bandit.labs.overthewire.org"
set PORT 2220
set USER "bandit26"


# SAVE OLD TERMINAL SIZE =======================================================
set OLD_ROWS [exec sh -c {stty size | awk '{print $1}'}]
set OLD_COLS [exec sh -c {stty size | awk '{print $2}'}]

# SPAWN SSH SESSION ============================================================
spawn ssh -i $KEY -o IdentitiesOnly=yes -p $PORT $USER@$HOST

# SHRINK TERMINAL SIZE =========================================================
stty rows 10 cols 40 < $spawn_out(slave,name)

# No matter what I tried here, I could not get to start vim in interactive mode
# and retrieve the password file automatically; it has to be done manually.
# send "v\r"
# expect ":"
# send ":e /etc/bandit_pass/bandit26 \r"
# sleep 1

# HAND CONTROL TO USER =========================================================
interact

# RESTORE OLD TERMINAL SIZE ====================================================
stty rows $OLD_ROWS cols $OLD_COLS
