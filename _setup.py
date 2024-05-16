#!/usr/bin/env python
#
# Script to generate pyproject.toml and setup.cfg files
#
#
import sys
import os
import textwrap


def main():

    pipefd = os.pipe()

    pid = os.fork()

    if 0 == pid:

        os.close(pipefd[0])

        os.dup2(pipefd[1], 1)

        os.close(pipefd[1])

        argv = ['./meta.sh']

        os.execve(argv[0], argv, os.environ)

        assert False, 'os.execve(...) returned, which is unexpected'

    assert 0 < pid

    os.close(pipefd[1])

    wait_pid, retcode_raw = os.wait()

    assert wait_pid == pid

    retcode = retcode_raw >> 8

    assert 0 == retcode

    meta_bytes = b''
    while True:
        byte = os.read(pipefd[0], 1)
        if 1 == len(byte):
            meta_bytes += byte
        else:
            assert 0 == len(byte)
            break

    meta_str = meta_bytes.decode('utf-8')

    exec(meta_str)

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
            dependencies = [] # TODO
            readme = "README.md"

        [project.scripts]
            {package_module_import_name} = "{package_module_import_path}.__main__:main"

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

    return 0


if '__main__' == __name__:
    sys.exit(main())


