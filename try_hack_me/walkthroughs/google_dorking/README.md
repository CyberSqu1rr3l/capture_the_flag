```
    \/       .-.        .-.        \/   W  W    wWw       _        .-.   ()_()       _ wW  Ww\\\  ///   \/    
   (OO)    c(O_O)c    c(O_O)c     (OO) (O)(O)   (O)_     /||_    c(O_O)c (O o)(OO) .' )(O)(O)((O)(O))  (OO)   
 ,'.--.)  ,'.---.`,  ,'.---.`,  ,'.--.)  ||     / __)     /o_)  ,'.---.`, |^_\ ||_/ .'  (..)  | \ || ,'.--.)  
/ /|_|_\ / /|_|_|\ \/ /|_|_|\ \/ /|_|_\  | \   / (       / |(\ / /|_|_|\ \|(_))|   /     ||   ||\\||/ /|_|_\  
| \_.--. | \_____/ || \_____/ || \_.--.  |  `.(  _)      | | ))| \_____/ ||  / ||\ \    _||_  || \ || \_.--.  
'.   \) \'. `---' .`'. `---' .`'.   \) \(.-.__)\ \_      | |// '. `---' .`)|\\(/\)\ `. (_/\_) ||  ||'.   \) \ 
  `-.(_.'  `-...-'    `-...-'    `-.(_.' `-'    \__)     \__/    `-...-' (/  \)    `._)      (_/  \_) `-.(_.'     
```
This TryHackMe room "Google Dorking" explains how Search Engines work and leverages them
into finding hidden content. [^1]

QUESTION 1
-----------------------------------------------------------------------------------------
**Name the key term of what a "Crawler" is used to do. This is known as a collection of 
resources and their locations.**

Crawlers are used to *index* the entire contents of a domain, looking for keywords and
other miscellaneous information and send them to the Search Engines that stores them for
later search.

QUESTION 2
-----------------------------------------------------------------------------------------
**What is the name of the technique that "Search Engines" use to retrieve this
information about websites?**

Search engines use *crawling* to traverse every URL, file and keyword on a website. The
so called search engine bots, or crawlers/spiders visit consecutive web pages by
following the links within those sites to find more pages. Crawling is the first step of
the process where search engines discover new and updated content and indexing is how
they catalog that information for later retrieval.

QUESTION 3
-----------------------------------------------------------------------------------------
**What is an example of the type of contents that could be gathered from a website?**

A form of useful content could be *keywords* that are being scraped from a website and
stored in a dictionary by the crawler for the search engine.

The file `Robots.txt` can specify what files and directories should be indexed by the
crawler. The following keywords are interesting to look out for.

- **User-agent:**  Specifies the type of the crawler that can index the site (with
  an asterisk \* being the most common value to allow all user agents)
- **[Dis]Allow:** Set the directories of files that the crawler is [not] allowed to index
- **Sitemap:** Provide a reference to where the sitemap is located for SEO, i.e., Search
  Engine Optimization


QUESTION 4
-----------------------------------------------------------------------------------------
**Where would "robots.txt" be located on the domain "ablog[.]com"?**

The crawler configuration can be found under the path *ablog[.]com/robots.txt*

QUESTION 5
-----------------------------------------------------------------------------------------
**If a website was to have a sitemap, where would that be located?**

A website's sitemap (if existent) is likely to be found in the format */sitemap.xml*.

QUESTION 6
-----------------------------------------------------------------------------------------
**How would we only allow "Bingbot" to index the website?**

We would allow the crawler with *User-agent: Bingbot* to index the website.

QUESTION 7
-----------------------------------------------------------------------------------------
**How would we prevent a "Crawler" from indexing the directory "/dont-index-me/"?**

We would prevent the crawler from indexing this with *Disallow: /dont-index-me/*.

QUESTION 8
-----------------------------------------------------------------------------------------
**What is the extension of a Unix/Linux system configuration file that we might want to
hide from "Crawlers"?**

The configuration files in Unix-based systems are usually appended with the extension
*.conf* that should be hidden from crawlers.

QUESTION 9
-----------------------------------------------------------------------------------------
**What is the typical file structure of a "Sitemap"?**

Sitemaps are typtically formated with *XML*, i.e. Extensible Markup Language.

QUESTION 10
-----------------------------------------------------------------------------------------
**What real life example can "Sitemaps" be compared to?**

They work just like a *map* for crawlers to navigate a website structure.

QUESTION 11
-----------------------------------------------------------------------------------------
**Name the keyword for the path taken for content on a website.**

QUESTION 12
-----------------------------------------------------------------------------------------
QUESTION 13
-----------------------------------------------------------------------------------------
QUESTION 14
-----------------------------------------------------------------------------------------

[^1]: https://tryhackme.com/room/googledorking
