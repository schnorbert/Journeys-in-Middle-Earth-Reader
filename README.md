# GameVoiceReader
Reads texts on the screen out loud, works with games - OCR Script for AutoHotkey

This is a proof-of-concept autohotkey script - Feel free to improve and modify it!

_**Installation instructions:**_

1- Install Autohotkey: https://www.autohotkey.com/

2- Place the "OCR" folder in your root C: drive. Path should look like this: C:\OCR

3- Double-click the "Game Voice Reader" file to run it. Running the script as administrator improves its compatibility in some games.

4- Don't close the Edge window that opens and don't switch tabs on that window while the script is active.
You can move the Edge window to a second monitor or make its window really small to keep it out of the way.

5- Done!

_**Usage instructions:**_

1- The game must be running in either borderless full-screen or window mode, not exclusive full-screen

2- Hold down your "mouse side button 2" (The one that goes "forwards") and drag the red box on the text to be read

3- After it has read the text you can open Edge and click on the button "Voice Options" on the top-right to choose a better voice, the ones with "Online" in the name run on the cloud and are AI-based and generally better

4- Press left click while the red box is visible to save that selected area, mousing over that saved area will automatically select it for quick re-reading of the same area, left click on a saved area to unsave it.

5- Press right click while the red box is visible to cancel scan. 

6- If you have highlighted text, then clicking "mouse side button 2" will read that text.

7- Press F9 while holding the "mouse side button 2" to stop the script

_**Known issues:**_

-Folder the script works on is hard-coded, ideally it should work wherever

-The script will delete any and all .txt files inside the OCR folder