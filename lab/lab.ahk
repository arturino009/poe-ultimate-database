SetWorkingDir, %A_ScriptDir%
ifexist, lab.ico
	menu, tray, icon, lab.ico
#include C:\poe\info.ini
#include C:\poe\json.ahk
FileName_y = %filepath%enchants.txt
URL = https://www.pathofexile.com/api/trade/search/%League%
proxygo:=1
proxyline:=0
Loop, Read, C:\poe\proxy list.txt
{
   proxy_lines = %A_Index%
}
random, proxyline, 1, %proxy_lines%
filedelete, temp.txt
filedelete, result.txt

mark1:

filedelete, list.txt
urldownloadtofile, https://pastebin.com/raw/QWzcRgZy, list.txt
sleep, 1000

Loop, Read, list.txt
{
   total_csv = %A_Index%
}
loop, %total_csv%
{
	FileReadLine, line, list.txt, %A_Index%
	loop, parse, line, %a_tab%
	{
		if a_index=1
			zname=%A_LoopField%
		if a_index=2
			zquery=%A_LoopField%
	}

	mark55:
	if proxygo=1
	{
		proxygo=0
		lastline:=proxyline
		mark69:
		random, proxyline, 1, %proxy_lines%
		if proxyline=lastline
			goto mark69
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
	}

	minprice:=0
	outer:
	loop
	{
		HTTP := ComObjCreate("WinHTTP.WinHttpRequest.5.1")
		HTTP.Open("POST", URL, 0)
		HTTP.SetProxy(2, proxy_ip)
		;HTTP.SetCredentials(proxy_username, proxy_password, 1)
		HTTP.SetRequestHeader("Content-Type", "application/json")
		HTTP.SetRequestHeader("User-Agent", "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0)")
		sleep, %antilock%
		data = 
		(
		{"sort": {"price": "asc"},"query":{ %zquery%,"filters":{"misc_filters":{"filters":{"corrupted":{"option":"false"}}},"trade_filters":{"filters":{"price":{"option":"divine","min":%minprice%},"indexed":{"option":"3days"}}}},"status":{"option":"any"}}}
		)
		try
		{
			HTTP.Send(data)
			HTTP.WaitForResponse()
			ids := HTTP.ResponseText
			header1 := HTTP.getResponseHeader("x-rate-limit-ip")
			header2 := HTTP.getResponseHeader("x-rate-limit-ip-state")
		}
		catch e
		{
			FormatTime, curtime,,MMMM d HH:mm
			fileappend, %curtime% mark55 error %proxy_ip%`n, C:\poe\error.log
			proxygo:=1
			sleep, %timeouttime%
			goto mark55
		}
		price:=0
		counting:=1
		loop,100
		{
			i%a_index%:=
			tenitemsurl%aIndex%:=
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
		tenitemsurl1 = https://www.pathofexile.com/api/trade/fetch/%i1%,%i2%,%i3%,%i4%,%i5%,%i6%,%i7%,%i8%,%i9%,%i10%
		tenitemsurl2 = https://www.pathofexile.com/api/trade/fetch/%i11%,%i12%,%i13%,%i14%,%i15%,%i16%,%i17%,%i18%,%i19%,%i20%
		tenitemsurl3 = https://www.pathofexile.com/api/trade/fetch/%i21%,%i22%,%i23%,%i24%,%i25%,%i26%,%i27%,%i28%,%i29%,%i30%
		tenitemsurl4 = https://www.pathofexile.com/api/trade/fetch/%i31%,%i32%,%i33%,%i34%,%i35%,%i36%,%i37%,%i38%,%i39%,%i40%
		tenitemsurl5 = https://www.pathofexile.com/api/trade/fetch/%i41%,%i42%,%i43%,%i44%,%i45%,%i46%,%i47%,%i48%,%i49%,%i50%
		tenitemsurl6 = https://www.pathofexile.com/api/trade/fetch/%i51%,%i52%,%i53%,%i54%,%i55%,%i56%,%i57%,%i58%,%i59%,%i60%
		tenitemsurl7 = https://www.pathofexile.com/api/trade/fetch/%i61%,%i62%,%i63%,%i64%,%i65%,%i66%,%i67%,%i68%,%i69%,%i70%
		tenitemsurl8 = https://www.pathofexile.com/api/trade/fetch/%i71%,%i72%,%i73%,%i74%,%i75%,%i76%,%i77%,%i78%,%i79%,%i80%
		tenitemsurl9 = https://www.pathofexile.com/api/trade/fetch/%i81%,%i82%,%i83%,%i84%,%i85%,%i86%,%i87%,%i88%,%i89%,%i90%
		tenitemsurl10 = https://www.pathofexile.com/api/trade/fetch/%i91%,%i92%,%i93%,%i94%,%i95%,%i96%,%i97%,%i98%,%i99%,%i100%
		lop:=min(10,ceil(total/10))
		loop, %lop%
		{
			HTTP2 := ComObjCreate("WinHTTP.WinHttpRequest.5.1")
			HTTP2.Open("GET", tenitemsurl%a_index%, 0)
			sleep, %antilock2%
			HTTP2.SetProxy(2, proxy_ip)
			;HTTP2.SetCredentials(proxy_username, proxy_password, 1)
			HTTP2.SetRequestHeader("User-Agent", "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0)")
			try
			{
				HTTP2.Send()
				HTTP2.WaitForResponse()
				tenitemslist := HTTP2.ResponseText
			}
			catch e
			{
				FormatTime, curtime,,MMMM d HH:mm
				fileappend, %curtime% mark66 error %proxy_ip%`n, C:\poe\error.log	
				proxygo:=1
				sleep, %timeouttime%
				goto mark55
			}
			averageprice=
			value:=0
			itemsData := JSON.load(tenitemslist)
			loop, 10
			{
				flavour=
				influence=
				itemindex:=a_index
				;stasheditem = % itemsData.result[itemindex].listing.stash.name a_space itemsData.result[itemindex].listing.stash.x a_space itemsData.result[itemindex].listing.stash.y a_space itemsData.result[itemindex].listing.account.name
				stasheditem = % itemsData.result[itemindex].listing.stash.x a_space itemsData.result[itemindex].listing.stash.y
				value := itemsData.result[itemindex].listing.price.amount
				currency := itemsData.result[itemindex].listing.price.currency
				nametype = % itemsData.result[itemindex].item.name
				basetype = % itemsData.result[itemindex].item.baseType
				ilvl = % itemsData.result[itemindex].item.ilvl
				enchant = % itemsData.result[itemindex].item.enchantMods[1]
				flavour = % itemsData.result[itemindex].item.flavourText[1]
				if itemsData.result[itemindex].item.influences.redeemer = 1
					influence=%influence%redeemer
				if itemsData.result[itemindex].item.influences.warlord = 1
					influence=%influence%warlord
				if itemsData.result[itemindex].item.influences.crusader = 1
					influence=%influence%crusader
				if itemsData.result[itemindex].item.influences.hunter = 1
					influence=%influence%hunter
				if itemsData.result[itemindex].item.influences.elder = 1
					influence=%influence%elder
				if itemsData.result[itemindex].item.influences.shaper = 1
					influence=%influence%shaper
				if flavour =
					rarity=rare
				else
					rarity=unique
				if rarity=unique
					namelogic=%nametype%
				if rarity=rare
					namelogic=%basetype%
				if (ilvl >= 85) and (rarity="rare")
					newilvl=85
				if (ilvl < 85) and (rarity="rare")
					newilvl=0
				if (ilvl >= 86) and (namelogic="Bone Helmet")
					newilvl=86
				if (ilvl < 86) and (namelogic="Bone Helmet")
					newilvl=0
				if (ilvl >= 82) and (namelogic="Blizzard Crown")
					newilvl=82
				if (ilvl >= 85) and (namelogic="Blizzard Crown")
					newilvl=85
				if rarity=unique
					ilvl=0
				if value=
					break
				lastprice:=value
				if influence=
					influence=`-
				if (currency="divine") and (value>0)
					fileappend, %value%`,`"%enchant%`"`,%newilvl%`,%influence%`,`"%namelogic%`"`,`"%stasheditem%`"`n, temp.txt
			}
		}

		pricedif:=lastprice-minprice
		if pricedif>0
			minprice:=lastprice
		if pricedif=0
			minprice:=lastprice+0.1
		if total < 100
		{
			FileRead, Text, temp.txt
			Sort, Text, U
			filedelete, temp.txt
			FileAppend, %Text%, result.txt
			break outer
		}
	}

	stringreplace,header1,header1,`:,`,,all
	stringreplace,header2,header2,`:,`,,all
	loop, parse, header1, `,
	{
		if a_index=1
			limit1=%A_LoopField%
		if a_index=4
			limit2=%A_LoopField%
		if a_index=7
			limit3=%A_LoopField%
	}
	loop, parse, header2, `,
	{
		if a_index=1
			point1=%A_LoopField%
		if a_index=3
			ban1=%A_LoopField%
		if a_index=4
			point2=%A_LoopField%
		if a_index=6
			ban2=%A_LoopField%
		if a_index=7
			point3=%A_LoopField%
		if a_index=9
			ban3=%A_LoopField%
	}
	reach1:=limit1-point1
	reach2:=limit2-point2
	reach3:=limit3-point3
	ban:=ban1+ban2+ban3
	if reach1<=2
		proxygo=1
	if reach2<=3
		proxygo=1
	if reach3<=5
		proxygo=1
	if ban>0
		proxygo=1

}
filedelete, %FileName_y%
filemove, result.txt, %FileName_y%
goto mark1
