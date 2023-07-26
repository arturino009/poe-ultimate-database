SetWorkingDir, %A_ScriptDir%
ifexist, mod.ico
	menu, tray, icon, mod.ico
#include info.ini
#include C:\poe\ninja\json.ahk
URL = https://www.pathofexile.com/api/trade/search/%League%
URL2 = https://www.pathofexile.com/trade/search/%League%

mark1:
filedelete, %filepath%mods.txt
fileappend, category`,name`,line1`,line2`,line3`,line4`,line5`,line6`n, %filepath%mods.txt
loop,4
{
	bigindx:=a_index
	Array := ["armour.chest","armour.helmet","armour.gloves","armour.boots"]
	category := Array[A_index]
	minprice:=0

	
	
	outer:
	loop
	{
	
	
		zquery1=
		(
		"stats":[{"type":"and","filters":[{"id":"pseudo.pseudo_has_influence_count","value":{"min":2,"max":2}}]},{"filters":[{"id":"explicit.stat_1325783255"},{"id":"explicit.stat_3679418014"},{"id":"explicit.stat_2734809852"},{"id":"explicit.stat_2748665614","value":{"min":16,"max":18}},{"id":"explicit.stat_458438597","value":{"min":11,"max":15}},{"id":"explicit.stat_630994130"},{"id":"explicit.stat_2698606393"},{"id":"explicit.stat_1719423857"},{"id":"explicit.stat_3587013273","value":{"min":20,"max":20}},{"id":"explicit.stat_791835907","value":{"min":1.6,"max":2}},{"id":"explicit.stat_1328548975"},{"id":"explicit.stat_1742651309"},{"id":"explicit.stat_3853018505"},{"id":"explicit.stat_983749596","value":{"min":13,"max":15}},{"id":"explicit.stat_3353368340"},{"id":"explicit.stat_916797432"},{"id":"explicit.stat_2718698372"},{"id":"explicit.stat_836936635","value":{"min":2.1,"max":3}},{"id":"explicit.stat_2572042788","value":{"min":1.6,"max":2}},{"id":"explicit.stat_2970621759"},{"id":"explicit.stat_4113372195"},{"id":"explicit.stat_3295179224","value":{"min":31,"max":35}},{"id":"explicit.stat_2034658008"},{"id":"explicit.stat_2698606393"},{"id":"explicit.stat_1330109706"},{"id":"explicit.stat_1436284579"},{"id":"explicit.stat_1541516339"},{"id":"explicit.stat_2222186378"},{"id":"explicit.stat_1880071428","value":{"min":26,"max":30}},{"id":"explicit.stat_1301765461"},{"id":"explicit.stat_3292930705"},{"id":"explicit.stat_1242155304","value":{"min":25,"max":25}},{"id":"explicit.stat_3191479793","value":{"min":26,"max":35}},{"id":"explicit.stat_1978899297"},{"id":"explicit.stat_2448279015"},{"id":"explicit.stat_2592686757"},{"id":"explicit.stat_2264586521","value":{"min":-20,"max":-20}}],"type":"count","value":{"min":2,"max":2}}],"filters":{"misc_filters":{"filters":{"mirrored":{"option":"false"},"corrupted":{"option":"false"}}},"type_filters":{"filters":{"rarity":{"option":"nonunique"},"category":{"option":"armour.chest"}}},"trade_filters":{"filters":{"price":{"option":"divine","min":%minprice%}}}},"status":{"option":"any"}
		)
		zquery2=
		(
		"stats":[{"type":"and","filters":[{"id":"pseudo.pseudo_has_influence_count","value":{"min":2,"max":2}}]},{"type":"count","filters":[{"id":"explicit.stat_3720936304","value":{"min":25,"max":25}},{"id":"explicit.stat_2388360415","value":{"min":25,"max":25}},{"id":"explicit.stat_3814066599","value":{"min":25,"max":25}},{"id":"explicit.stat_1710508327","value":{"min":25,"max":25}},{"id":"explicit.stat_1106668565","value":{"min":25,"max":25}},{"id":"explicit.stat_13669281","value":{"min":25,"max":25}},{"id":"explicit.stat_808939569","value":{"min":25,"max":25}},{"id":"explicit.stat_1337327984","value":{"min":25,"max":25}},{"id":"explicit.stat_2487643588","value":{"min":25,"max":25}},{"id":"explicit.stat_2680613507","value":{"min":25,"max":25}},{"id":"explicit.stat_3872306017"},{"id":"explicit.stat_2469416729","value":{"min":39}},{"id":"explicit.stat_1133016593","value":{"min":47.5}},{"id":"explicit.stat_2831165374","value":{"min":51}},{"id":"explicit.stat_2435536961","value":{"min":47.5}},{"id":"explicit.stat_2300399854","value":{"min":39}},{"id":"explicit.stat_1193925814"},{"id":"explicit.stat_135378852","value":{"min":4,"max":4}},{"id":"explicit.stat_639595152","value":{"min":9,"max":9}},{"id":"explicit.stat_2571899044"},{"id":"explicit.stat_2388574377"},{"id":"explicit.stat_2867348718","value":{"min":4,"max":4}},{"id":"explicit.stat_415837237","value":{"min":12,"max":12}},{"id":"explicit.stat_1011760251","value":{"min":3,"max":3}},{"id":"explicit.stat_2748665614","value":{"min":16,"max":18}},{"id":"explicit.stat_425242359","value":{"min":11,"max":13}},{"id":"explicit.stat_153004860"},{"id":"explicit.stat_1849749435","value":{"min":-12,"max":-12}},{"id":"explicit.stat_430821956"},{"id":"explicit.stat_3616645755"},{"id":"explicit.stat_1434381067"},{"id":"explicit.stat_1871056256","value":{"min":11,"max":13}},{"id":"explicit.stat_2897207025"},{"id":"explicit.stat_2674336304","value":{"min":-12,"max":-12}},{"id":"explicit.stat_2264523604","value":{"min":-7,"max":-6}},{"id":"explicit.stat_2443492284"},{"id":"explicit.stat_1302208736"},{"id":"explicit.stat_451866048"},{"id":"explicit.stat_1902595112","value":{"min":-12,"max":-12}},{"id":"explicit.stat_656461285","value":{"min":11,"max":12}},{"id":"explicit.stat_1086147743","value":{"min":20,"max":30}},{"id":"explicit.stat_3485067555","value":{"min":20,"max":30}},{"id":"explicit.stat_3668351662","value":{"min":20,"max":30}},{"id":"explicit.stat_1232004574"},{"id":"explicit.stat_3342989455","value":{"min":11,"max":13}},{"id":"explicit.stat_697807915"},{"id":"explicit.stat_3037553757"},{"id":"explicit.stat_836936635","value":{"min":1.6,"max":2}},{"id":"explicit.stat_3914021960","value":{"min":-12,"max":-12}},{"id":"explicit.stat_3556824919","value":{"min":21,"max":24}},{"id":"explicit.stat_3308030688","value":{"min":20,"max":20}},{"id":"explicit.stat_2511370818"},{"id":"explicit.stat_2479683456"}],"value":{"min":2,"max":2}}],"filters":{"misc_filters":{"filters":{"corrupted":{"option":"false"},"mirrored":{"option":"false"}}},"type_filters":{"filters":{"rarity":{"option":"nonunique"},"category":{"option":"armour.helmet"}}},"trade_filters":{"filters":{"price":{"option":"divine","min":%minprice%}}}},"status":{"option":"any"}
		)
		zquery3=
		(
		"stats":[{"type":"and","filters":[{"id":"pseudo.pseudo_has_influence_count","value":{"min":2,"max":2}}]},{"type":"count","filters":[{"id":"explicit.stat_2608615082","value":{"min":20,"max":20}},{"id":"explicit.stat_1390285657","value":{"min":25,"max":25}},{"id":"explicit.stat_2169938251","value":{"min":25,"max":25}},{"id":"explicit.stat_1122134690","value":{"min":25,"max":25}},{"id":"explicit.stat_3839163699","value":{"min":25,"max":25}},{"id":"explicit.stat_3814066599","value":{"min":25,"max":25}},{"id":"explicit.stat_2223640518","value":{"min":25,"max":25}},{"id":"explicit.stat_2228279620","value":{"min":25,"max":25}},{"id":"explicit.stat_4197676934","value":{"min":25,"max":25}},{"id":"explicit.stat_1567462963","value":{"min":25,"max":25}},{"id":"explicit.stat_1916706958"},{"id":"explicit.stat_2828710986","value":{"min":90,"max":90}},{"id":"explicit.stat_3382807662","value":{"min":21}},{"id":"explicit.stat_1950806024","value":{"min":21}},{"id":"explicit.stat_4055307827","value":{"min":21}},{"id":"explicit.stat_1314617696","value":{"min":21}},{"id":"explicit.stat_3338298622"},{"id":"explicit.stat_3023957681"},{"id":"explicit.stat_2264295449","value":{"min":3,"max":4}},{"id":"explicit.stat_4124805414"},{"id":"explicit.stat_356456977","value":{"min":90,"max":90}},{"id":"explicit.stat_3676141501","value":{"min":3,"max":3}},{"id":"explicit.stat_369494213"},{"id":"explicit.stat_979246511"},{"id":"explicit.stat_219391121"},{"id":"explicit.stat_4118987751","value":{"min":20,"max":20}},{"id":"explicit.stat_2013799819","value":{"min":30,"max":30}},{"id":"explicit.stat_587431675","value":{"min":31,"max":60}},{"id":"explicit.stat_2723101291","value":{"min":11}},{"id":"explicit.stat_3144358296","value":{"min":31}},{"id":"explicit.stat_3370223014","value":{"min":31}},{"id":"explicit.stat_935623115","value":{"min":31}},{"id":"explicit.stat_1589917703","value":{"min":31,"max":45}},{"id":"explicit.stat_624954515","value":{"min":21,"max":30}},{"id":"explicit.stat_3503466234"},{"id":"explicit.stat_223937937"},{"id":"explicit.stat_78985352","value":{"min":100,"max":100}},{"id":"explicit.stat_763611529","value":{"min":100,"max":100}},{"id":"explicit.stat_1661253443","value":{"min":2,"max":2}},{"id":"explicit.stat_1455766505"},{"id":"explicit.stat_782230869"},{"id":"explicit.stat_4139681126","value":{"min":11,"max":12}},{"id":"explicit.stat_779663446"},{"id":"explicit.stat_2119664154"},{"id":"explicit.stat_1002362373","value":{"min":31,"max":38}},{"id":"explicit.stat_2162876159","value":{"min":31,"max":38}},{"id":"explicit.stat_2974417149","value":{"min":31,"max":38}},{"id":"explicit.stat_967627487","value":{"min":31,"max":38}},{"id":"explicit.stat_4262448838","value":{"min":36,"max":50}},{"id":"explicit.stat_1785568076"}],"value":{"min":2,"max":2}}],"filters":{"misc_filters":{"filters":{"corrupted":{"option":"false"},"mirrored":{"option":"false"}}},"type_filters":{"filters":{"rarity":{"option":"nonunique"},"category":{"option":"armour.gloves"}}},"trade_filters":{"filters":{"price":{"option":"divine","min":%minprice%}}}},"status":{"option":"any"}
		)
		zquery4=
		(
		"stats":[{"type":"and","filters":[{"id":"pseudo.pseudo_has_influence_count","value":{"min":2,"max":2}}]},{"type":"count","filters":[{"id":"explicit.stat_937372143"},{"id":"explicit.stat_2635869389"},{"id":"explicit.stat_1473289174"},{"id":"explicit.stat_1953432004"},{"id":"explicit.stat_891277550","value":{"min":20,"max":20}},{"id":"explicit.stat_3030692053","value":{"min":25,"max":25}},{"id":"explicit.stat_3566242751","value":{"min":25,"max":25}},{"id":"explicit.stat_107118693","value":{"min":25,"max":25}},{"id":"explicit.stat_407317553","value":{"min":20,"max":20}},{"id":"explicit.stat_2962840349","value":{"min":25,"max":25}},{"id":"explicit.stat_1004011302","value":{"min":16,"max":20}},{"id":"explicit.stat_3005472710","value":{"min":36,"max":50}},{"id":"explicit.stat_3114696875"},{"id":"explicit.stat_1170174456"},{"id":"explicit.stat_4262448838","value":{"min":36,"max":50}},{"id":"explicit.stat_3235814433","value":{"min":2,"max":2}},{"id":"explicit.stat_1065580342"},{"id":"explicit.stat_4095671657","value":{"min":3,"max":3}},{"id":"explicit.stat_219391121","value":{"min":9,"max":11}},{"id":"explicit.stat_979246511","value":{"min":9,"max":11}},{"id":"explicit.stat_369494213","value":{"min":9,"max":11}},{"id":"explicit.stat_1783006896","value":{"min":71,"max":80}},{"id":"explicit.stat_1514829491","value":{"min":71,"max":80}},{"id":"explicit.stat_1871765599","value":{"min":71,"max":80}},{"id":"explicit.stat_1164882313"},{"id":"explicit.stat_240857668"},{"id":"explicit.stat_782230869","value":{"min":41,"max":60}},{"id":"explicit.stat_879520319"},{"id":"explicit.stat_2062835769"},{"id":"explicit.stat_2067062068","value":{"min":3,"max":5}},{"id":"explicit.stat_734614379","value":{"min":11,"max":12}},{"id":"explicit.stat_4053951709","value":{"min":61,"max":70}},{"id":"explicit.stat_2172944497"},{"id":"explicit.stat_1086147743"},{"id":"explicit.stat_1459321413"},{"id":"explicit.stat_2011656677"},{"id":"explicit.stat_3422008440"},{"id":"explicit.stat_2713233613"},{"id":"explicit.stat_836936635","value":{"min":1.6,"max":2}}],"value":{"min":2,"max":2}}],"filters":{"misc_filters":{"filters":{"corrupted":{"option":"false"},"mirrored":{"option":"false"}}},"type_filters":{"filters":{"rarity":{"option":"nonunique"},"category":{"option":"armour.boots"}}},"trade_filters":{"filters":{"price":{"option":"divine","min":%minprice%}}}},"status":{"option":"any"}
		)
				
		zquery := zquery%bigindx%
		HTTP := ComObjCreate("WinHTTP.WinHttpRequest.5.1")
		HTTP.Open("POST", URL, 0)
		HTTP.SetRequestHeader("Content-Type", "application/json")
		HTTP.SetRequestHeader("Cookie", sesid)
		HTTP.SetRequestHeader("User-Agent", "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0)")
		
		data = 
		(
		{"sort": {"price": "asc"},"query":{%zquery%}}
		)
		HTTP.Send(data)
		HTTP.WaitForResponse()
		ids := HTTP.ResponseText
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
			HTTP := ComObjCreate("WinHTTP.WinHttpRequest.5.1")
			HTTP.Open("GET", tenitemsurl%a_index%, 0)
			sleep, 2000
			HTTP.SetRequestHeader("Cookie", sesid)
			HTTP.SetRequestHeader("User-Agent", "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0)")
			HTTP.Send()
			HTTP.WaitForResponse()
			tenitemslist := HTTP.ResponseText
			averageprice=
			value:=0
			itemsData := JSON.load(tenitemslist)
			loop, 10
			{
				explicits=
				itemindex:=a_index
				value := itemsData.result[itemindex].listing.price.amount
				nametype = % itemsData.result[itemindex].item.name a_space itemsData.result[itemindex].item.baseType
				if value<>
					lastprice:=value
				else
					break
				loop, 6
				{
					tier := itemsData.result[itemindex].item.extended.mods.explicit[a_index].tier
					modhash := itemsData.result[itemindex].item.extended.mods.explicit[a_index].magnitudes[1].hash
					if (tier="S0") || (tier="P0")
						explicits=%explicits%%modhash%`,
				}
				fileappend, %category%`,%nametype%`,%explicits%`n, %category%.mods.txt
			}
		}

		pricedif:=lastprice-minprice

		if pricedif>0
			minprice:=lastprice
		if pricedif=0
			minprice:=lastprice+0.1
		if total < 100
		{
			FileRead, Text, %category%.mods.txt
			Sort, Text, U
			filedelete, %category%.mods.txt
			FileAppend, %Text%, %filepath%mods.txt
			break outer
		}
	}
}
sleep 86400000
goto mark1