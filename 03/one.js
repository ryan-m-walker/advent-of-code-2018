const fs = require('fs');

const INPUT = 'test_input.txt';

const i = fs
  .readFileSync(INPUT)
  .toString()
  .split('\n');

function main(input) {}

main(i);
