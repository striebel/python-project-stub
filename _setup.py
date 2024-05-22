#!/usr/bin/env python
#
# This script is used to generate
#     * pyproject.toml
#     * setup.cfg
#     * MANIFEST.in
#
#
import sys
import os
import textwrap


def main():

    VERSION                   = os.environ['VERSION'                  ] 
    NAME                      = os.environ['NAME'                     ] 
    DESCRIPTION               = os.environ['DESCRIPTION'              ]  
    GITHUB_USER               = os.environ['GITHUB_USER'              ] 
    AUTHOR                    = os.environ['AUTHOR'                   ] 
    AUTHOR_EMAIL              = os.environ['AUTHOR_EMAIL'             ] 
    REQUIRES                  = os.environ['REQUIRES'                 ] 
    INCLUDE_FILES             = os.environ['INCLUDE_FILES'            ]
    DEFAULT_LOGGING_LEVEL_STR = os.environ['DEFAULT_LOGGING_LEVEL_STR']


    package_module_import_path = NAME.replace('-', '_')

    first_dot_index = package_module_import_path.find('.')

    if first_dot_index < 0:
        assert -1 == first_dot_index
        root_module_import_name = package_module_import_path
    elif 0 == first_dot_index:
        assert False, f'NAME cannot begin with a dot: {NAME}'
    else:
        assert 0 < first_dot_index
        root_module_import_name = package_module_import_path[:first_dot_index]

    last_dot_index = package_module_import_path.rfind('.')

    if last_dot_index < 0:
        assert -1 == last_dot_index
        package_module_import_name = package_module_import_path
    elif 0 == last_dot_index:
        assert False, f'NAME cannot begin with a dot: {NAME}'
    else:
        assert 0 < last_dot_index
        package_module_import_name = package_module_import_path[last_dot_index+1:]


    package_module_dir_path = package_module_import_path.replace('.', '/')

    assert os.path.isdir(os.path.join('.', package_module_dir_path)), \
        f'package_module_dir_path : {package_module_dir_path}'


    pyproject_toml_str = textwrap.dedent(
        f'''\
        [build-system]
            requires      = ["setuptools>=61.0.0"]
            build-backend = "setuptools.build_meta"

        [project]
            name         = "{NAME}"
            version      = "{VERSION}"
            dynamic      = ["authors"] # specified in setup.cfg
            description  = "{DESCRIPTION}"
            license      = {{text = "MIT"}}
            dependencies = [{REQUIRES}]
            readme       = "README.md"

        [project.scripts]
            "{package_module_import_path}" = "{package_module_import_path}.__main__:main"

        [project.urls]
            "Homepage" = "https://github.com/{GITHUB_USER}/{NAME}"
        '''
    )

    with open('./pyproject.toml', 'w') as pyproject_toml_file:
        pyproject_toml_file.write(pyproject_toml_str)


    setup_cfg_str = textwrap.dedent(
        f'''\
        [metadata]
            # This "url" field will be used as the "Home-page" field when
            #     "pip show <package>" is executed.
            #     There appears to be no way to set "Home-page" in pyproject.toml
            url = https://github.com/{GITHUB_USER}/{NAME}

            # Providing author and email in this file also fills in the
            #     fields more properly that are displayed with "pip show <package>"
            author       = {AUTHOR}
            author_email = {AUTHOR_EMAIL}
        '''
    )

    with open('./setup.cfg', 'w') as setup_cfg_file:
        setup_cfg_file.write(setup_cfg_str)


    manifest_in_str = ''

    for data_file_path_suffix in INCLUDE_FILES.split(':'):

        data_file_path = os.path.join(
            package_module_dir_path,
            data_file_path_suffix
        )

        assert os.path.isfile(os.path.join('.', data_file_path))

        manifest_in_str += f'include {data_file_path}\n'

    with open('./MANIFEST.in', 'w') as manifest_in_file:
        manifest_in_file.write(manifest_in_str)


    return 33



if '__main__' == __name__:
    sys.exit(main())


END_OF_FILE
