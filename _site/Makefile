check:
	golangci-lint run

check-clean-cache:
	golangci-lint cache clean

site:
	$(jekyll) serve --drafts --livereload

build:
	$(jekyll) build --drafts

docker:
	docker run --name site -d --rm -p 4000:4000 -v `pwd`:"/srv/jekyll" jekyll/jekyll:4.0.0 bash -c "bundle install; jekyll serve --drafts --livereload"
