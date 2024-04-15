#Requires AutoHotkey v2.0
#NoTrayIcon

;@Ahk2Exe-Set FileVersion, 2.0
;@Ahk2Exe-Set ProductVersion, 2.0.0.0
;@Ahk2Exe-Set CompanyName, Pikakid98

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

; Read the first line of the file
if (FileExist(fileToCheck)) {
    fileHandle := FileOpen(fileToCheck, "r")
    firstLine := fileHandle.ReadLine()
    fileHandle.Close()

    ; Check if the first line contains "#Requires AutoHotkey v1"
    if InStr(firstLine, "#Requires AutoHotkey v1") {
        ; Event 1 - First line contains "#Requires AutoHotkey v1"
        Run editorv1 " " '"' fileToCheck '"'
    }
    
    if InStr(firstLine, "#Requires AutoHotkey v2") {
        ; Event 2 - First line contains "#Requires AutoHotkey v2"
        Run editorv2 " " '"' fileToCheck '"'
    }
}
else {
    MsgBox("The file " . fileToCheck . " does not exist!")
}