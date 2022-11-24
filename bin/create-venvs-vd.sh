#!/bin/bash
# Install visidata

[[ -d ~/venvs ]] || mkdir ~/venvs
python -m venv ~/venvs/vd
. ~/venvs/vd/Scripts/activate
python -m pip install -U pip
python -m pip install -U visidata dpkt dnslib openpyxl xlrd lxml
