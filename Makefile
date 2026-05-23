.PHONY: minimal
minimal: venv

.PHONY: venv
venv:
	uv sync

.PHONY: test
test: venv
	uv run coverage erase
	uv run coverage run -m pytest -v tests
	uv run coverage report --show-missing --fail-under 100
	uv run pre-commit install -f --install-hooks
	uv run pre-commit run --all-files

.PHONY: release
release:
	uv build
	uvx twine upload --skip-existing dist/*

.PHONY: test-repo
test-repo: venv
	uv run python -m dumb_pypi.main \
		--package-list-json testing/package-list-json \
		--packages-url http://just.an.example/ \
		--output-dir test-repo \
		--logo https://i.fluffy.cc/tZRP1V8hdKCdrRQG5fBCv74M0VpcPLjP.svg \
		--logo-width 42
