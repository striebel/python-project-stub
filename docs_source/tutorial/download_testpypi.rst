Download the package from the test PyPI, install, and run
=========================================================

Using the Makefile
------------------

The package can be downloaded from the test PyPI, installed,
and run by executing

.. code-block:: sh

   make test-testpypi

Or, the remainder of this page gives a step-by-step breakdown of
what actions are performed when the above make command is
executed.


Uninstall the package and remove it from the cache
--------------------------------------------------

To confirm that the package was properly uploaded to testpypi, first
``cd`` out of the repo root into, say, your home directory.
Confirm that the package is not installed in the current
virtual environment by executing:

.. code-block:: sh

   python -m my_project_name

which should produce an error message saying there is no module of the name
``my_project_name``.

Also run

.. code-block:: sh

   pip show my-project-name

which should report that the package is not found.

If the package is found, then uninstall it:

.. code-block:: sh

   pip uninstall my-project-name

Then check if the package remains in the pip cache, which it likely will:

.. code-block:: sh

   pip cache list my_project_name

or

.. code-block:: sh

   pip cache list | grep -E 'my[-_]project[-_]name'

Then remove it from the cache:

.. code-block:: sh

   pip cache remove my_project_name


Download and install the package
--------------------------------

Now install the package from the test PyPI.
Clear documentation is not available that describes how to download and install
a package from testpypi while also downloading and installing all dependencies
exclusively from the regular PyPI.
For example, as of 2024-05-13,

* `https://packaging.python.org/en/latest/guides/using-testpypi/#using-testpypi-with-pip
  <https://packaging.python.org/en/latest/guides/using-testpypi/#using-testpypi-with-pip>`_

provides the following invocation of pip if "you also want to download packages
from [real] PyPI" when installing a package from test PyPI:

.. code-block:: sh

    venv-my-project-name/bin/pip install \
         --index-url https://test.pypi.org/simple/ \
         --extra-index-url https://pypi.org/simple/ \
         my-project-name

But it is not at all clear what the behavior of this pip invocation
will be when a package with the name of a dependency
is available on both the test PyPI and the regular PyPI.
(The help messages for ``--index-url`` and ``--extra-index-url`` also do not
clarify the issue.)

One solution is to ensure that the build dependencies are installed,
and then install the package from test PyPI without runtime dependencies
(``--no-deps``) and without using a separate build venv
(``--no-build-isolation``):

.. code-block:: sh

    venv-my-project-name/bin/pip install \
         --upgrade \
         'setuptools>=61.0.0'
    venv-my-project-name/bin/pip install \
         --no-deps \
         --no-build-isolation \
         --no-cache-dir \
         --index-url https://test.pypi.org/simple/ \
         my-project-name

But if there actually are runtime dependencies of ``my-project-name``,
then the above installation method will leave them unsatisfied.
This can be confirmed by running

.. code-block:: sh

    venv-my-project-name/bin/pip check

The solution is to download the package from the test PyPI,
and then install the package archive from its position in a local
directory.
This has the effect of only installing the target package from test PyPI,
while downloading and installing all dependencies from the regular PyPI.

.. code-block:: sh

    venv-my-project-name/bin/pip uninstall \
        --yes \
        my-package-name
    venv-my-project-name/bin/pip cache remove \
        my_project_name
    venv-my-project-name/bin/pip install \
        --upgrade \
        'setuptools>=61.0.0'
    mkdir -p dist-testpypi
    venv-my-project-name/bin/python -m pip download \
        --no-deps \
        --no-build-isolation \
        --no-cache-dir \
        --index-url https://test.pypi.org/simple/ \
        --dest ./dist-testpypi
        my-package-name

Now install the package, downloading the dependencies from
the regular PyPI by default, by running:

.. code-block:: sh

    venv-my-project-name/bin/pip install \
        ./my_package_name-x.y.z+1.tar.gz

Then try executing

.. code-block:: sh

    venv-my-project-name/bin/python -m my_package_name
    venv-my-project-name/bin/my_package_name

They should both produce

.. code-block:: c

    /* Kernighan and Ritchie (1978, p. 6) */
    main()
    {
        printf("hello, world\n");
    }

Also try running

.. code-block:: sh

    my_package_name --version

which should produce

.. code-block:: sh

    my-package-name x.y.z+1



