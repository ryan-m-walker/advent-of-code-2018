#!/usr/bin/env bash

# read all the frequency shifts into an array so we can loop
# over the input repeatedly without re-reading the file
shifts=()
# the `|| [ -n "$shift" ]` makes sure we still capture the
# final line even if the file has no trailing newline
while read -r shift || [ -n "$shift" ]; do
    [ -z "$shift" ] && continue
    shifts+=("$shift")
done < input.txt

total=0
declare -A seen
seen[$total]=1

# keep cycling through the shifts until we hit a frequency
# we have already seen, then print it and exit
while true; do
    for shift in "${shifts[@]}"; do
        total=$((total + shift))
        if [ -n "${seen[$total]}" ]; then
            echo "$total"
            exit 0
        fi
        seen[$total]=1
    done
done
