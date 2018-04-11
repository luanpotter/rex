#!/usr/bin/env node

const fs = require('fs');
const stdin = require('get-stdin');
const argv = require("optimist")
  .boolean(["f", "b", "h"])
  .usage("Usage: $0 -fbh [from] [to]")
  .argv;

const ENCDOING = 'UTF-8';
const HELP = "Usage: echo 'data' | rex 'from' 'to'\nAlso, use the flags:\n-f : stdin becomes a file list\n-b : backup\n-h : help";

if (argv.h) {
	console.log(HELP);
	return;
}

const f = !!argv.f;
const b = !!argv.b;
const params = argv._;

if (params.length != 2) {
	console.error('You must pass 2 parameters\n' + HELP);
	return;
}

const fromRaw = params[0].toString();
const toRaw = params[1].toString();

const from = new RegExp(fromRaw, 'gm');
const to = toRaw.replace(/\\t/g, '\t').replace(/\\n/g, '\n').replace(/\\r/g, '\r').replace(/\\\\/g, '\\').replace(/\\\$/g, '$$$$');

stdin().then(str => {
	if (f) {
		str
      .split("\n")
      .filter(path => path && fs.lstatSync(path).isFile())
      .forEach(file => {
        const data = fs.readFileSync(file, ENCDOING);
        const result = data.replace(from, to);
        fs.writeFileSync(file + (b ? ".bak" : ""), result, ENCDOING);
      });
	} else {
		const result = str.replace(from, to);
		if (b) {
			fs.writeFileSync('__rex__.bak', result, ENCDOING)
			process.stdout.write(str);
		} else {
			process.stdout.write(result);
		}
	}
});
