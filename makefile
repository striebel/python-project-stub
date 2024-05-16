build:
	. ./meta.sh >/dev/null && python -m venv ./venv-$${NAME}
	. ./meta.sh >/dev/null && ./venv-$${NAME}/bin/pip install --upgrade \
		'pip>=21.0.1,<24.0.1'
	. ./meta.sh >/dev/null && ./venv-$${NAME}/bin/pip install --upgrade \
		'build>=1.2.1,<2.0.0'
	./_setup.py
	rm -rf ./dist
	rm -rf ./*.egg-info
	. ./meta.sh >/dev/null && ./venv-$${NAME}/bin/python -m build --sdist .
	rm ./pyproject.toml
	rm ./setup.cfg
	rm ./MANIFEST.in
	rm -rf ./*.egg-info

upload-testpypi:
	. ./meta.sh >/dev/null && python -m venv ./venv-$${NAME}
	. ./meta.sh >/dev/null && ./venv-$${NAME}/bin/pip install --upgrade \
		'pip>=21.0.1,<24.0.1'
	. ./meta.sh >/dev/null && ./venv-$${NAME}/bin/pip install --upgrade \
		'twine>=5.0.0,<6.0.0'
	. ./meta.sh >/dev/null && ./venv-$${NAME}/bin/python -m twine upload \
        	--repository testpypi-$${NAME} \
		dist/`printf $${NAME} | tr - _`-$${VERSION}.tar.gz

upload:
	. ./meta.sh >/dev/null && python -m venv ./venv-$${NAME}
	. ./meta.sh >/dev/null && ./venv-$${NAME}/bin/pip install --upgrade \
		'pip>=21.0.1,<24.0.1'
	. ./meta.sh >/dev/null && ./venv-$${NAME}/bin/pip install --upgrade \
		'twine>=5.0.0,<6.0.0'
	. ./meta.sh >/dev/null && ./venv-$${NAME}/bin/python -m twine upload \
        	--repository pypi-$${NAME} \
		dist/`printf $${NAME} | tr - _`-$${VERSION}.tar.gz
