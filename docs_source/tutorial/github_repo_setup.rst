GitHub repo setup
=================

Create a GitHub repository using
GitHub's web interface, naming the new repo ``my-project-name``.
Do not choose any of the options to automatically add a readme,
.gitignore, or license file when creating the repo.

In the ``my-project-name`` directory, which should still be the current
working directory, remove the existing git repo, and then create a new one
as follows.

.. code-block:: sh

    rm -rf .git
    git init
    git add --all
    git commit --message "initial commit"

Now set the new GitHub repo as the remote/origin of the local repo that you created,
and push your initial commit.

.. code-block:: sh

    git remote add origin git@github.com:my-github-username/my-project-name.git
    git push --set-upstream origin master

In a web browser navigate to

.. code-block::

    https://github.com/my-github-username/my-project-name

to see GitHub's web interface to your repo with the initial files
now uploaded.


