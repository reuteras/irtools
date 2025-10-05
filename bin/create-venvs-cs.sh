#!/bin/bash

[[ -d ~/venvs ]] || mkdir ~/venvs
python3 -m venv ~/venvs/cs
# shellcheck disable=SC1090
. ~/venvs/cs/Scripts/activate && python3 -m pip install -U pip
# shellcheck disable=SC1090
. ~/venvs/cs/Scripts/activate && python3 -m pip install -U javaobj-py3
