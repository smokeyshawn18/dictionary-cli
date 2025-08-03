// internal/types.go
package internal

// Definition represents a word's meaning
type Definition struct {
	Definition string `json:"definition"`
}

// Meaning represents part of speech and its definitions
type Meaning struct {
	PartOfSpeech string       `json:"partOfSpeech"`
	Definitions  []Definition `json:"definitions"`
}

// Entry represents the full dictionary response for a word
type Entry struct {
	Word     string   `json:"word"`
	Phonetic string   `json:"phonetic"`
	Meanings []Meaning `json:"meanings"`
}
