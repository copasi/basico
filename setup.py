#!/usr/bin/env python
import unittest
from setuptools import setup
import versioneer


def basico_testsuite():
    test_loader = unittest.TestLoader()
    test_suite = test_loader.discover('tests', pattern='test_*.py')
    return test_suite


setup(name='copasi_basico',
      version=versioneer.get_version(),
      cmdclass=versioneer.get_cmdclass(),
      description='Simplified COPASI interface for python',
      long_description="""Basico provides utility functions around the SWIG generated COPASI bindings, it 
      simplifies tasks, by relying on pandas, and numpy.
      """,
      author='COPASI Team',
      author_email='developers@copasi.org',
      url='https://github.com/copasi/basico',
      packages=['basico', 'basico.petab'],
      package_dir={'basico': 'basico', 'basico.petab': 'basico/petab'},
      package_data={'basico': ['data/*']},
      license='Artistic-2.0',
      install_requires=[
          'python-copasi', 'pandas', 'numpy', 'matplotlib'
      ],
      platforms=['Windows', 'Linux', 'MacOS'],
      classifiers=[
          'Topic :: Scientific/Engineering :: Bio-Informatics',
          'Development Status :: 3 - Alpha',
          'License :: OSI Approved :: Artistic License',
          'Intended Audience :: Science/Research',
          'Intended Audience :: Education',
          'Natural Language :: English',
          'Operating System :: MacOS :: MacOS X',
          'Operating System :: Microsoft :: Windows',
          'Operating System :: POSIX :: Linux',
          'Programming Language :: C++',
          'Programming Language :: Python :: 2',
          'Programming Language :: Python :: 2.7',
          'Programming Language :: Python :: 3',
          'Programming Language :: Python :: 3.5',
          'Programming Language :: Python :: 3.6',
          'Programming Language :: Python :: 3.7',
          'Programming Language :: Python :: 3.8',
          'Programming Language :: Python :: 3.9',
          'Programming Language :: Python :: Implementation :: CPython',
          'Programming Language :: Python :: Implementation :: PyPy',
      ],
      keywords='copasi sbml systems biology',
      project_urls={
        "Github": "https://github.com/copasi/basico",
        "Issues": "https://github.com/copasi/basico/issues",
        "Try it online": "https://colab.research.google.com/github/copasi/basico/blob/master/docs/notebooks/Creating_a_simple_model.ipynb",
      },
      test_suite='setup.basico_testsuite',
      extras_require={'petab': ['copasi-petab-importer', 'petab', 'petab-select']},

      )
