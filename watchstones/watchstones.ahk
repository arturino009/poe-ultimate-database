counter:=0
Loop, Read, watchstones.txt
{
   total_lines = %A_Index%
}
loop, %total_lines%
{
FileReadLine, line, watchstones.txt, %a_index%
	loop, parse, line, %a_tab%
	{
	if a_index=1
		wstype=%A_LoopField%
	if a_index=2
		explicit=%A_LoopField%
	if a_index=3
		statmin=%A_LoopField%
	if a_index=4
		statmax=%A_LoopField%
	if a_index=5
		mechanics=%A_LoopField%
	if a_index=6
		desc=%A_LoopField%
	if a_index=7
		tier=%A_LoopField%
	if a_index=8
		modname=%A_LoopField%
	if a_index=9
		odds=%A_LoopField%
	}
if mechanics = All
	Array := ["Tirn's End","Lex Proxima","Valdo's Rest","Glennach Cairns","Haewark Hamlet","Lex Ejoris","Lira Arthain","New Vastir"]
if mechanics = Incursion
	Array := ["Glennach Cairns","Lex Ejoris"]
if mechanics = Syndicate
	Array := ["Valdo's Rest","Haewark Hamlet"]
if mechanics = Bestiary
	Array := ["Tirn's End","Lira Arthain"]
if mechanics = Essence
	Array := ["Haewark Hamlet"]
if mechanics = Beyond
	Array := ["Glennach Cairns","Haewark Hamlet"]
if mechanics = Legion
	Array := ["Glennach Cairns","New Vastir"]
if mechanics = Breach
	Array := ["Lex Proxima","Lira Arthain"]
if mechanics = Harbinger
	Array := ["Valdo's Rest"]
if mechanics = Metamorph
	Array := ["Valdo's Rest","Lex Ejoris"]
if mechanics = Harvest
	Array := ["Lex Proxima","Haewark Hamlet"]
if mechanics = Heist
	Array := ["Lira Arthain"]
if mechanics = Blight
	Array := ["Valdo's Rest","Lira Arthain"]
if mechanics = Ritual
	Array := ["Haewark Hamlet"]
for index, region in Array
{
	counter:=counter+1
	counter:=SubStr("0000" . counter,-3)
	query=
	(
	"type":"%wstype% %region% Watchstone","stats":[{"type":"and","filters":[{"id":"%explicit%","value":{"min":%statmin%, "max":%statmax%}}]}],"filters":{"type_filters":{"filters":{"rarity":{"option":"nonunique"}}}}
	)
	fileappend, ws%counter%%a_tab%%query%`n, watchstones query list.txt
	fileappend, ws%counter%%a_tab%%region%%a_tab%%tier% %modname%%a_tab%%odds%%a_tab%%desc%`n, watchstones spreadsheet list.txt
}
}