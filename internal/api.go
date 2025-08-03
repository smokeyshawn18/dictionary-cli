// internal/api.go
package internal

import (
	"encoding/json"
	"fmt"
	"net/http"
)

// FetchDefinition fetches the word's definition from the public dictionary API
func FetchDefinition(word string) error {
	url := fmt.Sprintf("https://api.dictionaryapi.dev/api/v2/entries/en/%s", word)

	resp, err := http.Get(url)
	if err != nil {
		return fmt.Errorf("failed to fetch word: %w", err)
	}
	defer resp.Body.Close()

	if resp.StatusCode != http.StatusOK {
		return fmt.Errorf("word not found or API error: %s", word)
	}

	var entries []Entry
	if err := json.NewDecoder(resp.Body).Decode(&entries); err != nil {
		return fmt.Errorf("failed to parse response: %w", err)
	}

	fmt.Printf("📖 Word: %s\n", entries[0].Word)
	if entries[0].Phonetic != "" {
		fmt.Printf("🔊 Pronunciation: %s\n", entries[0].Phonetic)
	}

	for _, meaning := range entries[0].Meanings {
		fmt.Printf("\n🔹 %s:\n", meaning.PartOfSpeech)
		for _, def := range meaning.Definitions {
			fmt.Printf("   - %s\n", def.Definition)
		}
	}

	return nil
}
