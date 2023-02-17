.\resources\download\didier.ps1
.\resources\download\git.ps1
.\resources\download\http.ps1
.\resources\download\python.ps1
.\resources\download\zimmerman.ps1
cp README.md .\tools\downloads\
cp .\resources\images\copying.png .\tools\downloads\
cp .\resources\images\installing.png .\tools\downloads\
cp .\resources\images\python.png .\tools\downloads\
$sourceFile = "$PSScriptRoot\tools\downloads\sans.png"
$saveFile = "$PSScriptRoot\tools\downloads\sans.jpg"
Add-Type -AssemblyName system.drawing
$imageFormat = "System.Drawing.Imaging.ImageFormat" -as [type]
$image = [drawing.image]::FromFile($sourceFile)
$image.Save($saveFile, $imageFormat::jpeg)
