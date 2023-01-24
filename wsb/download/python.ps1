# Download Python pip

python3 -m venv .wsb
./.wsb/Scripts/Activate.ps1

python -m pip install -U pip
python -m pip install pip2pi

pip2pi ./tools/downloads/pip `
    chepy[extras] dnslib docx2txt dpkt extract-msg fonttools hachoir javaobj `
    lxml pyelftools pypng python-magic PyYaml minidump msoffcrypto-tool `
    name-that-hash numpy olefile olefile oletools[full] openpyxl pandas `
    pcode2code pcodedmp pefile peutils ppdeep pycryptodome pyzipper `
    time-decode visidata xlrd XLMMacroDeobfuscator yara-python wheel

deactivate
rm -r .wsb
