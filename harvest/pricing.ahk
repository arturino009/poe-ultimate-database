#include C:\poe\json.ahk
#include C:\poe\info.ini
FileName_y = %filepath%pricing.txt
ifexist, tft.png
	menu, tray, icon, tft.png
url1 = https://raw.githubusercontent.com/The-Forbidden-Trove/tft-data-prices/master/lsc/bulk-beasts.json
url2 = https://raw.githubusercontent.com/The-Forbidden-Trove/tft-data-prices/master/lsc/bulk-compasses.json
url3 = https://raw.githubusercontent.com/The-Forbidden-Trove/tft-data-prices/master/lsc/bulk-expedition.json
url4 = https://raw.githubusercontent.com/The-Forbidden-Trove/tft-data-prices/master/lsc/bulk-heist.json
url5 = https://raw.githubusercontent.com/The-Forbidden-Trove/tft-data-prices/master/lsc/bulk-invitation.json
url6 = https://raw.githubusercontent.com/The-Forbidden-Trove/tft-data-prices/master/lsc/bulk-maps.json
url7 = https://raw.githubusercontent.com/The-Forbidden-Trove/tft-data-prices/master/lsc/bulk-sets.json
url8 = https://raw.githubusercontent.com/The-Forbidden-Trove/tft-data-prices/master/lsc/bulk-simulacrum.json
url9 = https://raw.githubusercontent.com/The-Forbidden-Trove/tft-data-prices/master/lsc/bulk-vessel.json
url10 = https://raw.githubusercontent.com/The-Forbidden-Trove/tft-data-prices/master/lsc/bulk-watcher's-eye.json
url11 = https://raw.githubusercontent.com/The-Forbidden-Trove/tft-data-prices/master/lsc/hideout.json
url12 = https://raw.githubusercontent.com/The-Forbidden-Trove/tft-data-prices/master/lsc/service.json
start:
FormatTime, TimeString,, yyyy-MM-dd hh:mm
fileappend %TimeString%`n,pricing.txt
loop, 12
{
	url:=url%a_index%
	HTTP1 := ComObjCreate("WinHTTP.WinHttpRequest.5.1")
	HTTP1.Open("GET", url, 0)
	HTTP1.Send()
	HTTP1.WaitForResponse()
	thing := HTTP1.ResponseText
	thingdata := JSON.load(thing)
	fileappend `"%url%`"`n,pricing.txt
	loop
	{
		name:=thingdata.data[a_index].name
		chaos:=thingdata.data[a_index].chaos
		if name=
			break
		fileappend `"%name%`"`,%chaos%`,chaos`n,pricing.txt
	}
}
mark2:
filedelete, %FileName_y%
if FileExist(FileName_y)
	goto mark2
filemove, pricing.txt, %FileName_y%
sleep, 1800000
goto start