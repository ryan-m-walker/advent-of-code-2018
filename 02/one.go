package main

import (
	"fmt"
	"os"
	"strings"
)

func checksum(ids []string) int {
	twos := 0
	threes := 0

	for _, id := range ids {
		freq := map[rune]int{}
		for _, ch := range id {
			freq[ch]++
		}

		hasTwo := false
		hasThree := false
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

	return twos * threes
}

func main() {
	data, err := os.ReadFile("input.txt")
	if err != nil {
		fmt.Fprintln(os.Stderr, err)
		os.Exit(1)
	}

	ids := strings.Split(strings.TrimSpace(string(data)), "\n")
	fmt.Println(checksum(ids))
}
