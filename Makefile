.PHONY: all dev ci lint check_style coverage run docker_up docker_down test clean

SHELL:=/bin/bash
RUN=poetry run
PYTHON=${RUN} python

all:
	@echo "make dev"
	@echo "    Create development environment."
	@echo "make style"
	@echo "    Run lint on project."
	@echo "make check"
	@echo "    Check code-style, run linters, run tests"
	@echo "make coverage"
	@echo "    Run code coverage check."
	@echo "make test"
	@echo "    Run tests on project."
	@echo "make run"
	@echo "    Run development web-server."
	@echo "make clean"
	@echo "    Remove python artifacts and virtualenv"

dev:
	poetry install --with dev

coverage:
	${RUN} coverage run manage.py test
	${RUN} coverage report -m

style:
	${RUN} pre-commit run --all-files

test:
	${PYTHON} -m unittest

check: style test

run: dev
	${PYTHON} main.py

clean:
	poetry env list | awk '{print $$1}' | xargs -I {} poetry env remove {}
	find . -name '*.pyc' -delete
	rm -rf *.eggs *.egg-info dist build docs/_build .cache .mypy_cache
