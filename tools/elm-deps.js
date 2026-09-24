#!/usr/bin/env node
/*
 * Elm 0.18 dependency manager.
 *
 * `elm-package install` no longer works: package.elm-lang.org stopped serving the per-package
 * metadata Elm 0.18 needs (and its 0.18 package index is incomplete). This tool resolves versions
 * from the packages' git tags, pins them in elm-dependencies.json and installs them with git into
 * elm-stuff/, which is all elm-make needs.
 *
 *   node tools/elm-deps.js install [dir]   install the pinned versions (default dir: .)
 *   node tools/elm-deps.js lock [dir]      re-resolve elm-package.json and rewrite the lock file
 */
'use strict';

const fs = require('fs');
const os = require('os');
const path = require('path');
const { execFileSync } = require('child_process');

const LOCK_FILE = 'elm-dependencies.json';

function readJson(file) {
  return JSON.parse(fs.readFileSync(file, 'utf8'));
}

function writeJson(file, data) {
  fs.writeFileSync(file, JSON.stringify(data, null, 4) + '\n');
}

function parseVersion(v) {
  return v.split('.').map(Number);
}

function compare(a, b) {
  const x = parseVersion(a);
  const y = parseVersion(b);
  for (let i = 0; i < 3; i++) {
    if (x[i] !== y[i]) return x[i] - y[i];
  }
  return 0;
}

// "1.0.0 <= v < 2.0.0"
function satisfies(version, range) {
  const m = range.match(/^\s*(\S+)\s*(<=|<)\s*v\s*(<=|<)\s*(\S+)\s*$/);
  if (!m) throw new Error('Unsupported version range: ' + range);
  const [, low, lowOp, highOp, high] = m;
  const lowOk = lowOp === '<=' ? compare(low, version) <= 0 : compare(low, version) < 0;
  const highOk = highOp === '<=' ? compare(version, high) <= 0 : compare(version, high) < 0;
  return lowOk && highOk;
}

// Versions of a package, newest first, from its git tags.
const versionCache = {};
function versionsOf(pkg) {
  if (!versionCache[pkg]) {
    const out = execFileSync('git', ['ls-remote', '--tags', `https://github.com/${pkg}.git`], { encoding: 'utf8' });
    const tags = new Set();
    for (const line of out.split('\n')) {
      const m = line.match(/refs\/tags\/(\d+\.\d+\.\d+)(\^\{\})?$/);
      if (m) tags.add(m[1]);
    }
    versionCache[pkg] = [...tags].sort(compare).reverse();
  }
  return versionCache[pkg];
}

function clone(pkg, version, dest) {
  if (fs.existsSync(path.join(dest, 'elm-package.json'))) return;
  fs.rmSync(dest, { recursive: true, force: true });
  fs.mkdirSync(path.dirname(dest), { recursive: true });
  execFileSync('git', ['-c', 'advice.detachedHead=false', 'clone', '--quiet', '--depth', '1',
    '--branch', version, `https://github.com/${pkg}.git`, dest], { stdio: ['ignore', 'ignore', 'inherit'] });
  fs.rmSync(path.join(dest, '.git'), { recursive: true, force: true });
}

const cacheDir = path.join(os.homedir(), '.cache', 'heborn-elm-packages');

function packageInfo(pkg, version) {
  const dir = path.join(cacheDir, pkg, version);
  try {
    clone(pkg, version, dir);
    return readJson(path.join(dir, 'elm-package.json'));
  } catch (e) {
    return null; // not an Elm 0.18 package at this version (e.g. an Elm 0.19 release)
  }
}

function isElm018(pkg, version) {
  const info = packageInfo(pkg, version);
  return !!info && satisfies('0.18.0', info['elm-version'] || '0.18.0 <= v < 0.19.0');
}

function packageDeps(pkg, version) {
  return packageInfo(pkg, version).dependencies || {};
}

function lock(projectDir) {
  const root = readJson(path.join(projectDir, 'elm-package.json')).dependencies;
  let chosen = {};
  const rejected = new Set(); // "pkg@version" ruled out after a conflict

  // Pick the newest version allowed by every constraint and repeat until nothing changes. On a
  // conflict, rule out the version of the package that imposed the incompatible constraint.
  for (let round = 0; round < 200; round++) {
    const constraints = {};
    const sources = {};
    const add = (deps, from) => {
      for (const [name, range] of Object.entries(deps)) {
        (constraints[name] = constraints[name] || []).push(range);
        (sources[name] = sources[name] || []).push({ from, range });
      }
    };
    add(root, null);
    for (const [name, version] of Object.entries(chosen)) {
      if (constraints[name]) add(packageDeps(name, version), `${name}@${version}`);
    }

    const next = {};
    let conflict = null;
    for (const [name, ranges] of Object.entries(constraints)) {
      const version = versionsOf(name).find(v =>
        !rejected.has(`${name}@${v}`) && ranges.every(r => satisfies(v, r)) && isElm018(name, v));
      if (!version) {
        conflict = name;
        break;
      }
      next[name] = version;
    }

    if (conflict) {
      const rootRanges = sources[conflict].filter(s => s.from === null).map(s => s.range);
      const culprit = sources[conflict].find(s => s.from !== null &&
        !versionsOf(conflict).some(v => satisfies(v, s.range) && rootRanges.every(r => satisfies(v, r))))
        || sources[conflict].find(s => s.from !== null);
      if (!culprit) {
        throw new Error(`No version of ${conflict} satisfies ${rootRanges.join(' and ')}`);
      }
      rejected.add(culprit.from);
      chosen = {};
      continue;
    }

    const stable = JSON.stringify(next) === JSON.stringify(chosen);
    chosen = next;
    if (stable) {
      const sorted = {};
      for (const name of Object.keys(chosen).sort()) sorted[name] = chosen[name];
      writeJson(path.join(projectDir, LOCK_FILE), sorted);
      console.log(`Wrote ${path.join(projectDir, LOCK_FILE)} (${Object.keys(sorted).length} packages)`);
      return;
    }
  }
  throw new Error('Dependency resolution did not converge');
}

function install(projectDir) {
  const lockPath = path.join(projectDir, LOCK_FILE);
  if (!fs.existsSync(lockPath)) throw new Error(`${lockPath} not found, run: node tools/elm-deps.js lock ${projectDir}`);
  const pinned = readJson(lockPath);
  for (const [name, version] of Object.entries(pinned)) {
    clone(name, version, path.join(projectDir, 'elm-stuff', 'packages', name, version));
  }
  writeJson(path.join(projectDir, 'elm-stuff', 'exact-dependencies.json'), pinned);
  console.log(`Installed ${Object.keys(pinned).length} Elm packages into ${path.join(projectDir, 'elm-stuff')}`);
}

const [command, dir = '.'] = process.argv.slice(2);
Promise.resolve()
  .then(() => {
    if (command === 'install') return install(dir);
    if (command === 'lock') return lock(dir);
    throw new Error('usage: node tools/elm-deps.js install|lock [dir]');
  })
  .catch(err => {
    console.error(err.message);
    process.exit(1);
  });
