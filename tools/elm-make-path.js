'use strict';
// Path of elm-make 0.18: the copy installed by tools/install-elm.sh, or the one on the PATH.
const fs = require('fs');
const path = require('path');

const local = path.join(__dirname, 'elm', 'bin', 'elm-make');
module.exports = fs.existsSync(local) ? local : 'elm-make';
