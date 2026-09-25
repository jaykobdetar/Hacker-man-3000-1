#!/usr/bin/env node
/*
 * Generates the game's stylesheets (static/css/index.css) from src/Core/Stylesheets.elm,
 * replacing the unmaintained `elm-css` npm CLI. Needs Elm 0.18 (tools/install-elm.sh) and the
 * Elm packages installed (tools/elm-deps.js install).
 *
 *   node tools/elm-css.js [src/Core/Stylesheets.elm] [static/css]
 */
'use strict';

const fs = require('fs');
const os = require('os');
const path = require('path');
const { execFileSync } = require('child_process');
const elmMake = require('./elm-make-path');

const entry = process.argv[2] || 'src/Core/Stylesheets.elm';
const outDir = process.argv[3] || 'static/css';
const tmp = fs.mkdtempSync(path.join(os.tmpdir(), 'heborn-css-'));
const compiled = path.join(tmp, 'stylesheets.js');

try {
  execFileSync(elmMake, [entry, '--yes', '--output', compiled], { stdio: ['ignore', 'ignore', 'inherit'] });
  const Elm = require(compiled);
  const worker = Elm.Stylesheets.worker();

  worker.ports.files.subscribe(files => {
    let failed = false;
    for (const file of files) {
      if (!file.success) {
        failed = true;
        console.error(`${file.filename}: elm-css reported warnings:\n${file.content}`);
        continue;
      }
      fs.mkdirSync(outDir, { recursive: true });
      fs.writeFileSync(path.join(outDir, file.filename), file.content);
      console.log(`Wrote ${path.join(outDir, file.filename)}`);
    }
    fs.rmSync(tmp, { recursive: true, force: true });
    process.exit(failed ? 1 : 0);
  });
} catch (err) {
  fs.rmSync(tmp, { recursive: true, force: true });
  console.error(err.message);
  process.exit(1);
}
