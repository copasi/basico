# simple Makefile to build sphinx docs locally on linux
# to ensure build requirements are installed:
# pip install -r requirements.txt

all: html

html:
	sphinx-apidoc -M -t _templates/autosummary -o API ../basico
	sphinx-build -M html . build

clean:
	rm -rf build API
