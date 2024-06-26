# `python-project-stub`

<a href="https://pypi.org/project/python-project-stub/">
    <img alt="PyPI" src="https://img.shields.io/pypi/v/python-project-stub">
</a>
<a href="https://pepy.tech/project/python-project-stub">
    <img alt="Downloads" src="https://static.pepy.tech/badge/python-project-stub">
</a>
<a href="https://github.com/striebel/python-project-stub/blob/master/LICENSE">
    <img alt="License" src="https://img.shields.io/github/license/striebel/python-project-stub">
</a>
<br/><br/>
<p>
    This repository contains stub files that can be used to create a Python project
    that is able to be packaged and uploaded to the
    <a href="https://pypi.org">Python Package Index</a>
    and hence can be conveniently installed with `pip install my-project-name`.
</p>

<p>
    This README describes how to modify the stub files, using them as the base of
    a new Python project.
    Requirements are a recent installation of Python 3 on Linux.
</p>

## Contents

* <a href='#outstanding-issues'>Outstanding issues</a>

* <a href='#choose-a-project-name'>Choose a project name</a>

* <a href='#update-package-metadata'>Update package metadata</a>

* <a href='#create-a-github-repo'>Create a GitHub repo</a>

* <a href='#build-the-package'>Build the package</a>

* <a href='#upload-the-package-to-pypi-test'>Upload the package to PyPI test</a>

* <a href='#upload-the-package-to-the-real-pypi'>Upload the package to the real PyPI</a>

* <a href='#bibliography'>Links</a>

<h2 id='outstanding-issues'>Outstanding issues</h2>

* When building a project named, e.g., `python.project.stub`,
  how can one get a dist file named
  - `python.project.stub-x.y.z.tar.gz`
  -  and not `python_project_stub-x.y.z.targ.gz`?

<h2 id='choose-a-project-name'>Choose a project name</h2>

First, clone this repository by typing the following at a Linux shell
```sh
git clone git@github.com:striebel/python-project-stub.git
```

This creates the directory `python-project-stub` in the current
working directory.
Rename this directory to the name of your project with
```sh
mv python-project-stub my-project-name
```

Before choosing a project name, check if the name has been taken
yet by visiting
```
https://pypi.org/project/my-project-name
```

