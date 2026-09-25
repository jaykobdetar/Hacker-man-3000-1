# HEBorn

HEBorn is the web client for [Hacker Experience 1](https://1.hackerexperience.com).

The codebase here is also the same one for the Hacker Experience 2 client. Once we start releasing the HE2 client, we'll probably split this repository in three: shared logic repository, HE1 client, HE2 client.

## Requirements

- [Node.js](https://nodejs.org) 22 LTS (22.15 or newer, see `.nvmrc`) and npm
- git, curl and a UNIX-like OS (Linux, macOS, or WSL on Windows)
- [Helix](https://github.com/HackerExperience/Helix), the game server, for anything beyond the login screen

The client is still written in [Elm](https://elm-lang.org) **0.18**. Elm 0.18's own installers stopped
working years ago (the npm package's binary download and `elm-package install` both fail), so
the repository brings its own tooling:

- `tools/install-elm.sh` installs the Elm 0.18 compiler into `tools/elm/bin` (checksum-verified;
  only x86-64 binaries exist, Apple Silicon Macs run them through Rosetta 2).
- `tools/elm-deps.js` installs the Elm packages pinned in `elm-dependencies.json` and
  `tests/elm-dependencies.json` from their git repositories. Run
  `node tools/elm-deps.js lock [dir]` after changing an `elm-package.json`.
- `tools/elm-loader.js` (webpack loader), `tools/elm-css.js` (stylesheet generation) and
  `tools/run-tests.js` (test runner) replace `elm-webpack-loader`, the `elm-css` CLI and the
  0.18 `elm-test` CLI.

You don't need anything installed globally besides Node.js.

## Usage

### Setup

```
make setup      # or: git submodule update --init && npm ci && npm run setup
```

### Development

Launches a development server on http://localhost:8000 that rebuilds and reloads the page when
a `.elm` or `.js` file changes (`PORT=...` to change the port).

```
make dev        # or: npm run dev
```

Styles are generated from Elm (`src/Core/Stylesheets.elm`); run `make css` after changing them.

### Test

```
make test       # or: npm test
```

Use `make test-quick` to run a single fuzz test iteration, or `make test-long` for 100.
`node tools/run-tests.js --seed N` reruns a specific seed.

### Lint

```
make lint       # or: npm run lint
make format     # reformat src/ and tests/
```

Uses [elm-format](https://github.com/avh4/elm-format) 0.8 in Elm 0.18 mode (installed by npm).

### Release

Outputs the client static files to `build/` (and `make release` also packs `build/release.tar.gz`).

```
HEBORN_API_HTTP_URL=https://api.example.com/v1 \
HEBORN_API_WEBSOCKET_URL=wss://api.example.com/websocket \
make build
```

Build-time settings:

| Variable | Default |
| --- | --- |
| `HEBORN_API_HTTP_URL` | `https://localhost:4000/v1` |
| `HEBORN_API_WEBSOCKET_URL` | `wss://localhost:4000/websocket` |
| `HEBORN_VERSION` | `dev` |
| `HEBORN_GAME_MODE` | `HE1` |
| `HEBORN_MAP_TILES_URL` | `https://tile.openstreetmap.org/{z}/{x}/{y}.png` |
| `HEBORN_GEOCODER_URL` | `https://nominatim.openstreetmap.org/reverse` (any Nominatim-compatible API; Mapzen, used originally, no longer exists) |

The generated `index.html` carries a Content-Security-Policy that only allows the API, map tile
and geocoder origins above. Also send `Content-Security-Policy: frame-ancestors 'self'` and
`X-Content-Type-Options: nosniff` headers from the web server hosting `build/`, since those
can't be set from a `<meta>` tag.

### Continuous integration

`.github/workflows/ci.yml` runs `npm audit`, the linter, the test suite and a production build
on every push, and keeps the built files as an artifact.

## Contributing

Interested in contributing? There are several ways you can help, even if you don't know a thing about computer programming. Please take a look at our [Contribution Guidelines](CONTRIBUTING.md).

## Support
You can get development support on our [online chat](https://chatops.hackerexperience.com/).

If you have any question that could not be responded on the chat by our
contributors, feel free to open an issue.

## License
2015-2017 [Neoart Labs LLC](https://neoartlabs.com).

HEBorn source code is released under the AGPL 3 license.

Check [LICENSE](LICENSE) or [GNU AGPL3](https://www.gnu.org/licenses/agpl-3.0.en.html)
for more information.

[![AGPL3](https://www.gnu.org/graphics/agplv3-88x31.png)](https://www.gnu.org/licenses/agpl-3.0.en.html)
