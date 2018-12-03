const fs = require('fs');

function calc(input) {
  // const output = input.reduce((total, [sign, ...rest]) => {
  //   const num = +rest.join('');
  //   return sign === '+' ? total + num : total - num;
  // }, 0);

  // return output;
  return input.map((item) => +item)
    .reduce((prev, next) => prev + next);
}

const input = fs
  .readFileSync('input.txt')
  .toString()
  .split('\n');
const output = calc(input);
console.log(output);
