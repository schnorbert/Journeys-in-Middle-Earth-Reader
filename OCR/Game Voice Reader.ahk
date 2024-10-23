#Requires AutoHotkey v2
#include .\Lib\OCR.ahk
InstallKeybdHook 1, 1
#UseHook 1

CoordMode "Mouse", "Screen"
CoordMode "ToolTip", "Screen"

DllCall("SetThreadDpiAwarenessContext", "ptr", -3) ; Needed for multi-monitor setups with differing DPIs
OCR.PerformanceMode := 1 ; Uncommenting this makes the OCR more performant, but also more CPU-heavy

if !WinExist('page.txt -')
{
	Run 'msedge.exe'
	Sleep 800
	Send 'file:///C:/OCR/page.txt'
	Send '{Enter}'
}

;#SuspendExempt
f9::exitapp
;#SuspendExempt False

global w := 1200, h := 400, minsize := 5, step := 21, toRun := 0, prevWin := 0, toSay := 0, hbuffer := 0, bX := 0, bY := 0, bW := 0, bH := 0
Loop {
	if toRun == 0
	{
		Suspend 1
		KeyWait "XButton2" , "D"
		toRun := 1
	}
	else if toRun == 1
	{
		Suspend 0
		Right::global w+=step
		Left::global w-=(w < minsize ? 0 : step)
		Up::global h+=step
		Down::global h-=(h < minsize ? 0 : step)
		
		;if (hbuffer > 0)
		;{
		;	hbuffer := hbuffer - 1
		;}
		;else
		;{
			MouseGetPos(&x, &y)
		;}
		
		inArea := 0
		
		if (bH != 0)
		{
			if (Abs(x-bX) < bW//2) && (Abs(y-bY) < bH//2)
			{
				inArea := 1
				
				x := bX
				y := bY
				h := bH
				w := bW
				Highlight(bX-bW//2, bY-bH//2, bW, bH, "Red")
			}
			else
			{
				Highlight(bX-bW//2, bY-bH//2, bW, bH, "Blue")
			
				Highlight(x-w//2, y-h//2, w, h, "Red")
			}
		}
		else
		{
			Highlight(x-w//2, y-h//2, w, h, "Red")
		}
		
		if GetKeyState("LButton", "P")
		{
			if (!inArea)
			{
				bX := x
				bY := y
				bH := h
				bW := w
			}
			else
			{
				bX := 0
				bY := 0
				bH := 0
				bW := 0
			}
		}
		
		if !GetKeyState("XButton2", "P") || GetKeyState("LButton", "P")
		{
			toSay := OCR.FromRect(x-w//2, y-h//2, w, h,,2).Text
			Highlight(-1, -1, 0, 0, "Red")
			
			FileDelete "C:\OCR\*.txt"
			FileAppend toSay, "C:\OCR\page.txt"
			
			prevWin := WinGetID("A")
			
			WinActivate "page.txt -"
			
			Suspend 1
			toRun := 2
		}
		else if GetKeyState("RButton")
		{
			toRun := 0
			Highlight(-1, -1, 0, 0, "Red")
			Sleep 1200
		}
		
		Sleep 25
	}
	else if toRun == 2
	{
		if WinActive("page.txt -")
		{
			Send "{F5}"
			Sleep 100
			Send "^+U"
			Sleep 1100
			
			WinActivate prevWin
			
			;hbuffer := 7
			toRun := 0
			Sleep 200
		}
	}
}

Highlight(x?, y?, w?, h?, color?, showTime:=0, d:=2) {
	static guis := []

	if IsSet(color) && (color == "Res")
	{
		showTime := 500
	}
	else if !IsSet(x) {
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