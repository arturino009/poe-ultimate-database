# poe-ultimate-database

## Here we will manage the csv and corresponding files in order to host the database made by pathofmathh.

How to:

Go to: https://docs.google.com/spreadsheets/d/18WQBtmmPk7XfFnOnBb0rGN2Y7D5GFOTzD81YfdZr1vo/edit?usp=sharing -> File -> Make a Copy

Go to Google Document -> Copy of PathofMatth's Database.  -> Extensions -> App Scripts -> the xeskeko script.gs (both)-> function -> FolderName = "Change to YOUR Google Drive Folder"

Go to PoE Zip -> info.ini -> League = "Change to League Name"

-> "sesid = POESESSID`=" -> Put your Session ID. This is required. I would log into a 2nd throw-away account on another browser from your main one,
click "remember me" or "stay logged in" or whatever and just forget about it. If scripts act up or data is missing, make sure to log back in.

-> Filepath = "change to where you will want the data exported, you will need a shared folder linked to a google drive"

-> I would make a folder called "shared" on your C: drive and a folder called "upload" in your google drive. Scripts will do the rest.

(This Shared Folder is what will feed your google drive with the information required to paste data in the sheet)

time = hours before data is updated -> You can speed this up based on how many proxies you have but 12/4/2/1 is solid to prevent errors or problems.

The "killswitch.ini" file is to stop all scripts. This is useful early league when website keeps going down, the scripts will just throw constant
pop-up errors if you let them run otherwise. 

I would recommend around 15-20 proxies working 24/7. You will also need a server to run the script 24/7 or do like me, keep your PC on at all times.

To run all scripts -> double click -> upload.ahk and all scripts will turn on, scripts will auto-restart if they fail after after a few minutes.

You will need the pastebin URL list, this is what the scrips are reading in order to find queries.

PoEStack NEEDS to work. No PoEStack = no data. So goodluck dealing with Zach, or have someone else build PoEStack.


Links to the URL for the Scripts:

https://pastebin.com/pzrzCkMp 
https://pastebin.com/vydwA326
https://pastebin.com/hnhLqz26
https://pastebin.com/ewd7Hhnf
https://pastebin.com/DMHvYZYc
https://pastebin.com/ZdwnEZ7t

Open your own pastebin account and copy these and make your own pastebin of these URL / item / keyword lists. Title them the same as here. 

Then, the first 3, you will take your own pastebin URL and change the ones in "itemnew.ahk". ("scriptnew" folder)
Do the same with the 4th pastebin in the "lab.ahk" script. ("lab" folder)
Finally the last URL, you need to change for your own in the "meta.ahk" script. ("youtube" folder)

You can get your own proxies wherever you want. I used those from here: https://www.sharedproxies.com/

Post your proxies IP under "proxy list.txt" in the "poe" folder using the format of the example. Important to have the port!

Cheap & EXTREMELY reliable.

Honestly if you have any other issues... You're going to have to figure it out on your own, because neither myself or Xeskeko will be willing
to put much more time into this. 

Shoutout to Xeskeko for being an absolute legend, building the scripts, the excell sheets, the formulas... Everything. 

Good luck!

The "error.txt" file in the "poe" folder will let you know if any of your proxies is acting up or if any specific script is acting up. 

A simple restart of that script will typically fix everything alongside delete the .txt file with it's data. (in the shared folder)
