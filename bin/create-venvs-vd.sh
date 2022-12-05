#!/bin/bash
# Install visidata

[[ -d ~/venvs ]] || mkdir ~/venvs
python3 -m venv ~/venvs/vd
# shellcheck disable=SC1090
. ~/venvs/vd/Scripts/activate && python3 -m pip install -U pip
# shellcheck disable=SC1090
. ~/venvs/vd/Scripts/activate && python3 -m pip install -U visidata dpkt dnslib openpyxl xlrd lxml
