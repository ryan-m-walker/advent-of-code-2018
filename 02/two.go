package main

import (
	"fmt"
	"os"
	"strings"
)

func findCommon(ids []string) string {
	for i, id1 := range ids {
		for _, id2 := range ids[i+1:] {
			diffCount := 0
			diffIdx := 0
			for j := 0; j < len(id1); j++ {
				if id1[j] != id2[j] {
					diffCount++
					diffIdx = j
				}
				if diffCount > 1 {
					break
				}
			}
			if diffCount == 1 {
				return id1[:diffIdx] + id1[diffIdx+1:]
			}
		}
	}
	return ""
}

func main() {
	data, err := os.ReadFile("input.txt")
	if err != nil {
		fmt.Fprintln(os.Stderr, err)
		os.Exit(1)
	}

	ids := strings.Split(strings.TrimSpace(string(data)), "\n")
	fmt.Println(findCommon(ids))
}
