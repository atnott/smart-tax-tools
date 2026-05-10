PYTHON = .venv/bin/python3
PYTEST = .venv/bin/pytest
MYPY = .venv/bin/mypy
FLAKE8 = .venv/bin/flake8

PROJECT_DIR = smart_tax_tools

.PHONY: all test lint typecheck clean

all: lint typecheck test

clean:
	rm -rf $(PROJECT_DIR)/.pytest_cache $(PROJECT_DIR)/.mypy_cache build/ dist/ *.egg-info
	find . -type d name "__pycache__" -exec rm -rf {} +

lint:
	$(FLAKE8) $(PROJECT_DIR)/src/ $(PROJECT_DIR)/tests/

typecheck:
	$(MYPY) $(PROJECT_DIR)/src/

test:
	PYTHONPATH=$(PROJECT_DIR)/src $(PYTEST) $(PROJECT_DIR)/tests/