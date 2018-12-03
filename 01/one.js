const fs = require('fs');

function calc(input) {
  return input.map((item) => +item).reduce((prev, next) => prev + next);
}

const input = fs
  .readFileSync('input.txt')
  .toString()
  .split('\n');
const output = calc(input);
console.log(output);
