run:
	./node_modules/.bin/gulp

del:
	rm -rf .git
	git init
	git add .
	git commit -m'начал с нуля'
	git remote add origin git@github.com:vaeum/vaeum.github.io.git
	git push -u -f origin --all

install:
	gem install bundler -v 1.11.2
	bundle install
	npm install

build-prod:
	JEKYLL_ENV=production jekyll build

build:
	JEKYLL_ENV=development jekyll build
