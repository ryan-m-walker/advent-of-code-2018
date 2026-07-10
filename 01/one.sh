#!/usr/bin/env bash

total=0
# the `|| [ -n "$shift" ]` makes sure we still process the
# final line even if the file has no trailing newline
while read -r shift || [ -n "$shift" ]; do
    # skip any blank lines
    [ -z "$shift" ] && continue
    total=$((total + shift))
done < input.txt

echo "$total"
