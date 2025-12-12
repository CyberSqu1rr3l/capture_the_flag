```
▜▘▛▀▖▞▀▖▛▀▖     ▞▀▖      ▐         ▌  ▗▐  ▐  ▜     ▜▘▛▀▖▞▀▖▛▀▖
▐ ▌ ▌▌ ▌▙▄▘ ▄▄▖ ▚▄ ▝▀▖▛▀▖▜▀ ▝▀▖▞▀▘ ▌  ▄▜▀ ▜▀ ▐ ▞▀▖ ▐ ▌ ▌▌ ▌▙▄▘
▐ ▌ ▌▌ ▌▌▚      ▖ ▌▞▀▌▌ ▌▐ ▖▞▀▌▝▀▖ ▌  ▐▐ ▖▐ ▖▐ ▛▀  ▐ ▌ ▌▌ ▌▌▚ 
▀▘▀▀ ▝▀ ▘ ▘     ▝▀ ▝▀▘▘ ▘ ▀ ▝▀▘▀▀  ▀▀▘▀▘▀  ▀  ▘▝▀▘ ▀▘▀▀ ▝▀ ▘ ▘
```

What does IDOR stand for?
-----------------------------------------------------------------------------------------
An *Insecure Direct Object Reference* (IDOR) occurs when a web application exposes direct
reference to an object, like a file or a database, which the user can directly control to
obtain access to other similar, but sensitive objects. It is a type of access control
vulnerability that can be exploited when web servers don't check access rights before the
sending of data.

What type of privilege escalation are most IDOR cases?
-----------------------------------------------------------------------------------------
IDOR vulnerabilities are often enabling an attacker to use a feature they are authorized
to use without gaining access to more features per default. They are therefore an example
for *horizontal privilege escalation* in a majority of the cases but an exploitation
might reach further access rights as well.

Upon exploiting the IDOR found in the `view_accounts` parameter, what is the `user_id` of
the parent that has 10 children?
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
