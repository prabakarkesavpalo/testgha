#!/bin/bash

# Directory to search for .txt files
SEARCH_DIR="."

# Recipient's email address for encryption
RECIPIENT_EMAIL="pkesavan@palo-it.com"

# Find .txt files and loop through them
find "$SEARCH_DIR" -type f -name "*.txt" | while read -r file; do
    # Construct output filename by adding .gpg extension
    output="${file}.gpg"
    
    # Encrypt the file for the recipient
    gpg --batch --yes --recipient "$RECIPIENT_EMAIL" --output "$output" --encrypt "$file"
    
    # Check if encryption was successful
    if [ $? -eq 0 ]; then
        echo "Encrypted: $file to $output"
    else
        echo "Failed to encrypt: $file"
    fi
done