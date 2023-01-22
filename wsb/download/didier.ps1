New-Item -ItemType Directory -Force -Path .\tools\downloads\DidierStevens

$DidierStevensSuite = "1768.json","1768.py","base64dump.py","byte-stats.py","count.py","cs-analyze-processdump.py","cs-decrypt-metadata.py", `
	"cs-extract-key.py","cut-bytes.py","file-magic.def","file-magic.py","find-file-in-file.py","hash.py","headtail.py","hex-to-bin.py", `
	"jpegdump.py","myjson-filter.py","numbers-to-string.py","oledump.py","pdf-parser.py","pdfid.ini","pdfid.py","pdftool.py","pecheck.py", `
	"python-per-line.py","re-search.py","reextra.py","rtfdump.py","ssdeep.py","strings.py","teeplus.py","translate.py","xmldump.py","zipdump.py"

foreach ($Tool in $DidierStevensSuite)
{
  curl -o .\tools\downloads\DidierStevens\$Tool https://raw.githubusercontent.com/DidierStevens/DidierStevensSuite/master/$Tool
}

$DidierStevensBeta = "onedump.py"

foreach ($Tool in $DidierStevensBeta)
{
  curl -o .\tools\downloads\DidierStevens\$Tool https://raw.githubusercontent.com/DidierStevens/Beta/master/$Tool
}
