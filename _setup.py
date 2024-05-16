import sys
import os

from setuptools import setup


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


    entry_points = {
        package_module_import_name : f'{package_module_import_path}.__main__:main'
    }


    # https://setuptools.pypa.io/en/latest/references/keywords.html

    setup(
        name             = NAME,
        version          = VERSION,
        # description      = DESCRIPTION,
        # long_description = None, # open and read the README.md
        # author           = AUTHOR,
        # author_email     = AUTHOR_EMAIL,
        # maintainer       = None,
        # maintainer_email = None,
        # url              = f'https://github.com/striebel/{NAME}',
        # download_url     = None,
        packages         = [root_module_import_name],
        # # ...
        # license          = 'MIT',
        # license_file     = None, # setuptools docs say: deprecated
        # license_files    = ['LICENSE'],
        # # ...
        # platforms        = ['Linux'],
        # data_files       = [], # setuptools docs say: use discouraged
        # # ...
        install_requires   = [], # packages that this package depends on
        # entry_points     = entry_points,
        # # ...
        setup_requires     = ['setuptools>=69.5.1', 'wheel>=0.43.0'], # latest as of 2024-05-16
        # ...
    )

    return 0


if '__main__' == __name__:
    sys.exit(main())


