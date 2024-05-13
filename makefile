PACKAGE_NAME = python-project-stub

build:
	python -m venv venv-${PACKAGE_NAME}
	venv-${PACKAGE_NAME}/bin/pip install --upgrade pip
	venv-${PACKAGE_NAME}/bin/pip install --upgrade build
	venv-${PACKAGE_NAME}/bin/python -m build --sdist .

upload-test:
	python -m venv venv-${PACKAGE_NAME}
	venv-${PACKAGE_NAME}/bin/pip install --upgrade pip
	venv-${PACKAGE_NAME}/bin/pip install --upgrade 'twine>=5.0.0,<6.0.0'
	venv-${PACKAGE_NAME}/bin/python -m twine upload --repository testpypi dist/$$(ls dist)

