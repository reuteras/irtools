# Download git repositories

New-Item -ItemType Directory -Force -Path tools\downloads\git
cd tools\downloads\git

$repourls = "https://github.com/volexity/threat-intel.git", `
    "https://github.com/Neo23x0/signature-base"

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
