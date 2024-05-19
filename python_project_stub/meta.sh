#!/usr/bin/env sh


export VERSION=0.0.11

export NAME=python-project-stub

DESCRIPTION='Stub files to use as the basis of a Python project that'
export DESCRIPTION="${DESCRIPTION} can be packaged and uploaded to PyPI"

export GITHUB_USER='striebel'

export AUTHOR='Jacob Striebel'
export AUTHOR_EMAIL='jacob.striebel@example.com'

export REQUIRES=''
# export REQUIRES=${REQUIRES}'"allennlp==1.3.0"'
# export REQUIRES=${REQUIRES}',"transformers==4.0.0"'
# export REQUIRES=${REQUIRES}',"torch==1.7.1"'
# export REQUIRES=${REQUIRES}',"jsonnet==0.20.0"'

export DATA_FILE_PATH_SUFFIXES='meta.sh:data/quote.txt' # When more needed, separate with colon (:)


# logging level str options:
#
#     CRITICAL, ERROR, WARNING, INFO, DEBUG
#
export DEFAULT_LOGGING_LEVEL_STR='DEBUG'


# # # # # # # # # # # # # # # # # # # # # # # # # #
#                                                 #
#  Do not modify statements in the section below  #
#                                                 #
# # # # # # # # # # # # # # # # # # # # # # # # # #

printf 'global VERSION                  \n'
printf 'global NAME                     \n'
printf 'global DESCRIPTION              \n'
printf 'global GITHUB_USER              \n'
printf 'global AUTHOR                   \n'
printf 'global AUTHOR_EMAIL             \n'
printf 'global REQUIRES                 \n'
printf 'global DATA_FILE_PATH_SUFFIXES  \n'
printf 'global DEFAULT_LOGGING_LEVEL_STR\n'

printf 'VERSION                   = "%s"\n' "$VERSION"
printf 'NAME                      = "%s"\n' "$NAME"
printf 'DESCRIPTION               = "%s"\n' "$DESCRIPTION"
printf 'GITHUB_USER               = "%s"\n' "$GITHUB_USER"
printf 'AUTHOR                    = "%s"\n' "$AUTHOR"
printf 'AUTHOR_EMAIL              = "%s"\n' "$AUTHOR_EMAIL"
printf "REQUIRES                  = '%s'\n" "$REQUIRES"
printf 'DATA_FILE_PATH_SUFFIXES   = "%s"\n' "$DATA_FILE_PATH_SUFFIXES"
printf 'DEFAULT_LOGGING_LEVEL_STR = "%s"\n' "$DEFAULT_LOGGING_LEVEL_STR"

