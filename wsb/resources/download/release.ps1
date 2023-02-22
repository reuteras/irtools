Write-Host "Download HTTP and releases from GitHub."

Function Get-GitHubRelease {
    Param (
        [string]$repo,
        [string]$path
    )

    $releases = "https://api.github.com/repos/$repo/releases"

    $start_time = Get-Date
    $downloads = (Invoke-WebRequest $releases | ConvertFrom-Json)[0].assets.browser_download_url
    if ( ( Write-Output $downloads | Measure-Object -word ).Words -gt 1 ) {
        $url = Write-Output $downloads | findstr /R "win Windows Installer.x64.exe$ qpdf cmder.7z VS_LIBEMU w64" | findstr /R /V "darwin"
    } else {
        $url = $downloads
    }

    if ( ( Write-Output $url | Measure-Object -word ).Words -gt 1 ) {
        $url = Write-Output $url | findstr /R "msvc64.zip win64 Installer.x64.exe$ x86_64-pc-windows-msvc x64_win_vs17 VS_LIBEMU w64" | findstr /R /V "win32"
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
    Get-GitHubRelease -repo "BurntSushi/ripgrep" -path "$($PSScriptRoot)\..\..\tools\downloads\ripgrep.zip"
    Get-GitHubRelease -repo "cmderdev/cmder" -path "$($PSScriptRoot)\..\..\tools\downloads\cmder.7z"
    Get-GitHubRelease -repo "dnSpyEx/dnSpy" -path "$($PSScriptRoot)\..\..\tools\downloads\dnSpy.zip"
    Get-GitHubRelease -repo "dzzie/VS_LIBEMU" -path "$($PSScriptRoot)\..\..\tools\downloads\scdbg.zip"
    Get-GitHubRelease -repo "hasherezade/pe-bear" -path "$($PSScriptRoot)\..\..\tools\downloads\pebear.zip"
    Get-GitHubRelease -repo "gchq/CyberChef" -path "$($PSScriptRoot)\..\..\tools\downloads\CyberChef.zip"
    Get-GitHubRelease -repo "mandiant/capa" -path "$($PSScriptRoot)\..\..\tools\downloads\capa-windows.zip"
    Get-GitHubRelease -repo "mandiant/flare-floss" -path "$($PSScriptRoot)\..\..\tools\downloads\floss.zip"
    Get-GitHubRelease -repo "mandiant/flare-fakenet-ng" -path "$($PSScriptRoot)\..\..\tools\downloads\fakenet.zip"
    Get-GitHubRelease -repo "mandiant/GoReSym" -path "$($PSScriptRoot)\..\..\tools\downloads\GoReSym.zip"
    Get-GitHubRelease -repo "NationalSecurityAgency/ghidra" -path "$($PSScriptRoot)\..\..\tools\downloads\ghidra.zip"
    Get-GitHubRelease -repo "Neo23x0/Loki" -path "$($PSScriptRoot)\..\..\tools\downloads\loki.zip"
    Get-GitHubRelease -repo "notepad-plus-plus/notepad-plus-plus" -path "$($PSScriptRoot)\..\..\tools\downloads\notepad++.exe"
    Get-GitHubRelease -repo "qpdf/qpdf" -path "$($PSScriptRoot)\..\..\tools\downloads\qpdf.zip"
    Get-GitHubRelease -repo "radareorg/radare2" -path "$($PSScriptRoot)\..\..\tools\downloads\radare2.zip"
    Get-GitHubRelease -repo "rizinorg/cutter" -path "$($PSScriptRoot)\..\..\tools\downloads\cutter.zip"
    Get-GitHubRelease -repo "stedolan/jq" -path "$($PSScriptRoot)\..\..\tools\downloads\jq.exe"
    Get-GitHubRelease -repo "upx/upx" -path "$($PSScriptRoot)\..\..\tools\downloads\upx.zip"
    Get-GitHubRelease -repo "WithSecureLabs/chainsaw" -path "$($PSScriptRoot)\..\..\tools\downloads\chainsaw.zip"
    Get-GitHubRelease -repo "VirusTotal/yara" -path "$($PSScriptRoot)\..\..\tools\downloads\yara.zip"
}
Catch {
    $error[0] | Format-List * -force
}