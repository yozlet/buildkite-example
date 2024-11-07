package main

import (
	"testing"
)

// TestMainName calls main.main() with a name, checking
// for a valid string printed to STDOUT.
func TestMainName(t *testing.T) {
	name := "Doris"
	want := "Hello, Doris!"

	got := FmtHelloName(name)
	if got != want {
		t.Errorf("got %q want %q", got, want)
	}
}
