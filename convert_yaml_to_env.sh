#!/bin/bash

# Function to process YAML and export variables
process_yaml() {
    local prefix=$1
    local yaml=$2

    # Process scalar values
    eval $(echo "$yaml" | yq eval '.. | select((tag == "!!map" or tag == "!!seq") | not) | 
        (path | join("_")) + "=" + @sh' -)

    # Process lists
    while IFS= read -r line; do
        if [[ $line =~ ^([^=]+)=(.*)$ ]]; then
            key="${BASH_REMATCH[1]}"
            value="${BASH_REMATCH[2]}"
            # Remove quotes from the value
            value="${value//\"/}"
            # Export the variable
            export "${prefix}${key}"="$value"
            # For lists, also export each item with an index
            if [[ $key =~ _[0-9]+$ ]]; then
                base_key="${key%_*}"
                if [[ ! -v "${prefix}${base_key}" ]]; then
                    export "${prefix}${base_key}="
                fi
                export "${prefix}${base_key}=${!prefix${base_key}}${!prefix${base_key}:+|}$value"
            fi
        fi
    done < <(echo "$yaml" | yq eval '.. | select((tag == "!!map" or tag == "!!seq") | not) | 
        (path | join("_")) + "=" + .' - | sed 's/^/YAML_/')
}

# Read YAML file
yaml_content=$(cat config.yaml)

# Process YAML content
process_yaml "YAML_" "$yaml_content"

# Print all exported variables
env | grep '^YAML_'