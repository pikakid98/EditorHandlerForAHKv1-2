#Requires AutoHotkey v2.0
#NoTrayIcon

;@Ahk2Exe-Set FileVersion, 2.1
;@Ahk2Exe-Set ProductVersion, 2.1.0.0
;@Ahk2Exe-Set CompanyName, Pikakid98

if not FileExist("Editors.ini") {
    IniWrite "", A_ScriptDir "\Editors.ini", "Editors", "v1"
    IniWrite "", A_ScriptDir "\Editors.ini", "Editors", "v2"
}

if A_Args.Length < 1
{
    MsgBox "Please run this tool via the " '"' "Edit script" '"' " function via an AutoHotkey script"
    ExitApp
}

fileToCheck := A_Args[1]

Loop Files, fileToCheck, "F"
SetWorkingDir A_LoopFileDir

editorv1 := IniRead(A_ScriptDir "\Editors.ini", "Editors", "v1")
editorv2 := IniRead(A_ScriptDir "\Editors.ini", "Editors", "v2")

fallback := "C:\Windows\System32\notepad.exe"

; Read the first line of the file
if (FileExist(fileToCheck)) {
    fileHandle := FileOpen(fileToCheck, "r")
    firstLine := fileHandle.ReadLine()
    fileHandle.Close()

    if InStr(firstLine, "#Requires AutoHotkey v1") {
        if FileExist(editorv1) {
            ; Event 1 - First line contains "#Requires AutoHotkey v1"
            Run editorv1 " " '"' fileToCheck '"'
        } else {
            #Include fallback.scriptlet
        }
    }
    
    if InStr(firstLine, "#Requires AutoHotkey v2") {
        if FileExist(editorv2) {
            ; Event 2 - First line contains "#Requires AutoHotkey v2"
            Run editorv2 " " '"' fileToCheck '"'
        } else {
            #Include fallback.scriptlet
        }
    }
} else {
    MsgBox("The file " . fileToCheck . " does not exist!")
}