LogToFile(logMessage) {
	; Format the current date and time
	FormatTime, currentTime,, yyyy-MM-dd HH:mm:ss
	; Prepare the log message with the current date and time
	fullLogMessage := currentTime . " - " . logMessage . "`n"
	; Append the log message to a file
	FileAppend, %fullLogMessage%, debug_log.txt
}

SetWorkingDir, %A_ScriptDir%
#include C:\poe\info.ini
FileName = %filepath%ninja.txt
pathoftemps=%A_ScriptDir%\querydata
ifexist, ninja.ico
	menu, tray, icon, ninja.ico

LogToFile("Starting up...")

checkforsingles1=
(
totalValidListings,0,
)
checkforsingles2=
(
,p5,0,
)
checkforbulk1=
(
totalValidListings
)
checkforbulk2=
(
,p10,
)
checkforbulk3=
(
,p5,
)
gemquality0=
(
{""key"":""quality"",""value"":""0""}
)
gemquality20=
(
{""key"":""quality"",""value"":""20""}
)
loop, 21
{
	maptier%a_index%=
	(
	[{""key"":""tier"",""value"":""%a_index%""}]
	)
	gemlvl%a_index%=
	(
	{""key"":""lvl"",""value"":""%a_index%""}
	)
}

phase1:
LogToFile("Phase1 started.")
loop, files, %pathoftemps%\*.csv
{
	filedelete, %A_LoopFileFullPath%
}

isaiddeleteexport:
filedelete, export_2.csv
ifexist, export_2.csv
	goto isaiddeleteexport
filemove, export.csv, export_2.csv

