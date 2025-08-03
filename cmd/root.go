package main

import (
	"fmt"
	"os"

	"dictionary-cli/internal"
)

func main() {
	if len(os.Args) < 2 {
		fmt.Println("Usage: define <word>")
		os.Exit(1)
	}

	word := os.Args[1]
	if err := internal.FetchDefinition(word); err != nil {
		fmt.Println("❌", err)
		os.Exit(1)
	}
}
