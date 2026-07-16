#!/usr/bin/env bash
# read every shift into an array so we can cycle over them repeatedly
mapfile -t shifts < input.txt

# track seen frequencies in an associative array; frequency starts at 0
declare -A seen
total=0
seen[$total]=1

while true; do
  for shift in "${shifts[@]}"; do
    total=$((total + shift))
    if [[ -n ${seen[$total]} ]]; then
      echo "$total"
      exit 0
    fi
    seen[$total]=1
  done
done
