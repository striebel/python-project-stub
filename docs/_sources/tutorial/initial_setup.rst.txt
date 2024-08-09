Initial setup
=============

First, choose a project name, such as ``my-project-name``.
Confirm that the name is available by visiting both

* `https://test.pypi.org/project/my-project-name
  <https://test.pypi.org/project/my-project-name>`_
* `https://pypi.org/project/my-project-name
  <https://pypi.org/project/my-project-name>`_

If these pages both display a 404 error, then the name hasn't been taken.
It may also be worthwhile to
try searching for ``my-project-name`` from the search bar on the homepages
of both the test Python Package Index and the real PyPI, because,
if there is another project with a name that is only a character or two
different from the chosen name, the chosen name may still be rejected,
when attempting to upload the package.

Next, clone the ``python-project-stub`` repository, renaming it to
``my-project-name``, by typing the following at a Linux shell.

.. code-block:: sh
   
   git clone git@github.com:striebel/python-project-stub.git my-project-name

Then, rename the project's root module based on the new name that was chosen;
while the convention is to use hyphens in the package name, Python does not
support hyphens in module names, so the convention is to replace them with underscores.
Thus, for example, execute the following commands.

.. code-block:: sh

   cd my-project-name
   mv python_project_stub my_project_name


Update package metadata
-----------------------

Next, update the package metadata.
First, create a symbolic link in the repository's root that points to the
metadata configuration script.

.. code-block:: sh

   cd ..
   ln -s ./my_project_name/meta.sh ./meta.sh

This sym link is required by the Makefile.
Now, open ``meta.sh`` and update the metadata fields as needed.

With the metadata updated and with
``my-project-name`` still as the working dir, now execute

.. code-block:: sh

    python -m my_project_name

The expected output is

.. code-block:: c
    
    /* Kernighan and Ritchie (1978, p. 6) */
    main()
    {
        printf("hello, world\n");
    }

which is just intended to show that the stub main function can
be executed.


Install editable
----------------

To install the project in editable mode, execute

.. code-block:: sh

    make install-editable

Then activate the virtual environment, and cd out of the project directory.

.. code-block:: sh

    . venv-my-project-name/bin/activate
    cd

Then execute

.. code-block:: sh

    python -m my_project_name
    my_project_name

Both of these should produce the same output as when 
the module was executed directly, before the package was installed.

