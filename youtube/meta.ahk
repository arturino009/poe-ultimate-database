SetWorkingDir, %A_ScriptDir%
ifexist, youtube.ico
	menu, tray, icon, youtube.ico
#include C:\poe\info.ini
#include json.ahk
FileEncoding,UTF-8
FileName_y = %filepath%youtube.txt
apikey=AIzaSyBG6nWc-6f9HJkC9O9ez0vIk5kZM-1Unv4
mark2:
filedelete, videolist.txt
filedelete, views.txt
filedelete, result.txt
filedelete, content creators.txt
urldownloadtofile,https://pastebin.com/raw/w0J4CLGD,content creators.txt
filedelete, keywords.txt
urldownloadtofile,https://pastebin.com/raw/5pCEyWVk,keywords.txt

Loop, Read, content creators.txt
{
	total_csv = %A_Index%
}
Loop, Read, keywords.txt
{
	total_key = %A_Index%
}

loop, %total_csv%
{
	FileReadLine, line, content creators.txt, %a_index%
	loop, parse, line, `,
	{
		if a_index=1
			creator=%A_LoopField%
		if a_index=2
			channel=%A_LoopField%
	}
	mark1:
	videos=
	url=
	(
	https://www.googleapis.com/youtube/v3/playlistItems?playlistId=%channel%&part=snippet,id&key=%apikey%&maxResults=50
	)
	HTTP := ComObjCreate("WinHTTP.WinHttpRequest.5.1")
	HTTP.Open("GET", URL, 0)
	HTTP.SetRequestHeader("Content-Type", "application/json")
	HTTP.SetRequestHeader("User-Agent", "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0)")
	HTTP.Send()
	HTTP.WaitForResponse()
	videos := HTTP.ResponseText
	sleep, 1000
	if videos=
		goto mark1
	
	notobj := JSON.load(videos)
	loop, 50
	{
		hren:=a_index
		videoid:=notobj.items[hren].snippet.resourceId.videoId
		publishdate:=notobj.items[hren].snippet.publishedAt
		stringreplace,publishdate,publishdate,T,%a_space%
		stringreplace,publishdate,publishdate,Z,
		title:=notobj.items[hren].snippet.title
		;clipboard:=title
		;msgbox %title%
		stringreplace,title,title,`&`#39`;,`',all
		stringreplace,title,title,`,,`.,all
		stringreplace,title,title,`&amp`;,`and,all
		stringreplace,title,title,`&quot`;,`',all
		stringreplace,title,title,`",`',all
		stringreplace,title,title,`n,`',all
		stringreplace,title,title,`r,`',all
		build=
		loop, %total_key%
		{
			FileReadLine, keyword, keywords.txt, %a_index%
			if instr(title,keyword,false)
				build=%keyword%
		}
		if videoid<>
			fileappend `"%publishdate%`"`,`"%creator%`"`,`"%videoid%`"`,`"%title%`"`,`"%build%`"`n, videolist.txt, UTF-16
	}
}
FileRead, Text, videolist.txt
Sort, Text, R
filedelete, videolist.txt
FileAppend, %Text%, videolist.txt, UTF-16

videoidscur=
loop, 2000
{
	outerindex=%a_index%
	FileReadLine, anotherline, videolist.txt, %outerindex%
	loop, parse, anotherline, `,
	{
		if a_index=3
		{
			if videoidscur<>
				videoidscur=%videoidscur%`,
			videoidscur=%videoidscur%%A_LoopField%
		}
	}
	if mod(outerindex,50)=0
	{
		stringreplace,videoidscur,videoidscur,`",,all
		anourl=
		(
		https://www.googleapis.com/youtube/v3/videos?id=%videoidscur%&key=%apikey%&part=snippet,contentDetails,statistics,status
		)
		videoidscur=
		HTTP2 := ComObjCreate("WinHTTP.WinHttpRequest.5.1")
		HTTP2.Open("GET", anourl, 0)
		HTTP2.SetRequestHeader("Content-Type", "application/json")
		HTTP2.SetRequestHeader("User-Agent", "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0)")
		HTTP2.Send()
		HTTP2.WaitForResponse()
		morevideos := HTTP2.ResponseText
		obj := JSON.load(morevideos)
		loop, 50
		{
			hrenn:=a_index
			videoid:=obj.items[hrenn].id
			views:=obj.items[hrenn].statistics.viewCount
			if videoid<>
				fileappend %videoid%%a_tab%%views%`n, views.txt, UTF-16
		}
	}
}
FormatTime, curtime,,MMMM d HH:mm
fileappend %curtime%`,content creator`,id`,title`,build`,view count`n, result.txt, UTF-8
Loop, Read, videolist.txt
{
	strong=%a_loopreadline%
		
	loop, parse, a_loopreadline, `,
	{
		if a_index=3
		{
			videoid=%a_loopfield%
			stringreplace,videoid,videoid,`",,all
			Loop, Read, views.txt
			{
				if instr(a_loopreadline,videoid)
					loop, parse, a_loopreadline, %a_tab%
					{
						vc:=0
						vc:=a_loopfield
						if a_index=2
							if vc>=500
								fileappend %strong%`,`"%a_loopfield%`"`n, result.txt, UTF-8
					}
			}
		}
	}
}
filedelete, %FileName_y%
filemove, result.txt, %FileName_y%
sleep, 10000000
goto mark2