```
   ,--,                                                    
,---.'|                                                    
|   | :                ___      ___                        
:   : |              ,--.'|_  ,--.'|_                      
|   ' :              |  | :,' |  | :,'             __  ,-. 
;   ; '              :  : ' : :  : ' :           ,' ,'/ /| 
'   | |__   ,---.  .;__,'  /.;__,'  /     ,---.  '  | |' | 
|   | :.'| /     \ |  |   | |  |   |     /     \ |  |   ,' 
'   :    ;/    /  |:__,'| : :__,'| :    /    /  |'  :  /   
|   |  ./.    ' / |  '  : |__ '  : |__ .    ' / ||  | '    
;   : ;  '   ;   /|  |  | '.'||  | '.'|'   ;   /|;  : |    
|   ,/   '   |  / |  ;  :    ;;  :    ;'   |  / ||  , ;    
'---'    |   :    |  |  ,   / |  ,   / |   :    | ---'     
          \   \  /    ---`-'   ---`-'   \   \  /           
           `----'                        `----'            
```
It's just another Monday morning on your mail delivery route when an unusual letter
catches your eye. The envelope is battered, riddled with holes as if it's been through
a storm. The address is barely legible, and your coworkers at the post office wave it
off as a lost cause. But something about it nags at you.
You carefully open the damp envelope. Inside, you find a faded newspaper clipping and
a short handwritten note. The clipping is torn and water-damaged, with key sections
missing. The note is personal, clearly not meant for your eyes, but the fragments you
can read hint at a story buried in time.
Use the clues provided in the zip file to uncover the full name and age of the person
mentioned in the note. [^1]

What is the postal code of the delivery address on the envelope?
-----------------------------------------------------------------------------------------
After decompressing the archive, we discover the leter, the newspaper clipping and a note
with the contents of the french letter. We translate it with the command `trans -i
Note.txt -s fr -b` and thus get the following mail translation.

> My dear Édouard,
>
> Today, while cleaning out the attic at my grandparents' house, I came across this old
> newspaper clipping. Your great-grandfather wasn't even old enough to get his driving
> license when he stood out that day. The youngest member of the team, and certainly
> not the least courageous.
>
> He would be so proud to see you on the water too.
> 
> With all my affection, \
> Audette

We then proceed to try to read the newspaper headlines and besides an article on urgent
work, and events in Morocco, we suspect the article on a North Pole expedition. From the
article we can see, that *Amundi* is expected to reach the north pole and try to find
out more about it. Therefore, we discover the *Roald Amundsen North Pole* airplane
expedition [^2] which started on 21st May 1925. Therefore, we expect this newspaper
exerpt to be from late May 1925 at least. But nothing indicates that this is the article
where his great-grandfather was a part of because it was a Norwegian crew. Instead, we
try to read the center article with a catastrophe at *Finistère* in May 1925. This way,
we discover several sites on a marine disaster [^3] in May 24, 1925 where twenty-six men
drowned. What is interesting about this article, is that it details the brave quest of
a few men saving the crew. Then, we suspect to look up the postal code of *Penmarch*
and just suspect *Édouard* to still live there. And indeed, the flag is accepted.

What is the flag?
-----------------------------------------------------------------------------------------
Upon reading the newspaper article [^3] one more time and searching for the youngest
member, we come across a *Gourlaouen Yves Marie* who was 15 years old at the time of the
event. This would make sense because the letter reads that his great-grandfather wasn't
even old enough to get his driving licence. He was awarded a second arpent's medal for
his bravery of saving fishermen during the storm.

[^1]: https://tryhackme.com/room/letter
[^2]: https://www.rsgs.org/blog/roald-amundsen
[^3]: https://kbcpenmarch.franceserv.com/la-catastrophe-du-23-mai-1925-selon-la-presse-locale.html
