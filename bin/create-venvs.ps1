#!/bin/bash
mkdir venv
python -m venv venv/cs
. venv/cs/Scripts/activate
python -m pip install -U pip
python -m pip install -U javaobj-py3
