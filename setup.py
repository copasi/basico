#!/usr/bin/env python
import unittest
from setuptools import setup


def basico_testsuite():
    test_loader = unittest.TestLoader()
    test_suite = test_loader.discover('tests', pattern='test_*.py')
    return test_suite


setup(name='Basico',
      version='1.0',
      description='Simplified COPASI interface for python',
      long_description="""Basico provides utility functions around the SWIG generated COPASI bindings, it 
      simplifies tasks, by relying on pandas, and numpy.
      """,
      author='COPASI Team',
      author_email='developers@copasi.org',
      url='https://github.com/copasi/basico',
      packages=['basico'],
      package_dir={'basico': 'basico'},
      package_data={'basico': ['data/*']},
      license='Artistic',
      install_requires=[
          'python-copasi', 'pandas', 'numpy', 'matplotlib'
      ],
      platforms=['Windows', 'Linux', 'MacOS'],
      classifiers=[
          'Development Status :: 3 - Alpha',
          'License :: OSI Approved :: Artistic License',
          'Programming Language :: Python :: 2.7',
          'Topic :: Scientific/Engineering',
      ],
      keywords='copasi sbml systems biology',
      test_suite='setup.basico_testsuite'
)

