package main

import (
	"fmt"
	"log"
	"net/http"
	"os"
)

func main() {
	port := "80"
	if portFromEnv := os.Getenv("PORT"); portFromEnv != "" {
		port = portFromEnv
	}
	// register hello function to handle all requests
	server := http.NewServeMux()
	server.HandleFunc("/", hello)

	// start the web server on port and accept requests
	log.Printf("Server listening on port %s", port)
	err := http.ListenAndServe(":"+port, server)
	log.Fatal(err)
}

// hello responds to the request with a plain-text "Hello, world" message.
func hello(w http.ResponseWriter, r *http.Request) {
	env := "BASE"
	if envFromEnv := os.Getenv("ENVIRONMENT"); envFromEnv != "" {
		env = envFromEnv
	}
	log.Printf("Serving request: %s", r.URL.Path)
	host, _ := os.Hostname()
	fmt.Fprintf(w, "Hello, Mars!\n")
	fmt.Fprintf(w, "Version: 0.4.1\n")
	fmt.Fprintf(w, "Hostname: %s\n", host)
	fmt.Fprintf(w, "Environment: %s\n", env)
}