Upload the package to test PyPI
===============================

Create/register the test Python package-index entry
---------------------------------------------------

First visit
`https://test.pypi.org <https://test.pypi.org>`_
and create an account.

Next create a PyPI Test API token here:

* `https://test.pypi.org/manage/account/#api-tokens
  <https://test.pypi.org/manage/account/#api-tokens>`_

Name the token something like ``machine-make-and-model``
and set the token scope to
``Entire account (all projects)``.

Since this is a pure Python package, upload only the source package

* ``dist/my-project-name-x.y.z.tar.gz``

There is no need to upload the pre-built binary "wheel"

* ``dist/my-project-name-x.y.z-py3-none-any.whl``

The upload can be performed by executing

.. code-block:: sh

    venv-my-project-name/bin/pip install \
        --upgrade 'twine>=5.0.0,<6.0.0'
    venv-my-project-name/bin/python -m twine upload \
        --repository-url https://test.pypi.org/legacy/ \
        ./dist/my-project-name-x.y.z.tar.gz

When prompted for a username, enter ``__token__``,
and for the password enter the token value,
including the ``pypi-`` prefix.

The ``twine register`` command is not supported by PyPI, so the ``twine upload`` command
invocation described above is the only option to create a new package-index entry.


Set up ``~/.pypirc`` 
--------------------

Instead of interactively pasting the token at a prompt each time a new
package needs to be uploaded, it can be saved to a PyPI run conditions file.
By using this approach that requires no interactive input, upload can be
performed using a ``make`` command.

Therefore, now create a PyPI run conditions file (``~/.pypirc``) in your
home directory, and set its access permissions to private:

.. code-block:: sh

    chmod 600 ~/.pypirc # r+w for the user only

Then write the following contents to the file.

.. code-block::

    # https://packaging.python.org/en/latest/specifications/pypirc/
    
    [distutils]
        index-servers =
            pypirc-testpypi
            pypirc-realpypi
    
    [pypirc-testpypi]
        repository = https://test.pypi.org/legacy/
        username = __token__
        password = <testpypi_token_goes_here>
    
    [pypirc-realpypi]
        repository = https://upload.pypi.org/legacy/
        username = __token__
        password = <realpypi_token_goes_here>

Replace ``<testpypi_token_goes_here>`` with the created token that
starts with ``pypi-``.
The ``<realpypi_token_goes_here>`` field can be filled in later.

Now open ``meta.sh`` and increment the version ``x.y.z`` to ``x.y.z+1``.

Then rebuild the package with the updated version number by running
``make build-package``.

Then upload by running

.. code-block:: sh

    venv-my-project-name/bin/python -m twine upload \
        --repository pypirc-testpypi \
        dist/my-project-name-x.y.z+1.tar.gz

This is also implemented in the Makefile and can be run with

.. code-block:: sh

    make upload-realpypi


