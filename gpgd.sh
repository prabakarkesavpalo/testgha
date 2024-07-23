#!/bin/bash


#gpg --homedir=".gnupg" -o "hello.txt" -d "hello.txt.gpg"

# Directory to search for .gpg files
SEARCH_DIR="."

# Path to the token file
#TOKEN_FILE="$HOME/.my_gpg_token"

# Read the token
#TOKEN=$(cat "$TOKEN_FILE")

# Extension of the decrypted files
INPUT_EXT=".txt"

# Find .gpg files and loop through them
find "$SEARCH_DIR" -type f -name "*.txt.gpg" | while read -r file; do
    # Construct output filename by removing .gpg extension
    output="${file%.gpg}"
    
    # Decrypt the file using the token
    gpg --homedir=".gnupg" -o "$output" -d "$file"
    echo "$decryption_output"
    echo "Opening $output"
    
    # Check if encryption was successful
    if [ $? -eq 0 ]; then
        echo "Encrypted: $file to $output"
    else
        echo "Failed to encrypt: $file"
    fi
done