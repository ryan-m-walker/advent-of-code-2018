#!/usr/bin/env bash

calc() {
  local -a shifts=("$@")
  local total=0
  # keys are the frequencies we have already reached
  local -A freq=([0]=1)
  local shift

  # the list of shifts is cycled over repeatedly until a
  # frequency shows up for the second time
  while true; do
    for shift in "${shifts[@]}"; do
      (( total += shift ))

      if [[ -n "${freq[$total]}" ]]; then
        echo "$total"
        return
      fi

      freq[$total]=1
    done
  done
}

mapfile -t input < input.txt
echo "FOUND: $(calc "${input[@]}")"
