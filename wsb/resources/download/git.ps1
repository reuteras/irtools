# Download git repositories

New-Item -ItemType Directory -Force -Path tools\downloads\git
cd tools\downloads\git

$repourls = `
    "https://github.com/keydet89/Events-Ripper.git", `
    "https://github.com/Neo23x0/evt2sigma.git", `
    "https://github.com/Neo23x0/signature-base.git", `
    "https://github.com/SigmaHQ/sigma.git", `
    "https://github.com/volexity/threat-intel.git"

foreach ($repourl in $repourls) {
    $repo = Write-Output $repourl | % { $_ -replace "^.*/" } | % { $_ -replace "\..*$" }
    if ( Test-Path -Path $repo ) {
        cd $repo
        git pull
        cd ..
    } else {
        git clone $repourl
    }
}

cd ..\..\..
