```
______                 _____                 _ _ _   _
| ___ \               /  __ \               | (_) | (_)                
| |_/ /__ _  ___ ___  | /  \/ ___  _ __   __| |_| |_ _  ___  _ __  ___ 
|    // _` |/ __/ _ \ | |    / _ \| '_ \ / _` | | __| |/ _ \| '_ \/ __|
| |\ \ (_| | (_|  __/ | \__/\ (_) | | | | (_| | | |_| | (_) | | | \__ \
\_| \_\__,_|\___\___|  \____/\___/|_| |_|\__,_|_|\__|_|\___/|_| |_|___/
```
In this TryHackMe walkthrough room, we learn about race conditions and how they affect
web application security. [^1]

Question 1
-----------------------------------------------------------------------------------------
**What would an instruction booklet on how to make an origami crane resemble in computer
terms?**

In the multi-threading introduction we have been intruduced to the terms *program*,
*process* and *thread*. One of these three concepts defines a set of instructions to
achieve a specific task which would match to the origami booklet analogy.

Question 2
-----------------------------------------------------------------------------------------
**What is the name of the state where a process is waiting for an I/O event?**

We have learned that processes hop between different states. First, they launch in the
*ready* state to run once given CPU time and then they move to the *running* state. This
happens quickly, so that most processes spend the most time in a *waiting* state pending
for I/O event changes.

Question 3
-----------------------------------------------------------------------------------------
**Does the presented Python script guarantee which thread will reach 100% first?**

Question 4
-----------------------------------------------------------------------------------------
**In the second execution of the Python script, what is the name of the thread that
reached 100% first?**

[^1]: https://tryhackme.com/room/raceconditionsattacks
