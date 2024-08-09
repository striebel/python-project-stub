Download the package from the real PyPI, install, and run
=========================================================

Using the Makefile
------------------

The package can be downloaded from the test PyPI, installed,
and run by executing

.. code-block:: sh

   make test-realpypi

Or, the remainder of this page gives a step-by-step breakdown of
what actions are performed when the above make command is
executed.


Using step-by-step commands
---------------------------

Confirm that the package is not currently installed in your virtual environment:

.. code-block:: sh

    venv-my-project-name/bin/python -m my_project_name

should produce a module-not-found error. And

.. code-block:: sh

    venv-my-project-name/bin/pip show my-project-name

should report that the package is not installed.
If the package is installed, run

.. code-block:: sh

    venv-my-project-name/bin/pip uninstall --yes my-project-name

Now test that the package can be installed from the real PyPI:

.. code-block:: sh

    venv-my-project-name/bin/pip install \
        --no-cache-dir \
        my-project-name

Confirm that the install worked by executing

.. code-block:: sh

    venv-my-project-name/bin/python -m my_project_name

And also try

.. code-block:: sh

    venv-my-project-name/bin/pip show my-project-name


