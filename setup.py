#!/usr/bin/env python
import unittest
from setuptools import setup
import versioneer
import re

def basico_testsuite():
    test_loader = unittest.TestLoader()
    test_suite = test_loader.discover('tests', pattern='test_*.py')
    return test_suite

def read(fname):
    """Read a file."""
    return open(fname).read()


def absolute_links(txt):
    """Replace relative petab github links by absolute links."""

    raw_base = \
        "(https://raw.githubusercontent.com/copasi/basico/master/"
    embedded_base = \
        "(https://github.com/copasi/basico/tree/master/"
    # iterate over links
    for var in re.findall(r"\[.*?\]\((?!http).*?\)", txt):
        if re.match(r".*?.(png|svg|jpg)\)", var):
            # link to raw file
            rep = var.replace("(", raw_base)
        else:
            # link to github embedded file
            rep = var.replace("(", embedded_base)
        txt = txt.replace(var, rep)
    return txt



setup(name='copasi_basico',
      version=versioneer.get_version(),
      cmdclass=versioneer.get_cmdclass(),
      description='Simplified COPASI interface for python',
      long_description=absolute_links(read("README.md")),
      long_description_content_type="text/markdown",
      author='COPASI Team',
      author_email='developers@copasi.org',
      url='https://github.com/copasi/basico',
      packages=['basico', 'basico.petab'],
      package_dir={'basico': 'basico', 'basico.petab': 'basico/petab'},
      package_data={'basico': ['data/*']},
      license='Artistic-2.0',
      install_requires=[
          'python-copasi', 'pandas', 'numpy', 'matplotlib', 'PyYAML' , 'scipy', 'lxml'
      ],
      platforms=['Windows', 'Linux', 'MacOS'],
      classifiers=[
          'Topic :: Scientific/Engineering :: Bio-Informatics',
          'Development Status :: 4 - Beta',
          'License :: OSI Approved :: Artistic License',
          'Intended Audience :: Science/Research',
          'Intended Audience :: Education',
          'Natural Language :: English',
          'Operating System :: MacOS :: MacOS X',
          'Operating System :: Microsoft :: Windows',
          'Operating System :: POSIX :: Linux',
          'Programming Language :: C++',
          'Programming Language :: Python :: 3',
          'Programming Language :: Python :: 3.7',
          'Programming Language :: Python :: 3.8',
          'Programming Language :: Python :: 3.9',
          'Programming Language :: Python :: 3.10',
          'Programming Language :: Python :: 3.11',
          'Programming Language :: Python :: Implementation :: CPython',
          'Programming Language :: Python :: Implementation :: PyPy',
      ],
      keywords='copasi sbml systems biology',
      project_urls={
        "Github": "https://github.com/copasi/basico",
        "Issues": "https://github.com/copasi/basico/issues",
        "Try it online": "https://colab.research.google.com/github/copasi/basico/blob/master/docs/notebooks/index_colab.ipynb",
      },
      test_suite='setup.basico_testsuite',
      extras_require={
        'petab': ['copasi-petab-importer', 'petab', 'petab-select'],
        'tqdm': ['tqdm'],
        'docs': ['sphinx', 'sphinx_rtd_theme', 'sphinxcontrib-bibtex', 'sphinxcontrib-programoutput', 'sphinxcontrib-mermaid', 'sphinxcontrib-plantuml', 'sphinxcontrib'],
        },

      )
