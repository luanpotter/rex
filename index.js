#!/usr/bin/env node

const stdin = require('get-stdin');

if (process.argv.length <= 3) {
	console.error("Usage: echo 'data' | rex 'from' 'to'");
	return;
}

const fromRaw = process.argv[2];
const toRaw = process.argv[3];

const from = new RegExp(fromRaw, 'gm');
const to = toRaw.replace(/\\t/g, '\t').replace(/\\n/g, '\n').replace(/\\r/g, '\r').replace(/\\\\/g, '\\').replace(/\\\$/g, '$$$$');

stdin().then(str => {
	const result = str.replace(from, to);
	process.stdout.write(result);
});
