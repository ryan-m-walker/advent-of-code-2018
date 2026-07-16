#!/usr/bin/env bash
# sum every frequency shift into a running total
# (|| [[ -n $shift ]] so the last line is counted even without a trailing newline)
total=0
while read -r shift || [[ -n $shift ]]; do
  total=$((total + shift))
done < input.txt

echo "$total"
