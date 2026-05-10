PYTHON = .venv/bin/python3
PYTEST = .venv/bin/pytest
MYPY = .venv/bin/mypy
FLAKE8 = .venv/bin/flake8
BUILD = $(PYTHON) -m build
TWINE = $(PYTHON) -m twine

PROJECT_DIR = smart_tax_tools

.PHONY: all test lint typecheck clean build publish

all: lint typecheck test

install:
	python3 -m venv .venv
	$(PYTHON) -m pip install --upgrade pip
	$(PYTHON) -m pip install flake8 mypy pytest build twine

clean:
	rm -rf $(PROJECT_DIR)/.pytest_cache $(PROJECT_DIR)/.mypy_cache build/ dist/ *.egg-info
	find . -type d -name "__pycache__" -exec rm -rf {} +

lint:
	$(FLAKE8) $(PROJECT_DIR)/src/ $(PROJECT_DIR)/tests/

typecheck:
	$(MYPY) $(PROJECT_DIR)/src/

test:
	PYTHONPATH=$(PROJECT_DIR)/src $(PYTEST) $(PROJECT_DIR)/tests/

build: clean
	$(PYTHON) -m pip install --upgrade setuptools build twine
	cd smart_tax_tools && python3 -m build --outdir ../dist/

publish: build
	$(TWINE) upload --repository testpypi dist/*