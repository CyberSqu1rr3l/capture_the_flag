```
┌─╴┌─┐┌─┐╶┬┐╷┌─╴┌─┐╶┬╴╷┌─┐┌┐╷   ┌┐     ┌─┐┌─╴┌┬┐┌─╴╶┬┐╷┌─┐╶┬╴╷┌─┐┌┐╷
├╴ ├┬┘├─┤ ││││  ├─┤ │ ││ ││└┤   │╶┼╴   ├┬┘├╴ │││├╴  │││├─┤ │ ││ ││└┤
└─╴╵└╴╵ ╵╶┴┘╵└─╴╵ ╵ ╵ ╵└─┘╵ ╵   └─┘    ╵└╴└─╴╵ ╵└─╴╶┴┘╵╵ ╵ ╵ ╵└─┘╵ ╵
```
This THM room looks into the fourth phase of the Incident Response framework:
Eradication, Remediation, and Recovery. [^1]

Targeted System Cleanup
-----------------------------------------------------------------------------------------
**Which account gave the threat actors a foothold on the server?**

The `swiftspend_admin` user account with the `SuperStrongPassword123` password
are known to have been compromised due to a misconfiguration on another system.

**What is the default password for the admin of the Jenkins service?**

After some google search, we discover that a good starting point to look for the
password is under `/var/lib/jenkins/` where we find the `secrets/` folder. But with
our `swiftspend_admin` permissions we are not allowed to look inside. However,
we are able to change to the *root* user with `sudo su` and then the password.
This way, get the contents of the `/var/lib/jenkins/secrets/initialAdminPassword`
file to get the default admin password `f4fe137aeb154299ab1b7349952f6088`.

**What is the email address of the other account within the Jenkins?**

For this task it seems appropriate to move to the `/var/lib/jenkins/users/` folder
where we find more information about the Jenkins user accounts. Then, we use the
`grep -r "@"` command to get a range of email addresses, but only one stands out
to be valid, i.e. `infra_admin[@]swiftspend.finance` is the other email address.

**What is the command being invoked by the Jenkins dashboard project?**

We already noticed the `backup.sh` and `/var/lib/jenkins/jobs/Backup/config.xml`
files and find the command `/bin/bash /var/lib/jenkins/backup.sh` to be the one
being invoked by the project found on the Jenkins dashboard.

**How many times has the project been run before?**

It hasn't been invoked before, so the number of runs is *0* here.

**You will find a suspicious IP address. Which country is it hosted in?**

If we were to take a look at the `/etc/hosts` file we can find the IP addresses
that were accessed by the system. For the `backup.swiftspend.com` host the IP
address `194[.]26[.]135[.]132` appears to be suspicious. And indeed, with the
AbuseIPDB database tool, find out that it is hosted in the *Russion Federation*.

**Based on the MITRE ATT&CK Matrix, which Tactic is being applied here?**

The tactic applied by the threat actor is data *exfiltration* from the server.

**Based on the Lockheed Martin version of the cyber kill chain, in what phase is
the threat actor already in on this server?**

The threat actor is already on the *actions on objectives* kill chain phase.

[^1]: https://tryhackme.com/room/eradicationandremediation
