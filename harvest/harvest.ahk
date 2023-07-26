SetWorkingDir, %A_ScriptDir%
mark404:
#include c:\poe\info.ini
FileName_y = %filepath%harv.txt
filedelete, chat.txt
filedelete, result.txt
filedelete, start.bat
fileappend, value`,currency`,craft`,messsage, c:\poe\harvest\result.txt
thetime := A_Now
EnvAdd, thetime, -24, hour
FormatTime,thetime,%thetime%,yyyy-MM-dd HH:mm:ss

fileappend, 
(
"c:\poe\harvest\discord chat cli\DiscordChatExporter.Cli.exe" export --channel %harvchannel% --token %token% --output "c:\poe\harvest\chat.txt" --format "csv" --dateformat "yyyy-MM-dd HH:mm:ss" --after "%thetime%"
), c:\poe\harvest\start.bat
runwait, c:\poe\harvest\start.bat,,hide

Loop, Read, harvlist.txt
{
   total_lines = %A_Index%
}

FileRead, Contents, c:\poe\harvest\chat.txt
loop, parse, Contents, `n
{
	stringer=%A_LoopField%
	stringreplace,stringer,stringer,`n,,all
	stringreplace,stringer,stringer,`r,,all
	stringreplace,stringer,stringer,`,,`.,all
	stringreplace,stringer,stringer,`-,,all
	stringreplace,stringer,stringer,`(,,all
	stringreplace,stringer,stringer,`),,all
	stringreplace,stringer,stringer,`",,all
	loop,20
	{
		stringreplace,stringer,stringer,%a_space%%a_space%,%a_space%,all
	}
	counter:=0
	loop,50
	{
		numnum:=51-a_index
		ifinstring, stringer, %numnum%`.5ex
		{
			fileappend, `n%numnum%`.5`,exa, c:\poe\harvest\result.txt
			counter:=1
			goto mark1
		}
	}
	loop,50
	{
		numnum:=51-a_index
		ifinstring, stringer, %numnum%`.5 ex
		{
			fileappend, `n%numnum%`.5`,exa, c:\poe\harvest\result.txt
			counter:=1
			goto mark1
		}
	}
	loop,100
	{
		numnum:=101-a_index
		ifinstring, stringer, %numnum%ex
		{
			fileappend, `n%numnum%`,exa, c:\poe\harvest\result.txt
			counter:=1
			goto mark1
		}
	}
	loop,50
	{
		numnum:=51-a_index
		ifinstring, stringer, %numnum% ex
		{
			fileappend, `n%numnum%`,exa, c:\poe\harvest\result.txt
			counter:=1
			goto mark1
		}
	}
	loop,100
	{
		numnum:=101-a_index
		ifinstring, stringer, %numnum%c
		{
			fileappend, `n%numnum%`,chaos, c:\poe\harvest\result.txt
			counter:=1
			goto mark1
		}
	}
	loop,100
	{
		numnum:=101-a_index
		ifinstring, stringer, %numnum% c
		{
			fileappend, `n%numnum%`,chaos, c:\poe\harvest\result.txt
			counter:=1
			goto mark1
		}
	}
	mark1:
	if counter=0
		goto mark3
	fileappend, `,, c:\poe\harvest\result.txt
;	ifinstring, stringer, Lucky
;		fileappend, Lucky%a_space%, c:\poe\harvest\result.txt
	ifinstring, stringer, Common
		fileappend, Common%a_space%, c:\poe\harvest\result.txt
	ifinstring, stringer, Less Likely
		fileappend, LessLikely%a_space%, c:\poe\harvest\result.txt
	ifinstring, stringer, More Likely
		fileappend, MoreLikely%a_space%, c:\poe\harvest\result.txt
	ifinstring, stringer, Synt
		fileappend, Synthesise%a_space%, c:\poe\harvest\result.txt
	ifinstring, stringer, Fract
		fileappend, Fracture%a_space%, c:\poe\harvest\result.txt
	ifinstring, stringer, Upgrade
		fileappend, Upgrade%a_space%, c:\poe\harvest\result.txt
	ifinstring, stringer, Regal
		fileappend, Upgrade%a_space%, c:\poe\harvest\result.txt
	ifinstring, stringer, Aug
		fileappend, Augment%a_space%, c:\poe\harvest\result.txt
	ifinstring, stringer, Refor
		fileappend, Reforge%a_space%, c:\poe\harvest\result.txt
	ifinstring, stringer, Rem
		fileappend, Remove%a_space%, c:\poe\harvest\result.txt
	ifinstring, stringer, Add
		fileappend, Add%a_space%, c:\poe\harvest\result.txt
	ifinstring, stringer, Reroll
		fileappend, Reroll%a_space%, c:\poe\harvest\result.txt
	ifinstring, stringer, Divine
		fileappend, Reroll%a_space%, c:\poe\harvest\result.txt
	ifinstring, stringer, Keep
		fileappend, Keep%a_space%, c:\poe\harvest\result.txt
	ifinstring, stringer, Ench
		fileappend, Enchant%a_space%, c:\poe\harvest\result.txt
	ifinstring, stringer, Randomi
		fileappend, Randomise%a_space%, c:\poe\harvest\result.txt
	ifinstring, stringer, Sac
		fileappend, Sacrifice%a_space%, c:\poe\harvest\result.txt
	ifinstring, stringer, Implicit
		fileappend, Implicit%a_space%, c:\poe\harvest\result.txt
	ifinstring, stringer, Infl
		ifnotinstring, stringer, non-Infl
		ifnotinstring, stringer, nonInfl
		ifnotinstring, stringer, non Infl
			fileappend, Influence%a_space%, c:\poe\harvest\result.txt
	ifinstring, stringer, Add Infl
		if InStr(stringer, "non-Infl") || InStr(stringer, "nonInfl") || InStr(stringer, "non Infl")
			fileappend, non-Influence%a_space%, c:\poe\harvest\result.txt
	ifinstring, stringer, Armour
		fileappend, Armour%a_space%, c:\poe\harvest\result.txt
	ifinstring, stringer, Armor
		fileappend, Armour%a_space%, c:\poe\harvest\result.txt
	ifinstring, stringer, Body
		ifnotinstring, stringer, Armour
		ifnotinstring, stringer, Armor
			fileappend, Armour%a_space%, c:\poe\harvest\result.txt
	ifinstring, stringer, Weapon
		fileappend, Weapon%a_space%, c:\poe\harvest\result.txt
	ifinstring, stringer, Jewellery
		fileappend, Jewellery%a_space%, c:\poe\harvest\result.txt
	loop, %total_lines%
	{
		fileline:=a_index
		FileReadLine, searchname, c:\poe\harvest\harvlist.txt, %fileline%
		loop, parse, searchname, %a_tab%
		{
			if a_index=1
				searchtext=%a_loopfield%
			if a_index=2
				craft=%a_loopfield%
		}
		ifinstring, stringer, %searchtext%
		{
			fileappend, %craft%, c:\poe\harvest\result.txt
			goto mark2
		}
	}
	mark2:
	fileappend, `,`"%stringer%`", c:\poe\harvest\result.txt
	mark3:
}

FileRead, OutputVar, result.txt
FileDelete, result.txt
Sort, OutputVar
FileAppend, %OutputVar%, result2.txt
Loop, Read, result2.txt, 
{ 
	If Var <> %A_LoopReadLine%
		FileAppend, %A_LoopReadLine%`n, result.txt
	Var = 	%A_LoopReadLine%
}
FileDelete, result2.txt

filedelete, %FileName_y%
filemove, result.txt, %FileName_y%
sleep, 10000000
goto mark404