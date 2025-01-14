package dictionary

import "testing"

func TestSearch(t *testing.T) {
	dictionary := Dictionary{"test": "it is just a simple test"}
	got, _ := dictionary.Search("test")
	assertString(t, got, "it is just a simple test")

	t.Run("when the word does not exist", func(t *testing.T) {
		dictionary := Dictionary{}
		_, err := dictionary.Search("test")
		assertError(t, err, ErrNotFound)
	})
}

func assertString(t testing.TB, got, want string) {
	t.Helper()

	if got != want {
		t.Errorf("got: %s, want: %s", got, want)
	}
}

func assertError(t testing.TB, got, want error) {
	t.Helper()

	if got == nil {
		t.Fatal("didn't get an error but wanted one")
	}

	if got != want {
		t.Errorf("got: %q, want: %q", got, want)
	}
}
