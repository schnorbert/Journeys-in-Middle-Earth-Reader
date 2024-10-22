#Requires AutoHotkey v2
#include .\Lib\OCR.ahk
InstallKeybdHook 1, 1
#UseHook 1

CoordMode "Mouse", "Screen"
CoordMode "ToolTip", "Screen"

DllCall("SetThreadDpiAwarenessContext", "ptr", -3) ; Needed for multi-monitor setups with differing DPIs
OCR.PerformanceMode := 1 ; Uncommenting this makes the OCR more performant, but also more CPU-heavy

global w := 1200, h := 400, minsize := 5, step := 21, toRun := 0, prevWin := 0, toSay := 0, hbuffer := 0
Loop {
	if toRun == 0
	{
		KeyWait "XButton2" , "D"
		toRun := 1
	}
	else if toRun == 1
	{
		Right::global w+=step
		Left::global w-=(w < minsize ? 0 : step)
		Up::global h+=step
		Down::global h-=(h < minsize ? 0 : step)
		
		if (hbuffer > 0)
		{
			hbuffer := hbuffer - 1
		}
		else
		{
			MouseGetPos(&x, &y)
		}
		
		Highlight(x-w//2, y-h//2, w, h)
		;ToolTip(OCR.FromRect(x-w//2, y-h//2, w, h,,2).Text, , y+h//2+10)
		
		if !GetKeyState("XButton2", "P")
		{
			toSay := OCR.FromRect(x-w//2, y-h//2, w, h,,2).Text
			Highlight(-1, -1, 0, 0)
			
			FileDelete "C:\OCR\*.txt"
			FileAppend toSay, "C:\OCR\page.txt"
			
			prevWin := WinGetID("A")
			
			WinActivate "Edge"
			
			toRun := 2
		}
		Sleep 50
	}
	else if toRun == 2
	{
		if WinActive("Edge")
		{
			Send "{F5}"
			Sleep 100
			Send "^+U"
			Sleep 1100
			
			WinActivate prevWin
			
			hbuffer := 14
			toRun := 0
		}
	}
}

Highlight(x?, y?, w?, h?, showTime:=0, color:="Red", d:=2) {
	static guis := []

	if !IsSet(x) {
        for _, r in guis
            r.Destroy()
        guis := []
		return
    }
    if !guis.Length || toRun == 0 {
        Loop 4
            guis.Push(Gui("+AlwaysOnTop -Caption +ToolWindow -DPIScale +E0x08000000"))
    }
	Loop 4 {
		i:=A_Index
		, x1:=(i=2 ? x+w : x-d)
		, y1:=(i=3 ? y+h : y-d)
		, w1:=(i=1 or i=3 ? w+2*d : d)
		, h1:=(i=2 or i=4 ? h+2*d : d)
		guis[i].BackColor := color
		guis[i].Show("NA x" . x1 . " y" . y1 . " w" . w1 . " h" . h1)
	}
	if showTime > 0 {
		Sleep(showTime)
		Highlight()
	} else if showTime < 0
		SetTimer(Highlight, -Abs(showTime))
}

f9::
{
exitapp
}