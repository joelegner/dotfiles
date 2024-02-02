#!/usr/bin/env zsh

gogo() {
    if [[ $# -ne 1 ]]; then
        echo "Usage: gogo <directory_name>"
        return 1
    fi

    local dir_name="$1"

    # Step 1: Make a directory with the given name
    mkdir "$dir_name" || { echo "Failed to create directory $dir_name"; return 1; }

    # Step 2: Change to the new directory and stay there
    cd -P "$dir_name" || { echo "Failed to change to directory $dir_name"; return 1; }

    # Step 3: Run `go mod init <argument>`
    go mod init "$dir_name" || { echo "Failed to initialize Go module"; return 1; }

    # Step 4: Create the main.go file
    cat > main.go <<EOF
package main

import "fmt"

func main() {
    fmt.Println("Hello, Go!")
}
EOF
}

# Call the function with the provided arguments
gogo "$@"

