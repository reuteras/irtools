# Download Python pip
Start-Process -FilePath python.exe `
    -ArgumentList '-m http.server --bind 127.0.0.1' `
    -WorkingDirectory ./tools/downloads/pip `
    -NoNewWindow

python3 -m venv .wsb
./.wsb/Scripts/Activate.ps1

python -m pip install -U pip
python -m pip install pip2pi

pip2pi ./tools/downloads/pip ConfigParser dnslib docx2txt dpkt extract-msg fonttools javaobj lxml pypng python-magic `
    PyYaml name-that-hash numpy olefile oletools[full] openpyxl pandas pefile peutils ppdeep pyzipper visidata xlrd yara-python

deactivate
rm -r .wsb
