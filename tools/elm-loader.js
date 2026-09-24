/*
 * Minimal webpack loader for Elm 0.18: compiles the imported .elm entry with elm-make.
 *
 * Replaces elm-webpack-loader 4.x / elm-hot-loader, which depend on the broken `elm@0.18` npm
 * package and on outdated, vulnerable libraries. All Elm source directories are watched, so the
 * dev server rebuilds and reloads the page when any .elm file changes.
 *
 * Options: { debug: boolean, warn: boolean, elmMake: path to elm-make (default: tools/elm or PATH) }
 */
'use strict';

const fs = require('fs');
const os = require('os');
const path = require('path');
const { execFile } = require('child_process');
const defaultElmMake = require('./elm-make-path');

module.exports = function elmLoader() {
  const callback = this.async();
  const options = this.getOptions();
  const root = this.rootContext;

  const elmPackage = JSON.parse(fs.readFileSync(path.join(root, 'elm-package.json'), 'utf8'));
  for (const dir of elmPackage['source-directories']) {
    this.addContextDependency(path.resolve(root, dir));
  }
  this.addDependency(path.join(root, 'elm-package.json'));

  const output = path.join(os.tmpdir(), `heborn-elm-${process.pid}-${Date.now()}.js`);
  const args = [this.resourcePath, '--yes', '--output', output];
  if (options.debug) args.push('--debug');
  if (options.warn) args.push('--warn');

  execFile(options.elmMake || defaultElmMake, args, { cwd: root, maxBuffer: 64 * 1024 * 1024 }, (err, stdout, stderr) => {
    if (err) {
      callback(new Error(`elm-make failed:\n${stderr || stdout || err.message}`));
      return;
    }
    const js = fs.readFileSync(output, 'utf8');
    fs.rmSync(output, { force: true });
    callback(null, js);
  });
};
