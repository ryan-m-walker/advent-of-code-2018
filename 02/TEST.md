# Day 2 - Inventory Management System - Test Plan

## Prerequisites

- GHC (Glasgow Haskell Compiler) installed
- Run commands from the `02/` directory

## Part 1 (`one.hs`)

### Compile and Run

```bash
ghc -o one one.hs && ./one
```

### Expected Output

```
6888
```

### Manual Verification

Given a small test input like:
```
abcdef
bababc
abbcde
abcccd
aabcdd
abcdee
ababab
```

- IDs with exactly 2 of any letter: `bababc`, `abbcde`, `aabcdd`, `abcdee` (4)
- IDs with exactly 3 of any letter: `bababc`, `abcccd`, `ababab` (3)
- Checksum: 4 * 3 = **12**

## Part 2 (`two.hs`)

### Compile and Run

```bash
ghc -o two two.hs && ./two
```

### Expected Output

```
icxjvbrobtunlelzpdmfkahgs
```

### Manual Verification

Given the test data in `test_data.txt`:
```
abcde
fghij
klmno
pqrst
fguij
axcye
wvxyz
```

- `fghij` and `fguij` differ by exactly one character (position 3: `h` vs `u`)
- Common letters: **fgij**
