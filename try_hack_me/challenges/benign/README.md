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

-> tbc Chris creates processes with `/nostartup`

[^1]: https://tryhackme.com/room/benign
[^2]: https://research.splunk.com/stories/scheduled_tasks/#data-sources
