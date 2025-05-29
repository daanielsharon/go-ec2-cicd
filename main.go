package main

import (
	"fmt"
	"log"
	"net/http"
)

var GreetingName = "Dunia"

func helloHandler(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "Hello, %s! \n", GreetingName)
}

func main() {
	http.HandleFunc("/", helloHandler)
	log.Println("Server starting on port 8080...")
	log.Fatal(http.ListenAndServe(":8080", nil))
}
