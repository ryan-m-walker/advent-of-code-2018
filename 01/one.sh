#!/bin/bash

total=0
while IFS= read -r line || [[ -n "$line" ]]; do
  total=$(( total + line ))
done < input.txt

echo "$total"
