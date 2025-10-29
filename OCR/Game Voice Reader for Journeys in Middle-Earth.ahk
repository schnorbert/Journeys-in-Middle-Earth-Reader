#Requires AutoHotkey v2
#include .\Lib\OCR.ahk
InstallKeybdHook 1, 1
#UseHook 1

; Use screen coordinates (valid v2 form)
CoordMode "Pixel", "Screen"
CoordMode "Mouse", "Screen"

DllCall("SetThreadDpiAwarenessContext", "ptr", -3) ; multi-monitor DPI safety
OCR.PerformanceMode := 1

InitBrowser() {
    if !WinExist("page.txt -")
    {
        Run "msedge.exe /min"
        Sleep 1000
        Send "file:///" A_ScriptDir "/page.txt"
        Send "{Enter}"
    }
}
InitBrowser()

f9::ExitApp

; Right mouse click triggers OCR
~RButton::
{
    Sleep 1500 ; wait for popup text to appear
    InitBrowser()

    sw := A_ScreenWidth
    sh := A_ScreenHeight

    ; Capture a large middle band of the screen:
    ; - start lower to avoid HUD
    ; - tall enough to include dialog + button
    captureW := Round(sw * 0.70)
    captureH := Round(sh * 0.52)      ; taller band to include button
    captureX := Round((sw - captureW) / 2)
    captureY := Round(sh * 0.14)      ; start below the HUD

    textFound := OCR.FromRect(captureX, captureY, captureW, captureH,,2).Text
    textFound := Trim(textFound)

    if (StrLen(textFound) > 0)
    {
        FileDelete A_ScriptDir "\page.txt"
        FileAppend textFound, A_ScriptDir "\page.txt"

        prevWin := WinGetID("A")

        if WinExist("page.txt -")
        {
            WinActivate "page.txt -"
            Sleep 100
            Send "{F5}"
            Sleep 80
            Send "^+U"
            Sleep 1000
        }

        if WinExist("ahk_id " prevWin)
            WinActivate "ahk_id " prevWin
    }
    return
}
