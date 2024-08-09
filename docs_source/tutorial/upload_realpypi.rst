Upload the package to the real PyPI
===================================

Create/register the real Python package-index entry
---------------------------------------------------

First visit
`https://pypi.org <https://pypi.org>`_
and create an account.

Next create a PyPI API token here:

* `https://pypi.org/manage/account/#api-tokens
  <https://pypi.org/manage/account/#api-tokens>`_

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
        --repository-url https://upload.pypi.org/legacy/ \
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

A PyPI run conditions file (``~/.pypirc``) should have already been created
when the package was uploaded to the test PyPI.
Make sure the ``.pypirc`` file has its access permissions set to private,
since it contains authentication tokens.

.. code-block:: sh

    chmod 600 ~/.pypirc # r+w for the user only

Confirm that the file has the following contents.

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

The test PyPI token (``<testpypi_token_goes_here>``) should already
be present.
But now the real PyPI token (``<realpypi_token_goes_here>``)
should be filled in.

Next, open ``meta.sh`` and increment the version ``x.y.z`` to ``x.y.z+1``.

Then rebuild the package with the updated version number by running
``make build-package``.

Then upload by running

.. code-block:: sh

    venv-my-project-name/bin/python -m twine upload \
        --repository pypirc-realpypi \
        dist/my-project-name-x.y.z+1.tar.gz

This is also implemented in the Makefile and can be run with

.. code-block:: sh

    make upload-testpypi



