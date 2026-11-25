```                                                                               
 _____     _   _           _   _         _   _            _____                     
|  _  |_ _| |_| |_ ___ ___| |_|_|___ ___| |_|_|___ ___   | __  |_ _ ___ ___ ___ ___ 
|     | | |  _|   | -_|   |  _| |  _| .'|  _| | . |   |  | __ -| | | . | .'|_ -|_ -|
|__|__|___|_| |_|_|___|_|_|_| |_|___|__,|_| |_|___|_|_|  |_____|_  |  _|__,|___|___|
                                                               |___|_|              
```
In this THM room, we want to learn how to defeat logins and other authentication
mechanisms to get access to unpermitted areas. [^1]

Task 2 - Username Enumeration
-----------------------------------------------------------------------------------------
**What is the username starting with the `si***`, `st***` and `ro****` strings?**

Upon trying to sign up a fake username, the error message "An account with this username
already exists." can be discovered. So, we use `ffuf` to enumerate a list of potential
usernames and check if the "username already exists".
```text
$ ffuf -w /usr/share/wordlists/SecLists/Usernames/Names/names.txt -X POST
    -d "username=FUZZ&email=x&password=x&cpassword=x"
    -H "Content-Type: application/x-www-form-urlencoded"
    -u http://<MACHINE_IP_ADDRESS>/customers/signup
    -mr "username already exists" > valid_usernames.txt
```
This results in a list of usernames, e.g. *simon*, *steve* and *robert*.

Task 3 - Brute Force
-----------------------------------------------------------------------------------------
**What is the valid username and password (format: username/password)?**

Once again, we can use the `ffuf` web fuzzer to rely on a list of passwords when brute
forcing a username and password combination. First, we provide the `valid_usernames.txt`
output from the previous task and then enumerate through the 100 most common passwords.
```text
$ ffuf -w valid_usernames.txt:W1,/usr/share/wordlists/SecLists/Passwords/Common-
    Credentials/10-million-password-list-top-100.txt:W2 -X POST
    -d "username=W1&password=W2"
    -H "Content-Type: application/x-www-form-urlencoded"
    -u http://<MACHINE_IP_ADDRESS>/customers/login -fc 200
```
This way, we are able to obtain the username *steve* and the password *thunder*.

Task 4 - Logic Flaw
-----------------------------------------------------------------------------------------
**What is the flag from Robert's support ticket?**

The password reset function `http://<MACHINE_IP_ADDRESS>/customers/reset` of the Acme IT
Support website asks for an email address associated with the account one wishes to
perform the password reset on. And if an invalid email address is entered, the error
message "Account not found from supplied email address" gets printed. For this task, we
want to reset Robert's password and thus enter the email address
`robert[@]acmeitsupport.thm`, then we need to enter a username, which should be *robert*
in this case. If we follow this web mask, we are bound to perform two HTTP requests in
the following order with these parameters:

1. Provide an existing email address in a POST request for the password reset:
   `http://<MACHINE_IP_ADDRESS>/customers/reset?email=robert[@]acmeitsupport.thm`
2. Submit the username in a POST field to the webserver while the email address
   is sent as a GET field: username=robert

Now, it is good to know that the PHP `$_REQUEST` variable is an array containing
the data received from both the query string and POST data. Now, if the same key
name is used for both the query string and POST data, the application logic for
tis variable favours the POST data field rather than the query string. It is now
our objective, to control where the password reset email gets delivered to with
the use of an additional POST field. But first, we need to create a new account
for the user "mark" which shall receive the password reset link for "robert".
```text
$ curl 'http://<MACHINE_IP>/customers/reset?email=robert[@]acmeitsupport.thm'
    -H 'Content-Type: application/x-www-form-urlencoded'
    -d 'username=robert&email=mark@customer.acmeitsupport.thm'
```
And indeed, the username matches the email username for which the password shall
be reset. But, the email to which the reset support ticket link will be sent is
different. Using this support ticket, we can log in as Robert and get the flag.

Task 5 - Cookie Tampering
-----------------------------------------------------------------------------------------
**What is the flag from changing the plain text cookie values?**

If we set the *admin* cookie to *true* and create a new `logged_in` cookie which is also
set to "true", we can get the first flag after refreshing the page.

**What is the value of the md5 hash 3b2a1053e3270077456a79192070aa78?**

In order to get the MD5 value of the hash, we can rely on the online tool [^2] which
returns the result *463729*.

**What is the base64 decoded value of VEhNe0JBU0U2NF9FTkNPRElOR30=?**

For the base64 encoded string, we can rely on the tool `base64 -d` which decodes the
string to the plain text flag.

**Encode the value using base64 {"id":1,"admin":true}.**

And in the same way, we can encode the string `{"id":1,"admin":true}` with `base64`
to the flag for this task.

[^1]: https://tryhackme.com/room/authenticationbypass
[^2]: https://crackstation.net/
