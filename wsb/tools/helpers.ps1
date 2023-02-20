Write-Output "Start helpers.ps1"

# Declare helper functions
function Add-ToUserPath {
    param (
        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [string]
        $dir
    )

    $dir = (Resolve-Path $dir)

    $path = [Environment]::GetEnvironmentVariable("PATH", [System.EnvironmentVariableTarget]::User)
    if (!($path.Contains($dir))) {
        # append dir to path
        [Environment]::SetEnvironmentVariable("PATH", $path + ";$dir", [EnvironmentVariableTarget]::User)
        Write-Host "Added $dir to PATH"
        return
    }
    Write-Error "$dir is already in PATH"
}

function Set-Shortcut {
param ( [string]$SourceLnk, [string]$DestinationPath , [string]$WorkingDirectory)
    $WshShell = New-Object -comObject WScript.Shell
    $Shortcut = $WshShell.CreateShortcut($SourceLnk)
    if ($WorkingDirectory -ne $Null) {
        $Shortcut.WorkingDirectory = $WorkingDirectory
    }
    $Shortcut.TargetPath = $DestinationPath
    $Shortcut.Save()
}

Set-ExecutionPolicy -ExecutionPolicy Bypass -Force

Set-ItemProperty -Path "HKCU:\Control Panel\International" -name sShortDate -value "yyyy-MM-dd"
Set-ItemProperty -Path "HKCU:\Control Panel\International" -name sLongDate -value "yyyy-MMMM-dddd"
Set-ItemProperty -Path "HKCU:\Control Panel\International" -name sShortTime -value "HH:mm"
Set-ItemProperty -Path "HKCU:\Control Panel\International" -name sTimeFormat -value "HH:mm:ss"

# Rename folders and files
mv C:\Temp\win64\densityscout.exe C:\Tools\bin\densityscout.exe
mv C:\Temp\yara64.exe C:\Tools\bin\yara.exe
mv C:\Temp\yarac64.exe C:\Tools\bin\yarac.exe
mv "C:\Tools\exiftool\exiftool(-k).exe" C:\Tools\exiftool\exiftool.exe
mv C:\Tools\cutter-* C:\Tools\cutter
mv C:\Tools\CyberChef\CyberChef_* C:\Tools\CyberChef\CyberChef.html
mv C:\Tools\ghidra_* C:\Tools\ghidra
mv C:\Tools\GoReSym\GoReSym_win.exe C:\Tools\GoReSym\GoReSym.exe
mv C:\Tools\qpdf-* C:\Tools\qpdf
mv C:\Tools\ripgrep-* C:\Tools\ripgrep
mv C:\Tools\sqlite-* C:\Tools\sqlite
mv C:\Tools\upx-* C:\Tools\upx

# Remove unused
rm C:\Tools\GoReSym\GoReSym_lin
rm C:\Tools\GoReSym\GoReSym_mac
rm -r C:\Temp\win32
rm -r C:\Temp\win64

# Remove rules specific to Loki and Thor
rm C:\temp\yararules\generic_anomalies.yar
rm C:\temp\yararules\general_cloaking.yar
rm C:\temp\yararules\gen_webshells_ext_vars.yar
rm C:\temp\yararules\thor_inverse_matches.yar
rm C:\temp\yararules\yara_mixed_ext_vars.yar
rm C:\temp\yararules\configured_vulns_ext_vars.yar

# Combine rules to one file
$content = Get-ChildItem C:\temp\yararules\ | Get-Content -raw
[IO.File]::WriteAllLines("C:\Tools\signature.yar", $content)