If you get a 404 error, then your desired name hasn't been taken.
Also search your project name from the PyPI search bar on the
[homepage](https://pypi.org),
because if there is another project with a name that is only a character or two
different from your desired name, your name will likely be rejected
when you try to upload your package.

After you choose a project name,
`cd` into the repo root dir and remove the existing git repo itself,
since you will subsequently create a brand new repo for your project:
```sh
cd my-project-name
rm -rf .git
```

And, next, rename the project's root module based on the new name that you chose;
while the convention is to use hyphens in the project/package name, Python does not
permit hyphens in module names, so the convention is to replace them with
underscores; thus, for example, execute:
```
mv python_project_stub my_project_name
```

<h2 id='update-package-metadata'>Update package metadata</h2>

There are several locations where metadata needs to be updated in the
stub files.

First, update `pyproject.toml`; open the file in a text editor,
and, under the `[project]` heading, update the following fields:

* `name = "python-project-stub  --->  name = "my-project-name"`
* `version = "x.y.z"  --->  version = "0.0.1"`
* `license` (if you prefer/need to use a different license)

Also, under `[project.scripts]`, change
```
python_project_stub = "python_project_stub.__main__:main"
```
to
```
my_project_name = "my_project_name.__main__:main"
```

And update all fields under `[project.urls]`.

After saving `pyproject.toml` with these changes, next open
`setup.cfg`.
All fields in this file should need to be updated.

Then, open `my_project_name/__init__.py` and update the
metadata variables in this file.

Finally, update the variable(s) in the `makefile`.

With the metadata updated and with
`my-project-name` still as the working dir, now execute
```sh
python -m my_project_name
```

The expected output is
```
/* Kernighan and Ritchie (1978, p. 6) */
main()
{
    printf("hello, world\n");
}
```
which is just intended to show that the stub main function can
be executed.

<h2 id='create-a-github-repo'>Create a GitHub repo</h2>

Create a GitHub repository corresponding to your new Python project using
GitHub's web interface, and name the new repo `my-project-name`.
In order to use the rest of the instructions below, do not choose any
of the options to automatically add a README,
.gitignore, or license file when creating the repo
(these are already present locally).

Now, either rename the existing `README.md` file so that you can continue
to read it locally, or just continue to read it in a web browser at
<a href="https://github.com/striebel/python-project-stub">
    https://github.com/striebel/python-project-stub
</a>
(if that's what you have been doing),
because the next step will intentionally replace the current README file.

In the `my-project-name` directory, which should still be the current
working directory, execute
```sh
git init
echo '# `my-project-name`' > README.md
git add --all
git commit --message "initial commit"
```

Now set the new GitHub repo as the remote/origin of the local repo that you created,
and push your initial commit:
```sh
git remote add origin git@github.com:my-github-username/my-project-name.git
git push --set-upstream origin master
```

In a web browser navigate to
```
https://github.com/my-github-username/my-project-name
```
to see GitHub's web interface to your repo with the initial files
now uploaded.

<h2 id='build-the-package'>Build the package</h2>

First create a Python virtual environment in your local repo dir
```sh
python -m venv venv-my-project-name
```

You do not want the virtual environment created on any given machine
to be added under git source control,
so in your repo's root dir, create a file named `.gitignore`,
and add the line
```
venv*/
```
to the file. Then push this file to the remote repo:
```sh
git add .gitignore
git commit -m 'added .gitignore file'
git push origin
```

Next activate the newly created Python virtual environment:
```sh
. venv-my-project-name/bin/activate
```

Execute the following sequence of commands to build the package
```sh
pip install --upgrade pip
pip install --upgrade build
python -m build --sdist .
```

Alternatively, the package can be built by executing:
```sh
make build
```

Confirm that the package file
`dist/my-project-name-x.y.z.tar.gz` was generated:
```sh
$ ls -l dist
```

<h2 id='upload-the-package-to-pypi-test'>Upload the package to PyPI test</h2>

### Create/register the test Python package-index entry

First visit
<a href="https://test.pypi.org">
    https://test.pypi.org
</a>
and create an account.

Next create a PyPI Test API token here: <br/>
<a href="https://test.pypi.org/manage/account/#api-tokens">
    https://test.pypi.org/manage/account/#api-tokens
</a>.<br/>
Name the token something like `tmp-universal-token` and set the token scope to
`Entire account (all projects)`.

Since this is a pure Python package, upload only the source package
(`dist/my-project-name-x.y.z.tar.gz`) -
no need to upload the pre-built binary "wheel"
(`dist/my-project-name-0.0.0-py3-none-any.whl`):
```sh
pip install --upgrade 'twine>=5.0.0,<6.0.0'
python -m twine upload --repository-url https://test.pypi.org/legacy/ dist/my-project-name-x.y.z.tar.gz
```
For username enter `__token__` and for the password enter the token value
including the `pypi-` prefix.

The `twine register` command is not supported by PyPI, so the `twine upload` command
invocation described above is the only option to create a new package-index entry.

### Set up `~/.pypirc` with `my-package-name`-specific token

Now that the new package-index entry has been created,
an authentication token specific to the entry can be created
and added to a local config file so that credentials don't need to
be manually entered every time a new version of the package is uploaded.

First, delete the token created above (e.g., named `tmp-universal-token`).
To do this, navigate to: <br/>
<a href="https://test.pypi.org/manage/account/#api-tokens">
    https://test.pypi.org/manage/account/#api-tokens
</a> <br/>
Then create the entry-specific token with permission only to upload to
`my-project-name`.

With this token in hand, create the PyPI run conditions file: `~/.pypirc`,
and set its access permissions to private:
```sh
chmod 600 ~/.pypirc # r+w for the user only
```
Then write the following contents to the file:
```
# https://packaging.python.org/en/latest/specifications/pypirc/

[distutils]
    index-servers =
        testpypi-my-project-name
        pypi-my-project-name

[testpypi-my-project-name]
    repository = https://test.pypi.org/legacy/
    username = __token__
    password = <testpypi_token_goes_here>

[pypi-my-project-name]
    repository = https://upload.pypi.org/legacy/
    username = __token__
    password = <pypi_token_goes_here>

```
and replace `<testpypi_token_goes_here>` with the created token that
starts with `pypi- ...`.
The `<pypi_token_goes_here` field can be filled in later.

Now open `pyproject.toml` and increment the version `x.y.z` to `x.y.z+1`.

Next remove the sdist (source distribution) package with `rm -rf dist`,
and then rebuild the package with the updated version number by running
`make build`.

Then upload by running:
```sh
python -m twine upload \
    --repository testpypi-my-project-name \
    dist/my-project-name-x.y.z+1.tar.gz
```
This is also implemented in the makefile and can be run with:
```sh
make upload-testpypi
```

### Download and install the package

To confirm that the package was properly uploaded to testpypi, first
`cd` out of the repo root into, say, your home directory.
Confirm that the package is not installed in the current
virtual environment by executing:
```sh
python -m my_project_name
```
which should produce an error message saying there is no module of the name
`my_project_name`.

Also run
```sh
pip show my-project-name
```
which should report that the package is not found.

If the package is found, then uninstall it:
```sh
pip uninstall my-project-name
```

Then check if the package remains in the pip cache, which it likely will:
```sh
pip cache list my_project_name
```
or
```sh
pip cache list | grep -E 'my[-_]project[-_]name'
```

Then remove it from the cache:
```sh
pip cache remove my_project_name
```

Now install the package from the test PyPI.
Clear documentation is not available that describes how to download and install
a package from testpypi while also downloading and installing all dependencies
exclusively from the regular pypi.
For example, as of 2024-05-13, <br/>
<a href="https://packaging.python.org/en/latest/guides/using-testpypi/#using-testpypi-with-pip">
    https://packaging.python.org/en/latest/guides/using-testpypi/#using-testpypi-with-pip
</a> <br/>
provides the following invocation of pip if "you also want to download packages
from PyPI [when installing a package from testpypi]":
```sh
pip install \
>     --index-url https://test.pypi.org/simple/ \
>     --extra-index-url https://pypi.org/simple/ \
>     my-project-name
```
but it is not at all clear what the behavior of this pip invocation
will be when a package with the name of a dependency
is available on both testpypi and regular pypi.
(The help messages for `--index-url` and `--extra-index-url` do not
clarify this issue.)

Thus to ensure the desired behavior of downloading all dependencies from the
regular pypi, first download the package from testpyi without installing it:
```sh
mkdir tmp && cd tmp
python -m pip download \
    --no-deps \
    --index-url https://test.pypi.org/simple/ \
    --extra-index-url https://pypi.org/simple/ \
    my-package-name
```
The `--extra-index-url https://pypi.org/simple/` argument is required
because the build-system setuptools needs to be downloaded from the regular pypi.
Executing this command will place a file named something like
`my_package_name-x.y.z+1.tar.gz` in the current dir.

Now install the package, downloading the dependencies from the regular pypi by default,
by running:
```sh
pip install ./my_package_name-x.y.z+1.tar.gz
```

Then try executing both
```sh
python -m my_package_name
```
and the console script
```sh
my_package_name
```
They should both produce:
```
/* Kernighan and Ritchie (1978, p. 6) */
main()
{
    printf("hello, world\n");
}
```

Also try running:
```sh
my_package_name --version
```
which should produce
```
my-package-name x.y.z+1
```


<h2 id='upload-the-package-to-the-real-pypi'>Upload the package to the real PyPI</h2>

### Create/register the regular Python package-index entry

First visit
<a href="https://pypi.org">
    https://pypi.org
</a>
and create an account.

Next create a PyPI API token here: <br/>
<a href="https://pypi.org/manage/account/#api-tokens">
    https://pypi.org/manage/account/#api-tokens
</a>.<br/>
Name the token something like `tmp-universal-token` and set the token scope to
`Entire account (all projects)`.

Since this is a pure Python package, upload only the source package
(`dist/my-project-name-x.y.z.tar.gz`) -
no need to upload the pre-built binary "wheel"
(`dist/my-project-name-0.0.0-py3-none-any.whl`):
```sh
pip install --upgrade 'twine>=5.0.0,<6.0.0'
python -m twine upload --repository-url https://upload.pypi.org/legacy/ dist/my-project-name-x.y.z+1.tar.gz
```
For username enter `__token__` and for the password enter the token value
including the `pypi-` prefix.

The `twine register` command is not supported by PyPI, so the `twine upload` command
invocation described above is the only option to create a new package-index entry.

### Set up `~/.pypirc` with `my-package-name`-specific token

Now that the new package-index entry has been created,
an authentication token specific to the entry can be created
and added to a local config file so that credentials don't need to
be manually entered every time a new version of the package is uploaded.

First, delete the token created above (e.g., named `tmp-universal-token`).
To do this, navigate to: <br/>
<a href="https://test.pypi.org/manage/account/#api-tokens">
    https://test.pypi.org/manage/account/#api-tokens
</a>.<br/>
Then create the entry-specific token with permission only to upload to
`my-project-name`.

Now add this token to the PyPI run conditions file (`~/.pypirc`)
which have should have already been created.
Confirm that access permissions for `~/.pypirc` is set to private,
and set it if it is not already:
```sh
chmod 600 ~/.pypirc # r+w for the user only
```

The file should already contain the following:
```
# https://packaging.python.org/en/latest/specifications/pypirc/

[distutils]
    index-servers =
        testpypi-my-project-name
        pypi-my-project-name

[testpypi-my-project-name]
    repository = https://test.pypi.org/legacy/
    username = __token__
    password = <testpypi_token_goes_here>

[pypi-my-project-name]
    repository = https://upload.pypi.org/legacy/
    username = __token__
    password = <pypi_token_goes_here>
```
and the field `<testpypi_token_goes_here>` should already be filled in.
Now fill in the only remaining empty field of `<pypi_token_goes_here>`
with the just-created token that starts with `pypi- ...`.

Now open `pyproject.toml` and increment the version `x.y.z+1` to `x.y.z+2`.

Next remove the sdist (source distribution) package with `rm -rf dist`,
and then rebuild the package with the updated version number by running
`make build`.

Then upload by running:
```sh
python -m twine upload \
    --repository pypi-my-project-name \
    dist/my-project-name-x.y.z+2.tar.gz
```
This is also implemented in the makefile and can be run with:
```sh
make upload
```

### Download and install the package

Confirm that the package is not currently installed in your virtual environment:
```sh
python -m my_project_name
```
should produce a module-not-found error. And
```sh
pip show my-project-name
```
should report that the package is not installed.

Now test that the package can be installed from the real PyPI using `pip`:
```sh
pip install --no-cache-dir my-project-name
```

Confirm that the install worked by executing
```sh
python -m my_project_name
```
and test the console script with
```sh
my_project_name
```
And confirm that the version number is as expected with
```sh
my_project_name --version
```

<h2 id='bibliography'>Links</h2>

* [Python packaging user guide](https://packaging.python.org/en/latest/)
  - [Packaging python projects tutorial](
        https://packaging.python.org/en/latest/tutorials/packaging-projects/
    )


