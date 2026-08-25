#!/usr/bin/env bash

calc() {
  local total=0
  local shift

  # add up every frequency shift in the input
  while read -r shift || [[ -n "$shift" ]]; do
    (( total += shift ))
  done

  echo "$total"
}

calc < input.txt
