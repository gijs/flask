.PHONY: clean-pyc test upload-docs

all: clean-pyc test

test:
	python tests/flask_tests.py

release:
	python setup.py release sdist upload

clean-pyc:
	find . -name '*.pyc' -exec rm -f {} +
	find . -name '*.pyo' -exec rm -f {} +
	find . -name '*~' -exec rm -f {} +

upload-docs:
	$(MAKE) -C docs html dirhtml latex
	$(MAKE) -C docs/_build/latex all-pdf
	cd docs/_build/; mv html flask-docs; zip -r flask-docs.zip flask-docs; mv flask-docs html
	scp -r docs/_build/dirhtml/* pocoo.org:/var/www/flask.pocoo.org/docs/
	scp -r docs/_build/latex/Flask.pdf pocoo.org:/var/www/flask.pocoo.org/docs/flask-docs.pdf
	scp -r docs/_build/flask-docs.zip pocoo.org:/var/www/flask.pocoo.org/docs/
