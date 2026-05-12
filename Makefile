VENV = .venv
PYTHON = $(VENV)/bin/python3
PIP = $(VENV)/bin/pip
MYPY = $(VENV)/bin/mypy
FLAKE8 = $(VENV)/bin/flake8
PYTEST = $(VENV)/bin/pytest
BLACK = $(VENV)/bin/black

PROJECT_DIR = smart_tax_tools
SRC_DIR = $(PROJECT_DIR)/src
TESTS_DIR = $(PROJECT_DIR)/tests

.PHONY: all install lint typecheck test clean build publish format check-deps check

all: format lint typecheck check-deps test

install:
	python3 -m venv $(VENV)
	$(PIP) install --upgrade pip
	$(PIP) install flake8 mypy pytest build twine black pip-check-reqs
	$(PIP) install -r requirements.txt

typecheck:
	$(MYPY) $(SRC_DIR)

format:
	$(BLACK) $(SRC_DIR) $(TESTS_DIR)

lint:
	$(FLAKE8) $(SRC_DIR) $(TESTS_DIR)

check-deps:
	@echo "Checking for missing or extra dependencies..."
	$(VENV)/bin/pip-extra-reqs smart_tax_tools/src
	$(VENV)/bin/pip-missing-reqs smart_tax_tools/src

test:
	PYTHONPATH=$(SRC_DIR) $(PYTEST) $(TESTS_DIR)

check: lint typecheck check-deps

clean:
	rm -rf $(VENV) build/ dist/ *.egg-info
	find . -type d -name "__pycache__" -exec rm -rf {} +

build:
	rm -rf smart_tax_tools/dist smart_tax_tools/build smart_tax_tools/*.egg-info
	$(PYTHON) -m pip install --upgrade setuptools build twine
	$(PYTHON) -m build smart_tax_tools/ --outdir dist/

publish: build
	$(PYTHON) -m twine upload --repository testpypi dist/*