# Install Python based tools
cd C:\Users\WDAGUtilityAccount\Documents\tools\downloads\pip
Get-ChildItem . -Filter wheel* | Foreach-Object { python -m pip install --disable-pip-version-check $_ } > c:\temp\python.txt
Get-ChildItem . -Filter *.gz | Foreach-Object { python -m pip install --disable-pip-version-check --no-deps $_ } >> c:\temp\python.txt
Get-ChildItem . -Filter *.whl | Foreach-Object { python -m pip install --disable-pip-version-check --no-deps $_ } >> c:\temp\python.txt
Get-ChildItem . -Filter *.zip | Foreach-Object { python -m pip install --disable-pip-version-check --no-deps $_ } >> c:\temp\python.txt
cp -r C:\Users\WDAGUtilityAccount\Documents\tools\downloads\git\threat-intel c:\temp
cd C:\temp\threat-intel\tools\one-extract
python -m pip install --disable-pip-version-check . >> c:\temp\one-extract.txt
