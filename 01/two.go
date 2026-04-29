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
	shifts := make([]int, len(lines))
	for i, line := range lines {
		n, err := strconv.Atoi(line)
		if err != nil {
			fmt.Fprintln(os.Stderr, err)
			os.Exit(1)
		}
		shifts[i] = n
	}

	seen := map[int]bool{0: true}
	total := 0
	for {
		for _, n := range shifts {
			total += n
			if seen[total] {
				fmt.Println(total)
				return
			}
			seen[total] = true
		}
	}
}
