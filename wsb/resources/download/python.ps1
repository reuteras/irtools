Write-Host "Download Python pip packages."

$VENV = "$env:HOMEDRIVE$env:HOMEPATH/.wsb"

if (Test-Path -Path $VENV) {
    "Path $VENV exists!"
    Exit
}

python3 -m venv "$VENV"
& "$VENV/Scripts/Activate.ps1"

python -m pip install -U pip
python -m pip install pip2pi

if (Test-Path -Path ./tools/downloads/pip ) {
    rm -r ./tools/downloads/pip
}

pip2pi ./tools/downloads/pip `
    chepy[extras] `
    colorama `
    dnslib `
    docx2txt `
    dpkt `
    extract-msg `
    fonttools `
    hachoir `
    LnkParse3 `
    lxml `
    minidump `
    msgpack `
    msoffcrypto-tool `
    name-that-hash `
    numpy `
    olefile `
    oletools[full] `
    openpyxl `
    pandas `
    pcode2code `
    pcodedmp `
    pefile `
    peutils `
    ppdeep `
    pycryptodome `
    pyelftools `
    pypng `
    python-magic-bin `
    pyzipper `
    python-magic `
    setuptools `
    time-decode `
    visidata `
    xlrd `
    XLMMacroDeobfuscator `
    yara-python `
    wheel 2>&1 | findstr /V "ERROR linking"

deactivate
rm -r "$VENV"
