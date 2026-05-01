#!/bin/bash

declare -A seen
total=0
seen[0]=1

# Read input into array
mapfile -t changes < input.txt

while true; do
  for line in "${changes[@]}"; do
    total=$(( total + line ))
    if [[ ${seen[$total]+_} ]]; then
      echo "$total"
      exit 0
    fi
    seen[$total]=1
  done
done
