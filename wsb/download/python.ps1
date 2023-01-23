# Download Python pip

python3 -m venv .wsb
./.wsb/Scripts/Activate.ps1

python -m pip install -U pip
python -m pip install pip2pi

pip2pi ./tools/downloads/pip `
    dnslib docx2txt dpkt extract-msg fonttools javaobj `
    lxml pypng python-magic PyYaml minidump name-that-hash numpy olefile `
    olefile `
    oletools[full] openpyxl pandas pefile peutils ppdeep pycryptodome pyzipper `
    visidata xlrd yara-python wheel

deactivate
rm -r .wsb
