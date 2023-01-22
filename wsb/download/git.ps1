# Download git repositories

New-Item -ItemType Directory -Force -Path tools\download\git
cd tools\download\git

$repourls = "https://github.com/volexity/threat-intel.git"

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
