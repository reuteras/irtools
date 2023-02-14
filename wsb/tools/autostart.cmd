set SETUP_PATH=C:\users\WDAGUtilityAccount\Documents\tools\downloads
set TEMP=C:\temp
set TOOLS=C:\Tools

mkdir C:\git
mkdir C:\temp
mkdir C:\temp\yararules
mkdir C:\Tools
mkdir C:\Tools\bin
mkdir C:\Tools\DidierStevens
mkdir C:\Tools\Zimmerman
mkdir C:\Users\WDAGUtilityAccount\Documents\WindowsPowerShell

copy /B /Y /V %SETUP_PATH%\* %TEMP%\
copy /B %SETUP_PATH%\jq.exe C:\Tools\bin\
xcopy /S /E %SETUP_PATH%\DidierStevens C:\Tools\DidierStevens
xcopy /S /E %SETUP_PATH%\git C:\git
xcopy /S /E "%SETUP_PATH%\git\signature-base\yara" C:\temp\yararules
xcopy /S /E %SETUP_PATH%\Zimmerman C:\Tools\Zimmerman
cp "C:\Users\WDAGUtilityAccount\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Windows PowerShell\Windows PowerShell.lnk" "C:\Users\WDAGUtilityAccount\Desktop\PowerShell.lnk"

msiexec /i "%TEMP%\7zip.msi" /qn /norestart
msiexec /i "%TEMP%\corretto.msi" /qn /norestart

"%PROGRAMFILES%\7-Zip\7z.exe" x -aoa "%TEMP%\capa-windows.zip" -o"%TOOLS%\capa"
"%PROGRAMFILES%\7-Zip\7z.exe" x -aoa "%TEMP%\chainsaw.zip" -o"%TOOLS%"
"%PROGRAMFILES%\7-Zip\7z.exe" x -aoa "%TEMP%\CyberChef.zip" -o"%TOOLS%\CyberChef"
"%PROGRAMFILES%\7-Zip\7z.exe" x -aoa "%TEMP%\dnSpy.zip" -o"%TOOLS%\dnSpy"
"%PROGRAMFILES%\7-Zip\7z.exe" x -aoa "%TEMP%\exiftool.zip" -o"%TOOLS%\exiftool"
"%PROGRAMFILES%\7-Zip\7z.exe" x -aoa "%TEMP%\floss.zip" -o"%TOOLS%\floss"
"%PROGRAMFILES%\7-Zip\7z.exe" x -aoa "%TEMP%\ghidra.zip" -o"%TOOLS%"
"%PROGRAMFILES%\7-Zip\7z.exe" x -aoa "%TEMP%\GoReSym.zip" -o"%TOOLS%\GoReSym"
"%PROGRAMFILES%\7-Zip\7z.exe" x -aoa "%TEMP%\hxd.zip" -o"%TOOLS%\hxd"
"%PROGRAMFILES%\7-Zip\7z.exe" x -aoa "%TEMP%\loki.zip" -o"%TOOLS%"
"%PROGRAMFILES%\7-Zip\7z.exe" x -aoa "%TEMP%\malcat.zip" -o"%TOOLS%\malcat"
"%PROGRAMFILES%\7-Zip\7z.exe" x -aoa "%TEMP%\pebear.zip" -o"%TOOLS%\pebear"
"%PROGRAMFILES%\7-Zip\7z.exe" x -aoa "%TEMP%\pestudio.zip" -o"%TOOLS%\pestudio"
"%PROGRAMFILES%\7-Zip\7z.exe" x -aoa "%TEMP%\qpdf.zip" -o"%TOOLS%"
"%PROGRAMFILES%\7-Zip\7z.exe" x -aoa "%TEMP%\ripgrep.zip" -o"%TOOLS%"
"%PROGRAMFILES%\7-Zip\7z.exe" x -aoa "%TEMP%\sqlite.zip" -o"%TOOLS%"
"%PROGRAMFILES%\7-Zip\7z.exe" x -aoa "%TEMP%\sysinternals.zip" -o"%TOOLS%\sysinternals"
"%PROGRAMFILES%\7-Zip\7z.exe" x -aoa "%TEMP%\trid.zip" -o"%TOOLS%\trid"
"%PROGRAMFILES%\7-Zip\7z.exe" x -aoa "%TEMP%\triddefs.zip" -o"%TOOLS%\trid"
"%PROGRAMFILES%\7-Zip\7z.exe" x -aoa "%TEMP%\upx.zip" -o"%TOOLS%"
"%PROGRAMFILES%\7-Zip\7z.exe" x -aoa "%TEMP%\x64dbg.zip" -o"%TOOLS%\x64dbg"
"%PROGRAMFILES%\7-Zip\7z.exe" x -aoa "%TEMP%\yara.zip" -o"%TEMP%"
"%PROGRAMFILES%\7-Zip\7z.exe" x -aoa "%TEMP%\DensityScout.zip" -o"%TEMP%"

"%TEMP%\vscode.exe" /verysilent /suppressmsgboxes /MERGETASKS="!runcode,desktopicon,quicklaunchicon,addcontextmenufiles,addcontextmenufolders,addtopath"
"%TEMP%\notepad++.exe" /S

"%TOOLS%\sysinternals\Sysmon64.exe" -accepteula -i "%TEMP%\sysmonconfig-export.xml"
"%TOOLS%\hxd\HxDSetup.exe" /VERYSILENT /NORESTART

"%TEMP%\vcredist_x64.exe" /passive /norestart
"%TEMP%\python3.exe" /quiet InstallAllUsers=1 PrependPath=1 Include_test=0

rem https://www.wireshark.org/docs/wsug_html_chunked/ChBuildInstallWinInstall.html
rem silent install will not install npcap
rem "%TEMP%\wireshark.exe" /S /desktopicon=yes
rem npcap does not support silent install ....
rem "%TEMP%\npcap.exe" /loopback_support=yes

PowerShell.exe -ExecutionPolicy Bypass -File "C:\Users\WDAGUtilityAccount\Documents\tools\helpers.ps1" 2>&1 >> C:\temp\log.txt

Ftype xmlfile="C:\Program Files\Notepad++\notepad++.exe" "%%1"
Ftype txtfile="C:\Program Files\Notepad++\notepad++.exe" "%%1"
Ftype chmfile="C:\Program Files\Notepad++\notepad++.exe" "%%1"
Ftype cmdfile="C:\Program Files\Notepad++\notepad++.exe" "%%1"
Ftype htafile="C:\Program Files\Notepad++\notepad++.exe" "%%1"
Ftype jsefile="C:\Program Files\Notepad++\notepad++.exe" "%%1"
Ftype jsfile="C:\Program Files\Notepad++\notepad++.exe" "%%1"
Ftype vbefile="C:\Program Files\Notepad++\notepad++.exe" "%%1"
Ftype vbsfile="C:\Program Files\Notepad++\notepad++.exe" "%%1"
