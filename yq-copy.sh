#!/bin/bash

# Define the name to search for
name_to_search="transaction"

# Use yq to find the matching release and replace its values with the content of a1.yaml
yq eval '
  (.releases[] | select(.name == "'$name_to_search'")) = load("a1.yaml")
' a.yaml > b.yaml
