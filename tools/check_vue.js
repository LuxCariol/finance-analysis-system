const fs = require('fs');
const path = require('path');
const compiler = require(path.join(__dirname, '..', 'mobile', 'node_modules', 'vue-template-compiler'));

function walk(dir, result) {
  for (const name of fs.readdirSync(dir)) {
    if (name === 'node_modules' || name === '.git') continue;
    const full = path.join(dir, name);
    const stat = fs.statSync(full);
    if (stat.isDirectory()) walk(full, result);
    else if (name.endsWith('.vue')) result.push(full);
  }
}

const files = [];
walk(path.join(__dirname, '..', 'mobile'), files);
let failed = 0;
for (const file of files) {
  const source = fs.readFileSync(file, 'utf8');
  const match = source.match(/<template>([\s\S]*)<\/template>\s*<script>/);
  if (!match) {
    if (path.basename(file) === 'App.vue') {
      console.log('PASS', path.relative(path.join(__dirname, '..'), file), '(no template)');
    } else {
      console.log('FAIL missing template', file);
      failed++;
    }
    continue;
  }
  const result = compiler.compile(match[1], { outputSourceRange: true });
  if (result.errors && result.errors.length) {
    failed++;
    console.log('FAIL', file);
    result.errors.forEach(error => console.log('  ', error));
  } else {
    console.log('PASS', path.relative(path.join(__dirname, '..'), file));
  }
}
if (failed) process.exit(1);
console.log(`Checked ${files.length} Vue templates`);
