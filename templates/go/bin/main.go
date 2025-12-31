package main

import (
	"fmt"
	"os"

	"github.com/spf13/cobra"
)

var rootCmd = &cobra.Command{
	Use:   "{{PROJECT_NAME}}",
	Short: "{{PROJECT_NAME}} CLI",
	Run: func(cmd *cobra.Command, args []string) {
		fmt.Println("Hello from {{PROJECT_NAME}}!")
	},
}

func main() {
	if err := rootCmd.Execute(); err != nil {
		fmt.Fprintln(os.Stderr, err)
		os.Exit(1)
	}
}
