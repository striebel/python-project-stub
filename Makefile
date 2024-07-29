PIP_REQ_SPEC   = 'pip>=21.0.1,<24.0.1'
BUILD_REQ_SPEC = 'build>=1.2.1,<2.0.0'
TWINE_REQ_SPEC = 'twine>=5.0.0,<6.0.0'

install-editable:
	. ./meta.sh >/dev/null && python -m venv ./venv-$${NAME}
	. ./meta.sh >/dev/null && ./venv-$${NAME}/bin/pip install --upgrade \
		$(PIP_REQ_SPEC)
	. ./meta.sh >/dev/null && ./_setup.py
	. ./meta.sh >/dev/null && ./venv-$${NAME}/bin/pip install --upgrade \
		--editable .
	rm ./pyproject.toml
	rm ./setup.cfg
	rm ./MANIFEST.in

build:
	. ./meta.sh >/dev/null && python -m venv ./venv-$${NAME}
	. ./meta.sh >/dev/null && ./venv-$${NAME}/bin/pip install --upgrade \
		$(PIP_REQ_SPEC)
	. ./meta.sh >/dev/null && ./venv-$${NAME}/bin/pip install --upgrade \
		$(BUILD_REQ_SPEC)
	. ./meta.sh >/dev/null && ./_setup.py
	rm -rf ./dist
	rm -rf ./*.egg-info
	. ./meta.sh >/dev/null && ./venv-$${NAME}/bin/python -m build --sdist .
	rm ./pyproject.toml
	rm ./setup.cfg
	rm ./MANIFEST.in
	rm -rf ./*.egg-info

test-local:
	. ./meta.sh >/dev/null && python -m venv ./venv-$${NAME}
	. ./meta.sh >/dev/null && ./venv-$${NAME}/bin/pip install --upgrade \
		$(PIP_REQ_SPEC)
	. ./meta.sh >/dev/null && ./venv-$${NAME}/bin/pip uninstall --yes $${NAME}
	. ./meta.sh >/dev/null && ./venv-$${NAME}/bin/pip install --no-cache-dir \
		./dist/`printf $${NAME} | tr .- _`-$${VERSION}.tar.gz
	. ./meta.sh >/dev/null && ./venv-$${NAME}/bin/python -m \
		`printf $${NAME} | tr - _`
	. ./meta.sh >/dev/null && ./venv-$${NAME}/bin/python -m \
		`printf $${NAME} | tr - _` --version

upload-testpypi:
	. ./meta.sh >/dev/null && python -m venv ./venv-$${NAME}
	. ./meta.sh >/dev/null && ./venv-$${NAME}/bin/pip install --upgrade \
		$(PIP_REQ_SPEC)
	. ./meta.sh >/dev/null && ./venv-$${NAME}/bin/pip install --upgrade \
		$(TWINE_REQ_SPEC)
	. ./meta.sh >/dev/null && ./venv-$${NAME}/bin/python -m twine upload \
        	--repository testpypi-$${NAME} \
		./dist/`printf $${NAME} | tr .- _`-$${VERSION}.tar.gz

upload:
	. ./meta.sh >/dev/null && python -m venv ./venv-$${NAME}
	. ./meta.sh >/dev/null && ./venv-$${NAME}/bin/pip install --upgrade \
		$(PIP_REQ_SPEC)
	. ./meta.sh >/dev/null && ./venv-$${NAME}/bin/pip install --upgrade \
		$(TWINE_REQ_SPEC)
	. ./meta.sh >/dev/null && ./venv-$${NAME}/bin/python -m twine upload \
		--repository pypi-python-project-stub \
		./dist/`printf $${NAME} | tr .- _`-$${VERSION}.tar.gz

test-testpyi:
	. ./meta.sh >/dev/null && python -m venv ./venv-$${NAME}
	. ./meta.sh >/dev/null && ./venv-$${NAME}/bin/pip install --upgrade \
		$(PIP_REQ_SPEC)
	. ./meta.sh >/dev/null && ./venv-$${NAME}/bin/pip uninstall --yes $${NAME}
	. ./meta.sh >/dev/null && ./venv-$${NAME}/bin/pip install --upgrade \
		`printf $${BUILD_REQUIRES} | tr , ' ' | tr --delete '"'`
	rm -rf dist-testpypi
	mkdir  dist-testpypi
	. ./meta.sh >/dev/null && ./venv-$${NAME}/bin/pip download \
		--no-deps \
		--no-build-isolation \
		--no-cache-dir \
		--index-url https://test.pypi.org/simple/ \
		--dest ./dist-testpypi \
		$${NAME}
	. ./meta.sh >/dev/null && ./venv-$${NAME}/bin/pip install \
		--no-cache-dir \
		./dist-testpypi/`printf $${NAME} | tr .- _`-$${VERSION}.tar.gz
	rm -rf dist-testpypi
	. ./meta.sh >/dev/null && ./venv-$${NAME}/bin/python -m \
		`printf $${NAME} | tr - _`
	. ./meta.sh >/dev/null && ./venv-$${NAME}/bin/python -m \
		`printf $${NAME} | tr - _` --version

test-realpypi:
	. ./meta.sh >/dev/null && python -m venv ./venv-$${NAME}
	. ./meta.sh >/dev/null && ./venv-$${NAME}/bin/pip install --upgrade \
		$(PIP_REQ_SPEC)
	. ./meta.sh >/dev/null && ./venv-$${NAME}/bin/pip uninstall --yes $${NAME}
	. ./meta.sh >/dev/null && ./venv-$${NAME}/bin/pip install \
		--no-cache-dir \
		$${NAME}
	. ./meta.sh >/dev/null && ./venv-$${NAME}/bin/python -m \
		`printf $${NAME} | tr - _`
	. ./meta.sh >/dev/null && ./venv-$${NAME}/bin/python -m \
		`printf $${NAME} | tr - _` --version



