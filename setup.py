#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os
from Cython.Build import cythonize
from distutils.core import setup

setup(
    name="py-unqlite",
    version='0.0.1',
    description='Unofficial python bindings for UnQLite',
    long_description=open(os.path.join(os.path.dirname(__file__), 'README.md')).read(),
    classifiers=[
        'Development Status :: 2 - Pre-Alpha',
        'License :: OSI Approved :: BSD License',
        'Topic :: Database',
    ],
    keywords=['UnQLite'],
    author='east301',
    author_email='me@east301.net',
    url='https://bitbucket.org/east301/py-unqlite/',
    license='BSD',
    ext_modules=cythonize('pyunqlite.pyx', sources=['unqlite.c']))
