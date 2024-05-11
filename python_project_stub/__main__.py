import sys
import os
import toml # This import should be replaced with "tomllib" once Python 3.11,
            #     which is the version when the "tomllib" module was introduced
            #     into the standard library, is more widely available
            #     (https://docs.python.org/3/library/tomllib.html).
import argparse
from textwrap import indent


PACKAGE_NAME     = 'python-project-stub'
ROOT_MODULE_NAME = 'python_project_stub'


def main():

    this_file_path = __file__

    assert '__main__.py' == os.path.basename(this_file_path)

    root_module_dir_path = os.path.dirname(this_file_path)

    assert ROOT_MODULE_NAME == os.path.basename(root_module_dir_path)

    package_root_dir_path = os.path.dirname(root_module_dir_path)

    assert PACKAGE_NAME == os.path.basename(package_root_dir_path)

    pyproject_toml_file_path = os.path.join(package_root_dir_path, 'pyproject.toml')

    assert os.path.isfile(pyproject_toml_file_path)

    with open(pyproject_toml_file_path, 'r') as pyproject_toml_file:

        pyproject_dict = toml.load(pyproject_toml_file)

    assert PACKAGE_NAME == pyproject_dict['project']['name']
    
    arg_parser = argparse.ArgumentParser(
        prog                  = ROOT_MODULE_NAME,
        description           = pyproject_dict['project']['description'],
        formatter_class       = argparse.ArgumentDefaultsHelpFormatter,
        fromfile_prefix_chars = '@'
    )
    
    arg_parser.add_argument(
        '-V', '--version',
        action  = 'version',
        version = PACKAGE_NAME + ' ' + pyproject_dict['project']['version']
    )
    
    args = arg_parser.parse_args()

    data_dir_path = os.path.join(root_module_dir_path, 'data')

    assert os.path.isdir(data_dir_path)

    quote_file_path = os.path.join(data_dir_path, 'quote.txt')

    assert os.path.isfile(quote_file_path)

    with open(quote_file_path, 'r') as quote_file:

        quote_str = quote_file.read().strip()

    print(indent(text = quote_str, prefix = ' ' * 4))
    
    return 0


if '__main__' == __name__:
    sys.exit(main())


