#!/bin/bash


#gpg --homedir=".gnupg" -o "hello.txt" -d "hello.txt.gpg"

# Directory to search for .gpg files
SEARCH_DIR="."

# Path to the token file
#TOKEN_FILE="$HOME/.my_gpg_token"

# Read the token
#TOKEN=$(cat "$TOKEN_FILE")

# Extension of the decrypted files
=".txt"

# Find .gpg files and loop through them
find "$SEARCH_DIR" -type f -name "*.txt.gpg" | while read -r file; do
    # Construct output filename by removing .gpg extension
    output="${file%.gpg}"
    
    # Decrypt the file using the token
    decryption_output=$(gpg --homedir=".gnupg" -o "$output" -d "$file" 2>&1)
    echo "$decryption_output"
    echo "Opening $output"
    
    # Directly check if "failed" keyword is present in the decryption output
    echo "$decryption_output" | grep -iq "failed"
    if [ $? -eq 0 ]; then
        echo "Error: Decryption failed for $file"
        exit 1
    fi

    # Check if GPG command itself failed
    if [ ${PIPESTATUS[0]} -ne 0 ]; then
        echo "Error: GPG command failed for $file"
        exit 1
    else
        echo "Decrypted: $file"
    fi
done