Write-Host "Download git repositories"

New-Item -ItemType Directory -Force -Path tools\downloads\git > $null
Set-Location tools\downloads\git

$repourls = `
    "https://github.com/keydet89/Events-Ripper.git", `
    "https://github.com/Neo23x0/evt2sigma.git", `
    "https://github.com/Neo23x0/signature-base.git", `
    "https://github.com/ReFirmLabs/binwalk.git", `
    "https://github.com/SigmaHQ/sigma.git", `
    "https://github.com/volexity/threat-intel.git"

foreach ($repourl in $repourls) {
    $repo = Write-Output $repourl | ForEach-Object { $_ -replace "^.*/" } | ForEach-Object { $_ -replace "\..*$" }
    if ( Test-Path -Path $repo ) {
        Set-Location $repo
        git pull
        Set-Location ..
    } else {
        git clone $repourl
    }
}

Set-Location ..\..\..
