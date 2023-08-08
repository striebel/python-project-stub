from importlib.metadata import version, PackageNotFoundError


def main():
    try:
        version_str = version(__package__)
    except PackageNotFoundError:
        version_str = ''
    print('executing main function of package:')
    print(__package__.replace('_', ' '), version_str)
    return 0
