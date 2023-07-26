SetWorkingDir, %A_ScriptDir%
#include C:\poe\info.ini
#include C:\poe\ninja\json.ahk
URL = https://www.pathofexile.com/api/trade/search/%League%
URL2 = https://www.pathofexile.com/trade/search/%League%
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
    if a_index=5
		docookie=%param%
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
if docookie=1
	HTTP.SetRequestHeader("Cookie", sesid)
HTTP.SetRequestHeader("User-Agent", "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0)")

data = 
(
{"sort": {"price": "asc"},"query":{"status":{"option":"online"}, %zquery%}}
)

try
{
	HTTP.Send(data)
	HTTP.WaitForResponse()
	ids := HTTP.ResponseText
	header1 := HTTP.getResponseHeader("x-rate-limit-ip")
	header2 := HTTP.getResponseHeader("x-rate-limit-ip-state")
	idsData := JSON.load(ids)
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
price:=0
total:=0
loop, 100
{
	i%a_index%:=
}
idsData := JSON.load(ids)
queryid := idsData.id
total := idsData.total
loop
{
	idsdataresult := idsData.result[a_index]
	if idsdataresult=
		break
	i%a_index%:=idsData.result[a_index]
}

if total=0
{
	averageprice=
	goto printing
}	
averageurl = https://www.pathofexile.com/api/trade/fetch/%i1%,%i2%,%i3%,%i5%,%i10%,%i15%,%i20%,%i30%,%i50%,%i100%

mark6:
HTTP2 := ComObjCreate("WinHTTP.WinHttpRequest.5.1")
HTTP2.Open("GET", averageurl, 0)
HTTP2.SetProxy(2, proxy_ip)
;HTTP2.SetCredentials(proxy_username, proxy_password, 1)
if docookie=1
	HTTP2.SetRequestHeader("Cookie", sesid)
HTTP2.SetRequestHeader("User-Agent", "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0)")
try
{
	HTTP2.Send()
	HTTP2.WaitForResponse()
	averageitem := HTTP2.ResponseText
}
catch e
{
	FormatTime, curtime,,MMMM d HH:mm
	fileappend, %curtime% sub error fetching %proxy_ip%`n, C:\poe\error.log
	comparetime := ""
	EnvAdd, comparetime, -24, hour
	FileSetTime, %comparetime%, C:\poe\querydata\%zname%.csv, M
	goto ending
}

value:=0
averageprice=
itemsData := JSON.load(averageitem)
loop, 10
{
	chaosprice:=0
	currency := itemsData.result[a_index].listing.price.currency
	value := itemsData.result[a_index].listing.price.amount
	if value=
		break
	stringreplace,currency,currency,exalted,Exalted Orb
	stringreplace,currency,currency,divine,Divine Orb
	stringreplace,currency,currency,scour,Orb of Scouring
	stringreplace,currency,currency,regret,Orb of Regret
	stringreplace,currency,currency,fusing,Orb of Fusing
	stringreplace,currency,currency,alch,Orb of Alchemy
	stringreplace,currency,currency,chisel,Cartographer's Chisel
	stringreplace,currency,currency,awakened-sextant,Awakened Sextant
	stringreplace,currency,currency,elevated-sextant,Elevated Sextant
	stringreplace,currency,currency,jewellers,Jeweller's Orb
	stringreplace,currency,currency,chance,Orb of Chance
	stringreplace,currency,currency,chrome,Chromatic Orb
	stringreplace,currency,currency,mirror,Mirror of Kalandra
	stringreplace,currency,currency,vaal,Vaal Orb
	stringreplace,currency,currency,blessed,Blessed Orb
	stringreplace,currency,currency,gcp,Gemcutter's Prism
	stringreplace,currency,currency,regal,Regal Orb
	if currency = alt
		stringreplace,currency,currency,alt,Orb of Alteration
	if currency = chaos
		chaosprice := value
	else
	{
		exchangerate:=1
		Loop, Read, currency.txt
		{
			ifinstring, A_LoopReadLine, %currency%
			ifnotinstring, A_LoopReadLine, Hunter
			ifnotinstring, A_LoopReadLine, Warlord
			ifnotinstring, A_LoopReadLine, Redeemer
			ifnotinstring, A_LoopReadLine, Crusader
			ifnotinstring, A_LoopReadLine, Tainted
			ifnotinstring, A_LoopReadLine, Eldritch
			{
				loop, parse, A_LoopReadLine,`,
				{
					if a_index=2
						exchangerate:=A_LoopField
				}
			}
		}
		chaosprice+=exchangerate*value
		chaosprice:=RegExReplace(chaosprice,"0+$")
	}
	averageprice=%averageprice%`,%chaosprice%
}
printing:
filedelete, C:\poe\querydata\%zname%.csv
FormatTime, TimeString,,MMMM d HH:mm:ss
fileappend, `n`"%zname%`"`,`"%TimeString% %proxy_ip% %header2%`"`,%URL2%/%queryid%`,%total%%averageprice%, C:\poe\querydata\%zname%.csv
fileread, checkfile, C:\poe\querydata\%zname%.csv
StringReplace, checkfile, checkfile, `,, `,, UseErrorLevel
if ErrorLevel>20
	filedelete, C:\poe\querydata\%zname%.csv
ending: