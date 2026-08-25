#!/usr/bin/env bash

calc() {
  local -a shifts=("$@")
  local total=0
  local -A freq=([0]=1)
  local shift

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
