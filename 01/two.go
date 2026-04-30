package main

import (
	"fmt"
	"os"
	"strconv"
	"strings"
)

func main() {
	data, err := os.ReadFile("input.txt")
	if err != nil {
		fmt.Fprintln(os.Stderr, err)
		os.Exit(1)
	}

	lines := strings.Split(strings.TrimSpace(string(data)), "\n")
	shifts := make([]int, 0, len(lines))
	for _, line := range lines {
		n, err := strconv.Atoi(strings.TrimSpace(line))
		if err != nil {
			continue
		}
		shifts = append(shifts, n)
	}

	seen := map[int]bool{0: true}
	total := 0
	for {
		for _, shift := range shifts {
			total += shift
			if seen[total] {
				fmt.Println(total)
				return
			}
			seen[total] = true
		}
	}
}
