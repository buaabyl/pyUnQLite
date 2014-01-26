#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os
from Cython.Build import cythonize
from distutils.core import setup

setup(
    name="pyUnQLite",
    version='0.0.2',
    description='Unofficial python bindings for UnQLite',
    long_description=open(os.path.join(os.path.dirname(__file__), 'README.md')).read(),
    classifiers=[
        'Development Status :: 2 - Pre-Alpha',
        'License :: OSI Approved :: BSD License',
        'Topic :: Database',
    ],
    keywords=['UnQLite'],
    author='buaabyl',
    author_email='buaabyl@gmail.com',
    url='https://github.com/buaabyl/pyUnQLite',
    license='BSD',
    ext_modules=cythonize('pyunqlite.pyx', sources=['unqlite.c']))
