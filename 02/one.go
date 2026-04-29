package main

import (
	"fmt"
	"os"
	"strings"
)

func main() {
	data, err := os.ReadFile("input.txt")
	if err != nil {
		fmt.Fprintln(os.Stderr, err)
		os.Exit(1)
	}

	lines := strings.Split(strings.TrimSpace(string(data)), "\n")
	twos := 0
	threes := 0

	for _, id := range lines {
		freq := map[rune]int{}
		for _, ch := range id {
			freq[ch]++
		}
		hasTwo, hasThree := false, false
		for _, count := range freq {
			if count == 2 {
				hasTwo = true
			}
			if count == 3 {
				hasThree = true
			}
		}
		if hasTwo {
			twos++
		}
		if hasThree {
			threes++
		}
	}

	fmt.Println(twos * threes)
}
