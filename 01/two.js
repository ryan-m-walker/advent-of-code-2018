const fs = require('fs');

function calc(input, total = 0, freq = {}) {
  let found;

  for (const item of input) {
    if (total in freq) {
      found = total;
      break;
    } else {
      freq[total] = true;
    }
    total += +item;
  }

  if (!found) {
    return calc(input, total, freq);
  }

  return found;
}

const input = fs
  .readFileSync('input.txt')
  .toString()
  .split('\n');
const output = calc(input);
console.log('FOUND:', output);
