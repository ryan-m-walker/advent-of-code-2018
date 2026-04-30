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
	total := 0
	for _, line := range lines {
		n, err := strconv.Atoi(strings.TrimSpace(line))
		if err != nil {
			continue
		}
		total += n
	}

	fmt.Println(total)
}
