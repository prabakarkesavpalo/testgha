#!/bin/bash


#gpg --homedir=".gnupg" -o "hello.txt" -d "hello.txt.gpg"

# Directory to search for .gpg files
SEARCH_DIR="."

# Path to the token file
#TOKEN_FILE="$HOME/.my_gpg_token"

# Read the token
#TOKEN=$(cat "$TOKEN_FILE")

# Find .gpg files and loop through them
find "$SEARCH_DIR" -type f -name "*.gpg" | while read -r file; do
    # Construct output filename by removing .gpg extension
    output="${file%.gpg}"
    
    # Decrypt the file using the token
    gpg --homedir=".gnupg" -o "$output" -d "$file"
    #echo "$TOKEN" | gpg --batch --yes --passphrase-fd 0 --output "$output" --decrypt "$file"
    echo "Opening $file"
    cat $file
    # Check if decryption was successful
    if [ $? -eq 0 ]; then
        echo "Decrypted: $file"
    else
        echo "Failed to decrypt: $file"
    fi
done