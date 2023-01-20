Write-Output "Start helpers.ps1"

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
        # backup the current value
        "PATH=$path" | Set-Content -Path "$env:USERPROFILE/path.env"
        # append dir to path
        [Environment]::SetEnvironmentVariable("PATH", $path + ";$dir", [EnvironmentVariableTarget]::User)
        Write-Host "Added $dir to PATH"
        return
    }
    Write-Error "$dir is already in PATH"
}

function Set-Shortcut {
param ( [string]$SourceLnk, [string]$DestinationPath )
    $WshShell = New-Object -comObject WScript.Shell
    $Shortcut = $WshShell.CreateShortcut($SourceLnk)
    $Shortcut.TargetPath = $DestinationPath
    $Shortcut.Save()
    }

Write-Output "Add to PATH"

Add-ToUserPath "C:\Tools\sysinternals"
Add-ToUserPath "C:\Tools\x64dbg\release\x64"
Add-ToUserPath "C:\Tools\capa"
Add-ToUserPath "C:\Tools\DidierStevens"
Add-ToUserPath "C:\Tools\Zimmerman"
Add-ToUserPath "C:\Tools\upx\upx-4.0.1-win64"

Write-Output "Add shortcuts"

REG ADD "HKU\%1\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "link" /t REG_BINARY /d 00000000 /f

Set-Shortcut "C:\Users\WDAGUtilityAccount\Desktop\PE-bear.lnk" "C:\Tools\pebear\PE-bear.exe"
Set-Shortcut "C:\Users\WDAGUtilityAccount\Desktop\pestudio.lnk" "C:\Tools\pestudio\pestudio\pestudio.exe"
Set-Shortcut "C:\Users\WDAGUtilityAccount\Desktop\x64dbg.lnk" "C:\Tools\x64dbg\release\x64\x64dbg.exe"
Set-Shortcut "C:\Users\WDAGUtilityAccount\Desktop\HxD.lnk" "C:\Program Files\HxD\HxD.exe"
Set-Shortcut "C:\Users\WDAGUtilityAccount\Desktop\Notepad++.lnk" "C:\Program Files\Notepad++\notepad++.exe"
Set-Shortcut "C:\Users\WDAGUtilityAccount\Desktop\Tools.lnk" "C:\Tools"
Set-Shortcut "C:\Users\WDAGUtilityAccount\Desktop\PowerShell.lnk" "C:\Windows\system32\WindowsPowerShell\v1.0\powershell.exe"
Set-Shortcut "C:\Users\WDAGUtilityAccount\Desktop\ghidraRun.lnk" "C:\Tools\ghidra\ghidra_10.2.2_PUBLIC\ghidraRun.bat"

Write-Output "Show file extensions"

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

Write-Output "Change background"

PowerShell.exe -ExecutionPolicy Bypass -File C:\Users\WDAGUtilityAccount\Desktop\tools\Update-Wallpaper.ps1 C:\temp\sans.png
$shell = New-Object -ComObject "Shell.Application"
$shell.sendkeys('{F5}')

Write-Output "helpers.ps1 done."