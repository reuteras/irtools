virtualenv = urlscan
pip = python -m pip
all: environment requires test-pylint test-bandit
environment:
	test -d $(virtualenv) || python3 -m venv $(virtualenv)
	. $(virtualenv)/bin/activate && python -m pip install -U pip
requires:
	. $(virtualenv)/bin/activate && $(pip) install -r requirements.txt
upgrade-requirements:
	echo "Current versions"
	. $(virtualenv)/bin/activate && $(pip) freeze
	. $(virtualenv)/bin/activate && $(pip) install --upgrade -r requirements.txt
upgrade-pip3:
	. $(virtualenv)/bin/activate && pip3 install -U pip
dev-requires:
	. $(virtualenv)/bin/activate && $(pip) install -r dev-requirements.txt
upgrade-dev-requirements:
	echo "Current versions"
	. $(virtualenv)/bin/activate && $(pip) freeze
	. $(virtualenv)/bin/activate && $(pip) install --upgrade -r dev-requirements.txt
clean:
	rm -rf $(virtualenv) __pycache__ bandit-env images pylint
	find . -name "*.pyc" -exec rm -f {} \;
test-pylint: dev-requires
	test -d pylint || mkdir pylint
	. $(virtualenv)/bin/activate && pylint urlscan.py > pylint/urlscan.pylint || exit 0
test-bandit:
	rm -rf bandit-env
	python3 -m venv bandit-env
	source bandit-env/bin/activate && python3 -m pip install bandit
	./bandit-env/bin/bandit ./urlscan.py
	rm -rf bandit-env