url=
(
https://raw.githubusercontent.com/PoeStack/poestack-public-data/master/poe/leagues/%League%/economy/pvalue_p5.csv
)
urldownloadtofile, %url%, export.csv
url2=
(
https://raw.githubusercontent.com/PoeStack/poestack-public-data/master/poe/leagues/%League%/economy/pvalue_totalValidListings.csv
)
urldownloadtofile, %url2%, temp.csv
fileread, temp, temp.csv
fileappend, `n%temp%,export.csv
filedelete, temp.csv

filegetsize, export_2, export_2.csv
filegetsize, export, export.csv
if export=%export_2%
{
	sleep, 300000
	goto phase1
}

parser:
LogToFile("Parser started.")

loop, read, export.csv
{
	replacingline:=a_loopreadline
	tag=
	loop, parse, replacingline,csv
	{
		if a_index=2
			tag=%a_loopfield%
	}
	if tag=unique
		if instr(replacingline,checkforsingles1) || instr(replacingline,checkforsingles2)
			fileappend, %replacingline%`n, %pathoftemps%\%tag%.csv
	if tag=map
		if instr(replacingline,checkforbulk1) || instr(replacingline,checkforbulk2) || instr(replacingline,checkforbulk3)
			if instr(replacingline,maptier1) || instr(replacingline,maptier2) || instr(replacingline,maptier3) || instr(replacingline,maptier4) || instr(replacingline,maptier5) || instr(replacingline,maptier16)
				fileappend, %replacingline%`n, %pathoftemps%\%tag%.csv
	if tag=gem
		if instr(replacingline,checkforsingles1) || instr(replacingline,checkforsingles2)
			if instr(replacingline,gemquality0) || instr(replacingline,gemquality20)
				if instr(replacingline,gemlvl21) || instr(replacingline,gemlvl20) || instr(replacingline,gemlvl6) || instr(replacingline,gemlvl5) || instr(replacingline,gemlvl4) || instr(replacingline,gemlvl3) || instr(replacingline,gemlvl1)
					fileappend, %replacingline%`n, %pathoftemps%\%tag%.csv
	if (tag<>"gem") and (tag<>"unique") and (tag<>"map") and (tag<>"cluster")
		if instr(replacingline,checkforbulk1) || instr(replacingline,checkforbulk2) || instr(replacingline,checkforbulk3)
			fileappend, %replacingline%`n, %pathoftemps%\%tag%.csv
}
phase2:
LogToFile("Phase2 started.")

filedelete, ninja.txt
FormatTime, curtime,,MMMM d HH:mm
MsgBox Preparing to write to ninja.txt...
fileappend, %curtime%`,entity`,description`,bulk`,totalValidListings`,price`n, ninja.txt
thearray:=[]
loop, read, zachwishllist.txt
{
	wishlist=
	wishlist1=
	wishlist2=
	wishlist3=
	code1=
	code2=
	code3=
	code4=
	stuff=
	stuff1=
	stuff2=
	stuff3=
	stuff4=
	stuff5=
	descriptions=
	descriptions1=
	descriptions2=
	descriptions3=
	stringsplit, wishlist, a_loopreadline, %a_tab%
	loop, read, descriptions.txt
	{
		stringsplit, descriptions, a_loopreadline, %a_tab%
		if descriptions1=%wishlist3%
		{
			code1:=descriptions2
			code2:=descriptions3
			code3:=descriptions4
			code4:=descriptions5
		}
	}
	loop, read, %pathoftemps%\%wishlist1%.csv
	{
		if instr(a_loopreadline,wishlist2)
		if instr(a_loopreadline,code1)
		if instr(a_loopreadline,code2)
		if instr(a_loopreadline,code3)
		if instr(a_loopreadline,code4)
		{
			loop, parse, a_loopreadline, csv
			{
				stuff%a_index%:=a_loopfield
			}
			stuff="%wishlist1%"`,"%stuff1%"`,"%wishlist3%"`,"%stuff5%"
			if HasVal(thearray,stuff)=0
			{
				thearray.Push(stuff)
			}
		}
	}
}
loop
{
	tempvar:=thearray[a_index]
	if tempvar=
		break
	LogToFile("Processing item: " . a_index)
	loop, parse, tempvar, csv
	{
		morestuff%a_index%:=a_loopfield
	}
	type:=morestuff1
	entity:=morestuff2
	description:=morestuff3
	bulk:=morestuff4
	totalValidListings=
	price=
	code1=
	code2=
	code3=
	code4=
	loop, read, descriptions.txt
	{
		stringsplit, descriptions, a_loopreadline, %a_tab%
		if descriptions1=%description%
		{
			code1:=descriptions2
			code2:=descriptions3
			code3:=descriptions4
			code4:=descriptions5
		}
	}
	loop, read, %pathoftemps%\%type%.csv
	{
		if instr(a_loopreadline,code1)
		if instr(a_loopreadline,code2)
		if instr(a_loopreadline,code3)
		if instr(a_loopreadline,code4)
		{
			if instr(a_loopreadline,"anomalous")
				ifnotinstring, description, anomalous
					goto notright
			if instr(a_loopreadline,"divergent")
				ifnotinstring, description, divergent
					goto notright
			if instr(a_loopreadline,"phantasmal")
				ifnotinstring, description, phantasmal
					goto notright
			loop, parse, a_loopreadline, csv
			{
				parsing%a_index%:=a_loopfield
			}
			if parsing1=%entity%
			if parsing5=%bulk%
			{
				if parsing4=totalValidListings
					totalValidListings:=parsing6
				if parsing4=p5
					price:=parsing6
			}
		}
		notright:
	}
	fileappend, %type%`,"%entity%"`,%description%`,%bulk%`,%totalValidListings%`,%price%`n,ninja.txt
}
LogToFile("Writing to ninja.txt completed.")

isaiddelete:
FileDelete, %FileName%
ifexist, %FileName%
	goto isaiddelete
FileMove, ninja.txt, %FileName%
LogToFile("Moving ninja.txt to FileName.")

sleep, 60000
goto phase1

HasVal(haystack, needle) {
	if !(IsObject(haystack)) || (haystack.Length() = 0)
		return 0
	for index, value in haystack
		if (value = needle)
			return index
	return 0
}