#Requires AutoHotkey v2.0
#NoTrayIcon

;@Ahk2Exe-Set FileVersion, 1.0
;@Ahk2Exe-Set ProductVersion, 1.0.0.0
;@Ahk2Exe-Set CompanyName, Pikakid98

if A_Args.Length < 1
{
    MsgBox "Please run this tool via the " '"' "Edit script" '"' " function via an AutoHotkey script"
    ExitApp
}

Loop Files, A_Args[1], "F"
SetWorkingDir A_LoopFileDir

editorv1 := IniRead(A_ScriptDir "\Editors.ini", "Editors", "v1")
editorv2 := IniRead(A_ScriptDir "\Editors.ini", "Editors", "v2")

if FileExist("v1") {
    Run editorv1 " " '"' A_Args[1] '"'
}

if not FileExist("v1") {
    Run editorv2 " " '"' A_Args[1] '"'
}