Write-Output "Add to PATH"
Add-ToUserPath "C:\Program Files\7-Zip"
Add-ToUserPath "C:\Program Files\hxd"
Add-ToUserPath "C:\Program Files\Notepad++"
Add-ToUserPath "C:\Tools\bin"
Add-ToUserPath "C:\Tools\capa"
Add-ToUserPath "C:\Tools\chainsaw"
Add-ToUserPath "C:\Tools\cmder"
Add-ToUserPath "C:\Tools\cmder\bin"
Add-ToUserPath "C:\Tools\DidierStevens"
Add-ToUserPath "C:\Tools\exiftool"
Add-ToUserPath "C:\Tools\floss"
Add-ToUserPath "C:\Tools\GoReSym"
Add-ToUserPath "C:\Tools\loki"
Add-ToUserPath "C:\Tools\malcat\bin"
Add-ToUserPath "C:\Tools\nmap"
Add-ToUserPath "C:\Tools\qpdf\bin"
Add-ToUserPath "C:\Tools\ripgrep"
Add-ToUserPath "C:\Tools\scdbg"
Add-ToUserPath "C:\Tools\sqlite"
Add-ToUserPath "C:\Tools\sysinternals"
Add-ToUserPath "C:\Tools\trid"
Add-ToUserPath "C:\Tools\upx"
Add-ToUserPath "C:\Tools\x64dbg\release\x64"
Add-ToUserPath "C:\Tools\Zimmerman"
Add-ToUserPath "C:\Tools\Zimmerman\EvtxECmd"
Add-ToUserPath "C:\Tools\Zimmerman\EZViewer"
Add-ToUserPath "C:\Tools\Zimmerman\Hasher"
Add-ToUserPath "C:\Tools\Zimmerman\iisGeolocate"
Add-ToUserPath "C:\Tools\Zimmerman\JumpListExplorer"
Add-ToUserPath "C:\Tools\Zimmerman\MFTExplorer"
Add-ToUserPath "C:\Tools\Zimmerman\RECmd"
Add-ToUserPath "C:\Tools\Zimmerman\RegistryExplorer"
Add-ToUserPath "C:\Tools\Zimmerman\SDBExplorer"
Add-ToUserPath "C:\Tools\Zimmerman\ShellBagsExplorer"
Add-ToUserPath "C:\Tools\Zimmerman\SQLECmd"
Add-ToUserPath "C:\Tools\Zimmerman\TimelineExplorer"
Add-ToUserPath "C:\Tools\Zimmerman\XWFIM"

Write-Output "Add shortcuts (shorten link names first)"
REG ADD "HKU\%1\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "link" /t REG_BINARY /d 00000000 /f
Set-Shortcut "C:\Users\WDAGUtilityAccount\Desktop\CyberChef.lnk" "C:\Tools\CyberChef\CyberChef.html"
Set-Shortcut "C:\Users\WDAGUtilityAccount\Desktop\cmder.lnk" "C:\Tools\cmder\cmder.exe" "C:\Users\WDAGUtilityAccount\Desktop"
Set-Shortcut "C:\Users\WDAGUtilityAccount\Desktop\Cutter.lnk" "C:\Tools\cutter\cutter.exe"
Set-Shortcut "C:\Users\WDAGUtilityAccount\Desktop\dnSpy.lnk" "C:\Tools\dnSpy\dnSpy.exe"
Set-Shortcut "C:\Users\WDAGUtilityAccount\Desktop\ghidraRun.lnk" "C:\Tools\ghidra\ghidraRun.bat"
Set-Shortcut "C:\Users\WDAGUtilityAccount\Desktop\HxD.lnk" "C:\Program Files\HxD\HxD.exe"
Set-Shortcut "C:\Users\WDAGUtilityAccount\Desktop\Malcat.lnk" "C:\Tools\Malcat\bin\malcat.exe"
Set-Shortcut "C:\Users\WDAGUtilityAccount\Desktop\Notepad++.lnk" "C:\Program Files\Notepad++\notepad++.exe"
Set-Shortcut "C:\Users\WDAGUtilityAccount\Desktop\PE-bear.lnk" "C:\Tools\pebear\PE-bear.exe"
Set-Shortcut "C:\Users\WDAGUtilityAccount\Desktop\pestudio.lnk" "C:\Tools\pestudio\pestudio\pestudio.exe"
Set-Shortcut "C:\Users\WDAGUtilityAccount\Desktop\PowerShell.lnk" "C:\Windows\system32\WindowsPowerShell\v1.0\powershell.exe"
Set-Shortcut "C:\Users\WDAGUtilityAccount\Desktop\Tools.lnk" "C:\Tools"
Set-Shortcut "C:\Users\WDAGUtilityAccount\Desktop\x64dbg.lnk" "C:\Tools\x64dbg\release\x64\x64dbg.exe"

