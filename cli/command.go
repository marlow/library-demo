package cli

import "github.com/marlow/library-demo/models"

// Command represents a type that used by the example app cli.
type Command func(*models.Stores, []string) error
