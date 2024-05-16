#!/usr/bin/env sh


export VERSION=0.0.6

export NAME=python-project-stub

DESCRIPTION='Stub files to use as the basis of a Python project that'
export DESCRIPTION="${DESCRIPTION} can be packaged and uploaded to PyPI"


export AUTHOR='Jacob Striebel'
export AUTHOR_EMAIL='jacob.striebel@example.com'


# https://stackoverflow.com/a/1463370

printf 'global VERSION         ; VERSION          = "'"${VERSION}"'"     \n'
printf 'global NAME            ; NAME             = "'"${NAME}"'"        \n'
printf 'global DESCRIPTION     ; DESCRIPTION      = "'"${DESCRIPTION}"'" \n'
printf 'global AUTHOR          ; AUTHOR           = "'"${AUTHOR}"'"      \n'
printf 'global AUTHOR_EMAIL    ; AUTHOR_EMAIL     = "'"${AUTHOR_EMAIL}"'"\n'

