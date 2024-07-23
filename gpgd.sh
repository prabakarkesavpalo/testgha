#!/bin/bash
# Directory to search for .gpg files; if not, default to current directory ('.')
if [ ! -d "$SEARCH_DIR" ]; then
    SEARCH_DIR="."
fi

# Extension of the decrypted files
INPUT_FILE_EXT=".txt"

# Home directory for GPG
HOME_DIR=".gnupg"

INPUT_FILE="hello.txt.gpg"
DECRYPT_AUTO=false

# Function to decrypt a file
decrypt() {
    local file="$1"
    local homedir="$2"
    # Construct output filename by removing .gpg extension
    output="${file%.gpg}"
    echo $output
    echo $file
    echo $homedir

    # # Decrypt the file
    # gpg --homedir="$homedir" -o "$output" -d "$file"

    # if [ $? -eq 0 ]; then
    #     echo "Decrypted: $file to $output"
    # else
    #     echo "Failed to decrypt: $file"
    # fi
}

if [ "$DECRYPT_AUTO"=false ]; then

    # Check if a specific file is provided as input
    echo "Single file decryption"
    if [ -z "$INPUT_FILE" ]; then
        echo "Error: INPUT_FILE is not set."
        exit 1
    fi
    # Assign a input as file to make it consistent with the loop
    file = $INPUT_FILE

    # Call the decrypt function
    decrypt "$file" "$HOME_DIR"

else
    echo "Multiple file decryption"
    # Find .gpg files and loop through them
    find "$SEARCH_DIR" -type f -name "*$INPUT_FILE_EXT.gpg" | while read -r file; do
        # Call the decrypt function
        decrypt "$file" "$HOME_DIR"
    done
fi

# # Check if a specific file is provided as input
# if [ "$DECRYPT_AUTO" = false ]; then

#     # Check if a specific file is provided as input
#     if [ -z "$INPUT_FILE" ]; then
#     echo "Error: INPUT_FILE is not set."
#     exit 1
#     fi

#     # Assign a input as file
#     file = $INPUT_FILE
#     # Construct output filename by removing .gpg extension
#     output="${file%.gpg}"

#     # Decrypt the provided file
#     gpg --homedir="$HOME_DIR" -o "$output" -d "$file"

#     if [ $? -eq 0 ]; then
#         echo "Decrypted: $INPUT_FILE to $output"
#     else
#         echo "Failed to decrypt: $file"
#     fi
# else
#     # Find .gpg files and loop through them
#     find "$SEARCH_DIR" -type f -name "*$INPUT_FILE_EXT.gpg" | while read -r file; do
#         # Construct output filename by removing .gpg extension
#         output="${file%.gpg}"

#         # Decrypt the file
#         gpg --homedir="$HOME_DIR" -o "$output" -d "$file"
#         if [ $? -eq 0 ]; then
#             echo "Decrypted: $file to $output"
#         else
#             echo "Failed to decrypt: $file"
#         fi
#     done
# fi

#gpg --homedir=".gnupg" -o "hello.txt" -d "hello.txt.gpg"
# # Find .gpg files and loop through them
# find "$SEARCH_DIR" -type f -name "*$INPUT_FILE_EXT.gpg" | while read -r file; do
#     # Construct output filename by removing .gpg extension
#     output="${file%.gpg}"

#     # Decrypt the file
#     gpg --homedir="$HOME_DIR" -o "$output" -d "$file"

#     if [ $? -eq 0 ]; then
#         echo "Decrypted: $file to $output"
#     else
#         echo "Failed to decrypt: $file"
#     fi
# done
