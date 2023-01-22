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

Try {
  Download-File -url "https://update.code.visualstudio.com/latest/win32-x64-user/stable" -path "$($PSScriptRoot)\..\tools\downloads\vscode.exe"
  Download-File -url "https://corretto.aws/downloads/latest/amazon-corretto-17-x64-windows-jdk.msi" -path "$($PSScriptRoot)\..\tools\downloads\corretto.msi"
  Download-File -url "https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.4.8/npp.8.4.8.Installer.x64.exe" -path "$($PSScriptRoot)\..\tools\downloads\notepad++.exe"
  Download-File -url "https://github.com/NationalSecurityAgency/ghidra/releases/download/Ghidra_10.2.2_build/ghidra_10.2.2_PUBLIC_20221115.zip" -path "$($PSScriptRoot)\..\tools\downloads\ghidra.zip"
  Download-File -url "https://www.7-zip.org/a/7z2201-x64.msi" -path "$($PSScriptRoot)\..\tools\downloads\7zip.msi"
  Download-File -url "https://download.sysinternals.com/files/SysinternalsSuite.zip" -path "$($PSScriptRoot)\..\tools\downloads\sysinternals.zip"
  Download-File -url "https://sourceforge.net/projects/x64dbg/files/latest/download" -path "$($PSScriptRoot)\..\tools\downloads\x64dbg.zip"
  Download-File -url "https://www.python.org/ftp/python/3.11.1/python-3.11.1-amd64.exe" -path "$($PSScriptRoot)\..\tools\downloads\python3.exe"
  Download-File -url "https://mh-nexus.de/downloads/HxDSetup.zip" -path "$($PSScriptRoot)\..\tools\downloads\hxd.zip"
  Download-File -url "https://npcap.com/dist/npcap-1.72.exe" -path "$($PSScriptRoot)\..\tools\downloads\npcap.exe"
  Download-File -url "https://1.eu.dl.wireshark.org/win64/Wireshark-win64-4.0.3.exe" -path "$($PSScriptRoot)\..\tools\downloads\wireshark.exe"
  Download-File -url "https://github.com/upx/upx/releases/download/v4.0.1/upx-4.0.1-win64.zip" -path "$($PSScriptRoot)\..\tools\downloads\upx.zip"
  # Dependence for PE-bear
  Download-File -url "https://download.microsoft.com/download/9/3/F/93FCF1E7-E6A4-478B-96E7-D4B285925B00/vc_redist.x64.exe" -path "$($PSScriptRoot)\..\tools\downloads\vcredist_x64.exe"
  Download-File -url "https://github.com/hasherezade/pe-bear-releases/releases/download/0.5.5.7/PE-bear_0.5.5.7_x64_win_vs17.zip" -path "$($PSScriptRoot)\..\tools\downloads\pebear.zip"
  Download-File -url "https://www.winitor.com/tools/pestudio/current/pestudio.zip" -path "$($PSScriptRoot)\..\tools\downloads\pestudio.zip"
  Download-File -url "https://raw.githubusercontent.com/SwiftOnSecurity/sysmon-config/master/sysmonconfig-export.xml" -path "$($PSScriptRoot)\..\tools\downloads\sysmonconfig-export.xml"
  Download-File -url "https://github.com/mandiant/capa/releases/download/v4.0.1/capa-v4.0.1-windows.zip" -path "$($PSScriptRoot)\..\tools\downloads\capa-windows.zip"
  # Windows Terminal - not working at the moment
  #Download-File -url "https://github.com/microsoft/terminal/releases/download/v1.15.3465.0/Microsoft.WindowsTerminal_Win11_1.15.3466.0_8wekyb3d8bbwe.msixbundle" -path "$($PSScriptRoot)\..\tools\downloads\terminal.msixbundle"
  #Download-File -url "https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx" -path "$($PSScriptRoot)\..\tools\downloads\VCLibs.appx"
  #Download-File -url "https://github.com/microsoft/terminal/releases/download/v1.15.3465.0/Microsoft.WindowsTerminal_Win11_1.15.3466.0_8wekyb3d8bbwe.msixbundle_Windows10_PreinstallKit.zip" -path "$($PSScriptRoot)\..\tools\downloads\Microsoft.WindowsTerminal_PreinstallKit.zip"
  Download-File -url "https://images.contentstack.io/v3/assets/blt36c2e63521272fdc/blt5fe12bc93e60d63e/5fce9c4d752123476ba026d5/DFIR-cityscape.png" -path "$($PSScriptRoot)\..\tools\downloads\sans.png"
}
Catch {
  $error[0] | Format-List * -force
}
