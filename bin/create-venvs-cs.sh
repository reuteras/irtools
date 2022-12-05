#!/bin/bash

[[ -d ~/venvs ]] || mkdir ~/venvs
python3 -m venv ~/venvs/cs
. ~/venvs/cs/Scripts/activate
python3 -m pip install -U pip
python3 -m pip install -U javaobj-py3
