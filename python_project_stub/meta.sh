#!/usr/bin/env sh


export VERSION=0.0.12

export NAME=python-project-stub

export DESCRIPTION=""
export DESCRIPTION="${DESCRIPTION}Stub files to use as the basis of a Python"
export DESCRIPTION="${DESCRIPTION} project that can be packaged and uploaded to PyPI"

export GITHUB_USER='striebel'

export AUTHOR='Jacob Striebel'
export AUTHOR_EMAIL='jacob.striebel@example.com'

export BUILD_REQUIRES=''
export BUILD_REQUIRES=${BUILD_REQUIRES}'"setuptools>=61.0.0"'

export REQUIRES=''
#export REQUIRES=${REQUIRES}'"allennlp==1.3.0"'
#export REQUIRES=${REQUIRES}',"transformers==4.0.0"'
#export REQUIRES=${REQUIRES}',"torch==1.7.1"'
#export REQUIRES=${REQUIRES}',"jsonnet==0.20.0"'



# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#                                                                           #
#  Most files other than Python source files must be explicitly specified   #
#  if it is desired that they be included in the built package              #
#                                                                           #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
export INCLUDE_FILES="meta.sh"
export INCLUDE_FILES="${INCLUDE_FILES}:data/quote.txt"



# logging level str options:
#
#     CRITICAL, ERROR, WARNING, INFO, DEBUG
#
export DEFAULT_LOGGING_LEVEL_STR='DEBUG'


# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#                                                                           #
#  The following statements print the the metadata variables defined above  #
#  in a format that can be easily understood by a Python program            #
#                                                                           #
#  Do not modify statements in the section below                            #
#                                                                           #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

printf 'global VERSION                  \n'
printf 'global NAME                     \n'
printf 'global DESCRIPTION              \n'
printf 'global GITHUB_USER              \n'
printf 'global AUTHOR                   \n'
printf 'global AUTHOR_EMAIL             \n'
printf 'global BUILD_REQUIRES           \n'
printf 'global REQUIRES                 \n'
printf 'global INCLUDE_FILES            \n'
printf 'global DEFAULT_LOGGING_LEVEL_STR\n'

printf 'VERSION                   = "%s"\n' "$VERSION"
printf 'NAME                      = "%s"\n' "$NAME"
printf 'DESCRIPTION               = "%s"\n' "$DESCRIPTION"
printf 'GITHUB_USER               = "%s"\n' "$GITHUB_USER"
printf 'AUTHOR                    = "%s"\n' "$AUTHOR"
printf 'AUTHOR_EMAIL              = "%s"\n' "$AUTHOR_EMAIL"
printf "BUILD_REQUIRES            = '%s'\n" "$BUILD_REQUIRES"
printf "REQUIRES                  = '%s'\n" "$REQUIRES"
printf 'INCLUDE_FILES             = "%s"\n' "$INCLUDE_FILES"
printf 'DEFAULT_LOGGING_LEVEL_STR = "%s"\n' "$DEFAULT_LOGGING_LEVEL_STR"


