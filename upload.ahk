ifexist, upload.ico
	menu, tray, icon, upload.ico
loop
{
run nircmd.exe exec hide combine.bat
DetectHiddenWindows, On
SetTitleMatchMode, 2

IfWinNotExist, ninja.ahk
	run C:\poe\ninja\ninja.ahk
IfWinNotExist, itemnew.ahk
	run C:\poe\scriptnew\itemnew.ahk
IfWinNotExist, mods.ahk
	run C:\poe\mods.ahk
IfWinNotExist, meta.ahk
	run C:\poe\youtube\meta.ahk
IfWinNotExist, lab.ahk
    run C:\poe\lab\lab.ahk
IfWinNotExist, pricing.ahk
    run C:\poe\harvest\pricing.ahk
sleep, 60000
}