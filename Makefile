# Thin wrapper around the npm scripts in package.json (kept for existing habits and CI).
.PHONY: default setup dev css build release test test-quick test-long lint format clean

default: dev

# Installs npm packages, the Elm 0.18 compiler and the pinned Elm packages.
setup:
	git submodule update --init
	npm ci
	npm run setup

# Development server with live reload on http://localhost:8000 (PORT=... to change).
dev:
	npm run dev

css:
	npm run css

# Production build in build/.
build:
	npm run build

# Production build packed as build/release.tar.gz.
release: build
	tar -czf release.tar.gz -C build . && mv release.tar.gz build/

test:
	npm test

# Fuzz tests run tests/Config.elm's number of times; these targets change it temporarily.
test-quick:
	sed -i.bak 's/10/1/g' tests/Config.elm && (npm test; status=$$?; mv tests/Config.elm.bak tests/Config.elm; exit $$status)

test-long:
	sed -i.bak 's/10/100/g' tests/Config.elm && (npm test; status=$$?; mv tests/Config.elm.bak tests/Config.elm; exit $$status)

lint:
	npm run lint

format:
	npx elm-format --elm-version=0.18 --yes src tests

clean:
	rm -rf build elm-stuff tests/elm-stuff static/css/index.css release.tar.gz
