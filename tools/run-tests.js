#!/usr/bin/env node
/*
 * Runs the Elm 0.18 test suite (tests/Main.elm) in Node, replacing the `elm-test` 0.18 CLI,
 * whose installer and dependencies no longer work on current Node versions.
 *
 *   node tools/run-tests.js [--seed N]
 *
 * Needs Elm 0.18 (tools/install-elm.sh) and the test packages installed
 * (node tools/elm-deps.js install tests).
 */
'use strict';

const fs = require('fs');
const os = require('os');
const path = require('path');
const { execFileSync } = require('child_process');
const elmMake = require('./elm-make-path');

const seedArg = process.argv.indexOf('--seed');
const seed = seedArg > -1 ? process.argv[seedArg + 1] : String(Math.floor(Math.random() * 407199254740991));

const testsDir = path.resolve(__dirname, '..', 'tests');
const tmp = fs.mkdtempSync(path.join(os.tmpdir(), 'heborn-tests-'));
const compiled = path.join(tmp, 'tests.js');

execFileSync(elmMake, ['Main.elm', '--yes', '--output', compiled], { cwd: testsDir, stdio: ['ignore', 'ignore', 'inherit'] });

// Native test helpers expect a browser-like global.
global.window = global.window || global;

const Elm = require(compiled);
const app = Elm.Main.worker({ seed, report: 'json' });

let passed = 0;
let failed = 0;

app.ports.emit.subscribe(([event, data]) => {
  const message = data.message;
  switch (event) {
    case 'STARTED':
      console.log(`Running ${message.testCount} tests with seed ${seed}`);
      break;
    case 'TEST_COMPLETED':
      if (message.status === 'pass') {
        passed++;
      } else if (message.status === 'fail') {
        failed++;
        console.log(`\n✗ ${message.labels.join(' › ')}`);
        for (const failure of message.failures) {
          console.log('  ' + (typeof failure === 'string' ? failure : JSON.stringify(failure)).split('\n').join('\n  '));
        }
      }
      break;
    case 'FINISHED':
      console.log(`\n${passed} passed, ${failed} failed (seed ${seed})`);
      fs.rmSync(tmp, { recursive: true, force: true });
      process.exit(data.exitCode);
  }
});