Write-Output "Hide file extensions"
REG ADD HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced /v HideFileExt /t REG_DWORD /d 0 /f
REG ADD HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\Folder\HideFileExt /v DefaultValue /t REG_DWORD /d 0 /f
REG ADD HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\Folder\Hidden\SHOWALL /v DefaultValue /t REG_DWORD /d 1 /f
REG ADD HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced /v HideFileExt /t REG_DWORD /d 0 /f
REG ADD HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced /v Hidden /t REG_DWORD /d 0 /f
REG ADD HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced /v ShowSuperHidden /t REG_DWORD /d 1 /f
REG ADD HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced /v DontPrettyPath /t REG_DWORD /d 1 /f

REG ADD HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\Folder\HideFileExt /v DefaultValue /t REG_DWORD /d 0 /f
REG ADD HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\Folder\Hidden\SHOWALL /v DefaultValue /t REG_DWORD /d 1 /f
REG ADD HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced /v HideFileExt /t REG_DWORD /d 0 /f
REG ADD HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced /v Hidden /t REG_DWORD /d 0 /f
REG ADD HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced /v ShowSuperHidden /t REG_DWORD /d 1 /f
REG ADD HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced /v DontPrettyPath /t REG_DWORD /d 1 /f

# Copy signatures
cp -r "C:\Users\WDAGUtilityAccount\Documents\tools\downloads\git\signature-base" C:\Tools\loki\signature-base

New-Item -Path HKLM:\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging -Force
Set-ItemProperty -Path HKLM:\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging -Name EnableScriptBlockLogging -Value 1 -Force

# Add cmder integration
C:\Tools\cmder\cmder.exe /REGISTER ALL

Write-Output "Change background to python"
PowerShell.exe -ExecutionPolicy Bypass -File C:\Users\WDAGUtilityAccount\Documents\tools\Update-Wallpaper.ps1 C:\Users\WDAGUtilityAccount\Documents\tools\downloads\python.png
$shell = New-Object -ComObject "Shell.Application"
$shell.sendkeys('{F5}')

Stop-Process -ProcessName Explorer -Force

# Install Python pip packages
PowerShell.exe -ExecutionPolicy Bypass -File C:\Users\WDAGUtilityAccount\Documents\tools\install_python_tools.ps1

# Configure usage of new venv for cmder and PowerShell
Write-Output "C:\venv\scripts\activate.bat" | Out-File -Append -Encoding "ascii" C:\Tools\cmder\config\user_profile.cmd
cp "C:\Users\WDAGUtilityAccount\Documents\tools\Microsoft.PowerShell_profile.ps1" "C:\Users\WDAGUtilityAccount\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"

# Signal that everything is done.
cp "C:\Users\WDAGUtilityAccount\Documents\tools\downloads\README.md" "C:\Users\WDAGUtilityAccount\Desktop\"
PowerShell.exe -ExecutionPolicy Bypass -File C:\Users\WDAGUtilityAccount\Documents\tools\Update-Wallpaper.ps1 C:\temp\sans.jpg
C:\Tools\sysinternals\Bginfo64.exe /NOLICPROMPT /timer:0 C:\Users\WDAGUtilityAccount\Documents\tools\config.bgi
Write-Output "helpers.ps1 done."
