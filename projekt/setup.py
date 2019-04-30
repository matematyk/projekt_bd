import io

from setuptools import find_packages, setup

with io.open('README.rst', 'rt', encoding='utf8') as f:
    readme = f.read()

setup(
    name='projekt_bazy',
    version='0.0.1',
    url='https://github.com/matematyk/projekt_bd',
    license='MIT',
    maintainer='Marcin Wierzbinski',
    maintainer_email='',
    description='Projekt z Baz Danych',
    long_description=readme,
    packages=find_packages(),
    include_package_data=True,
    zip_safe=False,
    install_requires=[
        'flask',
        'cx_Oracle',
    ],
    extras_require={
        'test': [
            'pytest',
            'coverage',
        ],
    },
)