Build the package
=================

Using the Makefile
------------------

To build the package, execute

.. code-block:: sh

    make build-package

The built package will then appear as

.. code-block::

    ./dist/my-project-name-x.y.z.tar.gz

This package can then be installed and tested by running

.. code-block:: sh

    make test-local


Using step-by-step commands
---------------------------

Instead of using the Makefile, the package can also be built using
step-by-step commands:

First create a Python virtual environment in your local repo dir
(if the venv already exists, the following command will have no effect).

.. code-block:: sh

    python -m venv venv-my-project-name

You do not want the virtual environment created on any given machine
to be added under git source control, so ensure that
in your repo's root dir there is a ``.gitignore`` file that contains the
line

.. code-block::

    venv*/

If it was necessary to create or modify the file, commit and push the changes.

.. code-block:: sh

    git add .gitignore
    git commit -m 'added .gitignore file'
    git push origin

Next activate the newly created Python virtual environment.

.. code-block:: sh

    . venv-my-project-name/bin/activate

Execute the following sequence of commands to build the package

.. code-block:: sh

    pip install --upgrade pip
    pip install --upgrade build
    . meta.sh >/dev/null && ./_setup.py
    python -m build --sdist .

Confirm that the package file was generated.

.. code-block::

    ./dist/my-project-name-x.y.z.tar.gz

