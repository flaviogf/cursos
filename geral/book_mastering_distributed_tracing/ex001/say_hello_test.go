package main

import (
	"bytes"
	"context"
	"testing"
)

type FakePersonRepository struct{}

func (r *FakePersonRepository) GetPerson(ctx context.Context, name string) (*Person, error) {
	if name == "Frank" {
		return &Person{"Frank", "How are you doing?"}, nil
	}

	return nil, PersonDoesNotFoundErr
}

func TestSayHello(t *testing.T) {
	testCases := []struct {
		Writer     *bytes.Buffer
		PersonName string
		Repository PersonRepository
		Err        error
		Result     string
	}{
		{
			Writer:     &bytes.Buffer{},
			PersonName: "Frank",
			Repository: &FakePersonRepository{},
			Err:        nil,
			Result:     "Hello, Frank! How are you doing?",
		},
		{
			Writer:     &bytes.Buffer{},
			PersonName: "Matt",
			Repository: &FakePersonRepository{},
			Err:        nil,
			Result:     "Hello, Matt!",
		},
	}

	for _, tc := range testCases {
		err := SayHello(context.TODO(), tc.Writer, tc.Repository, tc.PersonName)

		if err != tc.Err {
			t.Errorf("got: %v, want: %v\n", err, tc.Err)
		}

		result := tc.Writer.String()

		if result != tc.Result {
			t.Errorf("got: %s, want: %s\n", result, tc.Result)
		}
	}
}
