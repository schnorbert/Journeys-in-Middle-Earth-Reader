# GameVoiceReader
Reads texts on the screen out loud, works with games - OCR Script for AutoHotkey

This is a proof-of-concept autohotkey script - Feel free to improve and modify it!

_**Installation instructions:**_

1- Install Autohotkey: https://www.autohotkey.com/

2- Place the "OCR" folder in your root C: drive. Path should look like this: C:\OCR

3- Open the Edge browser

4- Drag "page.txt" from inside the OCR folder into Edge, it will open it in a new tab, don't change tabs

5- You can now move Edge to a second monitor or make its window really small to keep it out of the way

6- Done! Double-click the "Game Voice Reader" file to run it. Running the script as administrator improves its compatibility in some games.

_**Usage instructions:**_

1- The game must be running in either borderless full-screen or window mode, not exclusive full-screen

2- Hold down your "mouse side button 2" (The one that goes "forwards")

3- A red box will appear, you can change its size with arrow keys

4- Release the mouse side button and after about 1 second it will read the text it detects in the box (Click the side button instead of holding to read the same area previously selected.)

5- After it read the text you can open Edge and click on the button "Voice Options" on the top-right to chose a better voice, the ones with "Online" in the name run on the cloud and are AI-based and generally better

6- Press right click while the red box is visible to cancel scan. Press left click while box is visible to save that selected area, mousing over that area will automatically select it, click a saved area to unsave it.

7- Press F9 to stop the script

_**Known issues:**_

-Folder the script work on is hard-coded, should work wherever

-The script will delete any and all .txt files inside the OCR folder

-Arrow keys don't work while script is running
