# Reserve PYPI Package Name

This repo contains the stub code that is needed to create a Python package
and upload it to the Python Package Index for the purpose of reserving
a package name.

## Configure Package

First, clone this repository.
Then `cd` into the repo root dir and edit `pyproject.toml`:
change the project name from `reserve-pypi-package-name` to the name
of your project, for example `fst-extension`, and save the file.
Next rename the package directory to the appropriate project name.
For example, execute
```sh
mv reserve_pypi_package_name fst_extension
```

## Build Package

```sh
python -m venv myvenv
```
```sh
source activate myvenv/bin/activate
```
```sh
pip install --upgrade build
```
```sh
python -m build
```
```sh
ls -la dist
```

## Upload the Package to PYPI Test

```sh
pip install --upgrade twine
```

Create a PYPI Test API token [here](https://test.pypi.org/manage/account/#api-tokens)

Since this is a pure Python package, just upload the source package -
no need to upload the pre-built wheel:
```sh
python -m twine upload --repository testpypi dist/PACKAGE_NAME-0.0.0.tar.gz
```
For username enter `__token__` and for the password enter the token value
including the `pypi-` prefix.

To confirm that the package was properly uploaded, install it using the
command:
```sh
pip install --index-url https://test.pypi.org/simple/ --no-deps PACKAGE_NAME

```
`cd` out of the repo root into, say, `/tmp`.
Then execute
```sh
python -m PACKAGE_NAME
```
and the output should be
```
outside guard
inside guard
```
