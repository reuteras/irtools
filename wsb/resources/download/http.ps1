Write-Host "Download HTTP and releases from GitHub."

Function Download-File {
    Param (
        [string]$url,
        [string]$path
    )

    $start_time = Get-Date
    Write-Output "Downloading $($url)"
    $wc = New-Object System.Net.WebClient
    # Used to trick Sourceforge latest endpoints to get the latest x64 windows binary
    $wc.Headers['User-Agent'] = "Wget x64"
    Try {
        $wc.DownloadFile($url, $path)
    }
    Catch {
        throw $_
    }
    Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"
}

Function Download-GitHub {
    Param (
        [string]$repo,
        [string]$path
    )

    $releases = "https://api.github.com/repos/$repo/releases"

    $start_time = Get-Date
    $downloads = (Invoke-WebRequest $releases | ConvertFrom-Json)[0].assets.browser_download_url
    if ( ( Write-Output $downloads | Measure-Object -word ).Words -gt 1 ) {
        $url = Write-Output $downloads | findstr /R "win Installer.x64.exe$" | findstr /R /V "darwin"
    } else {
        $url = $downloads
    }

    if ( ( Write-Output $url | Measure-Object -word ).Words -gt 1 ) {
        $url = Write-Output $url | findstr /R "win64 x86_64-pc-windows-msvc x64_win_vs17" | findstr /R /V "win32"
    }

    Write-Output "Downloading $($url)"
    $wc = New-Object System.Net.WebClient
    # Used to trick Sourceforge latest endpoints to get the latest x64 windows binary
    $wc.Headers['User-Agent'] = "Wget x64"
    Try {
        $wc.DownloadFile($url, $path)
    }
    Catch {
        throw $_
    }
    Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"
}

Try {
    Download-GitHub -repo "BurntSushi/ripgrep" -path "$($PSScriptRoot)\..\..\tools\downloads\ripgrep.zip"
    Download-GitHub -repo "dnSpyEx/dnSpy" -path "$($PSScriptRoot)\..\..\tools\downloads\dnSpy.zip"
    Download-GitHub -repo "hasherezade/pe-bear" -path "$($PSScriptRoot)\..\..\tools\downloads\pebear.zip"
    Download-GitHub -repo "gchq/CyberChef" -path "$($PSScriptRoot)\..\..\tools\downloads\CyberChef.zip"
    Download-GitHub -repo "mandiant/capa" -path "$($PSScriptRoot)\..\..\tools\downloads\capa-windows.zip"
    Download-GitHub -repo "mandiant/flare-floss" -path "$($PSScriptRoot)\..\..\tools\downloads\floss.zip"
    Download-GitHub -repo "mandiant/GoReSym" -path "$($PSScriptRoot)\..\..\tools\downloads\GoReSym.zip"
    Download-GitHub -repo "NationalSecurityAgency/ghidra" -path "$($PSScriptRoot)\..\..\tools\downloads\ghidra.zip"
    Download-GitHub -repo "Neo23x0/Loki" -path "$($PSScriptRoot)\..\..\tools\downloads\loki.zip"
    Download-GitHub -repo "notepad-plus-plus/notepad-plus-plus" -path "$($PSScriptRoot)\..\..\tools\downloads\notepad++.exe"
    Download-GitHub -repo "stedolan/jq" -path "$($PSScriptRoot)\..\..\tools\downloads\jq.exe"
    Download-GitHub -repo "upx/upx" -path "$($PSScriptRoot)\..\..\tools\downloads\upx.zip"
    Download-GitHub -repo "WithSecureLabs/chainsaw" -path "$($PSScriptRoot)\..\..\tools\downloads\chainsaw.zip"
    Download-GitHub -repo "VirusTotal/yara" -path "$($PSScriptRoot)\..\..\tools\downloads\yara.zip"
}
Catch {
    $error[0] | Format-List * -force
}

Try {
    Download-File -url "https://update.code.visualstudio.com/latest/win32-x64-user/stable" -path "$($PSScriptRoot)\..\..\tools\downloads\vscode.exe"
    Download-File -url "https://raw.githubusercontent.com/SwiftOnSecurity/sysmon-config/master/sysmonconfig-export.xml" -path "$($PSScriptRoot)\..\..\tools\downloads\sysmonconfig-export.xml"
    Download-File -url "https://corretto.aws/downloads/latest/amazon-corretto-17-x64-windows-jdk.msi" -path "$($PSScriptRoot)\..\..\tools\downloads\corretto.msi"
    Download-File -url "https://download.sysinternals.com/files/SysinternalsSuite.zip" -path "$($PSScriptRoot)\..\..\tools\downloads\sysinternals.zip"
    Download-File -url "https://sourceforge.net/projects/x64dbg/files/latest/download" -path "$($PSScriptRoot)\..\..\tools\downloads\x64dbg.zip"
    Download-File -url "https://sourceforge.net/projects/exiftool/files/latest/download" -path "$($PSScriptRoot)\..\..\tools\downloads\exiftool.zip"
    Download-File -url "https://www.winitor.com/tools/pestudio/current/pestudio.zip" -path "$($PSScriptRoot)\..\..\tools\downloads\pestudio.zip"
    Download-File -url "https://mh-nexus.de/downloads/HxDSetup.zip" -path "$($PSScriptRoot)\..\..\tools\downloads\hxd.zip"
    Download-File -url "https://mark0.net/download/trid_w32.zip" -path "$($PSScriptRoot)\..\..\tools\downloads\trid.zip"
    Download-File -url "https://mark0.net/download/triddefs.zip" -path "$($PSScriptRoot)\..\..\tools\downloads\triddefs.zip"
    Download-File -url "https://malcat.fr/latest/malcat_win64_lite.zip" -path "$($PSScriptRoot)\..\..\tools\downloads\malcat.zip"
    # Update the following when new versions are released
    Download-File -url "https://www.python.org/ftp/python/3.10.10/python-3.10.10-amd64.exe" -path "$($PSScriptRoot)\..\..\tools\downloads\python3.exe"
    Download-File -url "https://npcap.com/dist/npcap-1.72.exe" -path "$($PSScriptRoot)\..\..\tools\downloads\npcap.exe"
    Download-File -url "https://1.eu.dl.wireshark.org/win64/Wireshark-win64-4.0.3.exe" -path "$($PSScriptRoot)\..\..\tools\downloads\wireshark.exe"
    Download-File -url "https://sqlite.org/2022/sqlite-tools-win32-x86-3400100.zip" -path "$($PSScriptRoot)\..\..\tools\downloads\sqlite.zip"
    Download-File -url "https://www.7-zip.org/a/7z2201-x64.msi" -path "$($PSScriptRoot)\..\..\tools\downloads\7zip.msi"
    Download-File -url "https://cert.at/media/files/downloads/software/densityscout/files/densityscout_build_45_windows.zip" -path "$($PSScriptRoot)\..\..\tools\downloads\DensityScout.zip"
    # Dependence for PE-bear
    Download-File -url "https://download.microsoft.com/download/9/3/F/93FCF1E7-E6A4-478B-96E7-D4B285925B00/vc_redist.x64.exe" -path "$($PSScriptRoot)\..\..\tools\downloads\vcredist_x64.exe"
    # Background image
    Download-File -url "https://images.contentstack.io/v3/assets/blt36c2e63521272fdc/blt5fe12bc93e60d63e/5fce9c4d752123476ba026d5/DFIR-cityscape.png" -path "$($PSScriptRoot)\..\..\tools\downloads\sans.png"
}
Catch {
    $error[0] | Format-List * -force
}
