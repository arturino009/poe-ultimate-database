SetWorkingDir, %A_ScriptDir%
#include C:\poe\info.ini
#include C:\poe\json.ahk

ifexist, item.ico
	menu, tray, icon, item.ico

itemlistfile:=item%dir%
URLninja = 
(
https://poe.ninja/api/data/currencyoverview?league=%League%&type=Currency
)

ninja:
resettimer=0
proxyline=1

filedelete, currency.txt
HTTPninja := ComObjCreate("WinHTTP.WinHttpRequest.5.1")
HTTPninja.Open("GET", URLninja, 0)
HTTPninja.SetRequestHeader("Content-Type", "application/json")
HTTPninja.SetRequestHeader("User-Agent", "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0)")
try
{
	HTTPninja.Send()
	HTTPninja.WaitForResponse()
	ninjacurrency := HTTPninja.ResponseText
}
catch
{
	FormatTime, curtime,,MMMM d HH:mm
	fileappend, %curtime% ninja error %proxy_ip%`n, C:\poe\error.log	
	sleep, %timeouttime%
    goto ninja
}
ninjaData := JSON.load(ninjacurrency)
loop
{
	StringLen, length, % ninjaData.lines[a_index].currencyTypeName
	if length > 0
	{
		fileappend % ninjaData.lines[a_index].currencyTypeName, currency.txt
		fileappend,`,, currency.txt
		fileappend % ninjaData.lines[a_index].receive.value, currency.txt
		fileappend,`n, currency.txt
	}
	else
		break
}
	
filedelete, item list.txt
filedelete, item list2.txt
filedelete, item list3.txt
urldownloadtofile, https://pastebin.com/raw/1jpiPW9m, item list.txt
urldownloadtofile, https://pastebin.com/raw/gsrV9VBF, item list2.txt
urldownloadtofile, https://pastebin.com/raw/GLTH6snB, item list3.txt
FileRead, appe, item list2.txt
FileAppend, `n%appe%, item list.txt
FileRead, appe, item list3.txt
FileAppend, `n%appe%, item list.txt
Loop, Read, item list.txt
{
	loop, parse, A_LoopReadLine,%a_tab%
	{
		if a_index=1
			zname:=A_Loopfield
	}
	IfNotExist, C:\poe\querydata\%zname%.csv
		if zname<>index
		{
			FileAppend, `n, C:\poe\querydata\%zname%.csv
			comparetime := ""
			EnvAdd, comparetime, -24, hour
			FileSetTime, %comparetime%, C:\poe\querydata\%zname%.csv, M
		}
}

query:

;pick proxy
Loop, Read, C:\poe\proxy list.txt
{
   proxy_lines = %A_Index%
}
proxyline+=1
if proxyline>%proxy_lines%
	proxyline=1
FileReadLine, proxy, C:\poe\proxy list.txt, %proxyline%
loop, parse, proxy, %a_tab%
{
	if a_index=1
		proxy_ip=%A_LoopField%
	if a_index=2
		proxy_username=%A_LoopField%
	if a_index=3
		proxy_password=%A_LoopField%
}

;pick query
noskip:=0
Loop, Read, item list.txt
{
	loop, parse, A_LoopReadLine,%a_tab%
	{
	if a_index=1
		zname=%A_LoopField%
	if a_index=2
		ztime=%A_LoopField%
	if a_index=3
		zquery=%A_LoopField%
		
	}
	comparetime := ""
	if ztime=slow
		EnvAdd, comparetime, -%timeslow%, hour
	if ztime=vslow
		EnvAdd, comparetime, -%timevslow%, hour
	if ztime=fast
		EnvAdd, comparetime, -%timefast%, hour
	if ztime=vfast
		EnvAdd, comparetime, -%timevfast%, hour
	FileGetTime, filetimesec, C:\poe\querydata\%zname%.csv, M
	if comparetime>%filetimesec%
	{
		noskip:=1
		FileSetTime, , C:\poe\querydata\%zname%.csv, M
		break
	}
}

if instr(zquery,"weight")
	docookie:=1
else
	docookie:=0

howmanyup:
DetectHiddenWindows, On
scriptsup:=0
WinGet, List, List, ahk_class AutoHotkey
scripts := ""
Loop % List {
   WinGetTitle, title, % "ahk_id" List%A_Index%
   scripts .=  (scripts ? "`r`n" : "") . RegExReplace(title, " - AutoHotkey v[\.0-9]+$")
}
loop, parse, scripts, `r`n
{
	if a_loopfield=C:\poe\scriptnew\sub.ahk
		scriptsup+=1
	if a_loopfield=C:\poe\scriptnew\subcons.ahk
		scriptsup+=1
}
if scriptsup>=10
{
	sleep, 1000
	goto howmanyup
}
if proxy_username=
	proxy_username=0
if proxy_password=
	proxy_password=0
if noskip=1
{
	if instr(zname,"c")
		Run, subcons.ahk %proxy_ip% %proxy_username% %proxy_password% %zname%
	else
		Run, sub.ahk %proxy_ip% %proxy_username% %proxy_password% %zname% %docookie%
}
sleep, 1000
resettimer+=1
if resettimer<2000
	goto query
else
	goto ninja