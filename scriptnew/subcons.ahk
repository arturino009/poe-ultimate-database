SetWorkingDir, %A_ScriptDir%
#include C:\poe\info.ini
#include C:\poe\json.ahk
URL = https://www.pathofexile.com/api/trade/exchange/%League%
URL2 = https://www.pathofexile.com/trade/exchange/%League%

Loop, %0%
{
    param := %A_Index%
    if a_index=1
		proxy_ip=%param%
    if a_index=2
		proxy_username=%param%
    if a_index=3
		proxy_password=%param%
    if a_index=4
		zname=%param%
}
Loop, Read, item list.txt
{
	loop, parse, A_LoopReadLine,%a_tab%
	{
	if a_index=1
		tempname=%A_LoopField%
	if a_index=3
		tempquery=%A_LoopField%
	}
	if zname=%tempname%
	{
		zquery:=tempquery
		break
	}
}

HTTP := ComObjCreate("WinHTTP.WinHttpRequest.5.1")
HTTP.Open("POST", URL, 0)
HTTP.SetProxy(2, proxy_ip)
;HTTP.SetCredentials(proxy_username, proxy_password, 1)
HTTP.SetRequestHeader("Content-Type", "application/json")
HTTP.SetRequestHeader("User-Agent", "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0)")

try
{
	HTTP.Send(zquery)
	HTTP.WaitForResponse()
	ids := HTTP.ResponseText
	header1 := HTTP.getResponseHeader("x-rate-limit-ip")
	header2 := HTTP.getResponseHeader("x-rate-limit-ip-state")
	itemsData := JSON.load(ids)
}
catch e
{
	FormatTime, curtime,,MMMM d HH:mm
	fileappend, %curtime% sub error getting ids %proxy_ip%`n, C:\poe\error.log
	comparetime := ""
	EnvAdd, comparetime, -24, hour
	FileSetTime, %comparetime%, C:\poe\querydata\%zname%.csv, M
	goto ending
}
total:=0
addition:=0
hz:
loop, parse, ids, `"
{
	if strlen(a_loopfield)=64
	{
		if instr(a_loopfield,"@")
			addition+=0
		else
			addition+=1
		ids:=strreplace(ids,a_loopfield,addition)
		goto hz
	}
}
itemsData := JSON.load(ids)
queryid := itemsData.id
total := itemsData.total

filedelete, C:\poe\querydata\%zname%.csv
fileappend, `n, C:\poe\querydata\%zname%.csv
FormatTime, TimeString,,MMMM d HH:mm:ss
fileappend, `"%zname%`"`,`"%TimeString% %proxy_ip% %header2%`"`,%URL2%/%queryid%`,%total%, C:\poe\querydata\%zname%.csv
if total>0
loop, 10
{
	price:=0
	stacks1 := itemsData.result[a_index].listing.offers[1].exchange.amount
	stacks2 := itemsData.result[a_index].listing.offers[1].item.amount
	currency := itemsData.result[a_index].listing.offers[1].exchange.currency
	stock := itemsData.result[a_index].listing.offers[1].item.stock
	if currency = chaos
		price := round(stacks1/stacks2,2)
	if currency = divine
		price := round(stacks2/stacks1,2)
	if price>0
		fileappend, `,%price%|%stock%, C:\poe\querydata\%zname%.csv
}
fileread, checkfile, C:\poe\querydata\%zname%.csv
StringReplace, checkfile, checkfile, `,, `,, UseErrorLevel
if ErrorLevel>20
	filedelete, C:\poe\querydata\%zname%.csv
ending: