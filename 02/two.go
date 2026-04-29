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

	for i, a := range lines {
		for _, b := range lines[i+1:] {
			diffCount := 0
			diffIdx := 0
			for k := 0; k < len(a); k++ {
				if a[k] != b[k] {
					diffCount++
					diffIdx = k
				}
				if diffCount > 1 {
					break
				}
			}
			if diffCount == 1 {
				fmt.Println(a[:diffIdx] + a[diffIdx+1:])
				return
			}
		}
	}
}
