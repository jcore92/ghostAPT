#!/bin/bash

# Define the signature ID
signatureid="The Ghost Team"

# Delete the master file if it exists
    if [ -f "ghostAPT_signatures.sha256" ]; then
        rm "ghostAPT_signatures.sha256"
    fi

# Function to process files
process_file() {
    local file="$1"
    local base_name=$(basename "${file%.ghost}")

    # Generate the SHA-256 checksum for the file
    checksum=$(sha256sum "$file" | cut -d ' ' -f1)

    # Output the signature, base name, and checksum to the master file using tee -a
    echo "${checksum} $signatureid (${base_name})" >> ghostAPT_signatures.sha256
}

# Find all .ghost files recursively in the current directory
find -L . -type f -name "*.ghost" | while read -r file; do
    if [[ -f "$file" ]]; then
        process_file "$file"
    fi
done

# Output the SHA-256 checksums for all .ghost files recursively
echo "sha256sum for all .ghost files recursively:"
find -L . -type f -name "*.ghost" -exec sha256sum {} \;

# Generate the SHA-256 hash of the ghost_signatures.sha256 file
sha256sum ghostAPT_signatures.sha256 | cut -d ' ' -f1 > key.sha256

# Check if the key.sha256 file was successfully created
if [ -f "key.sha256" ]; then
    echo "SHA-256 signature successfully created: key.sha256"
else
    echo "Error: Failed to create SHA-256 signature."
    exit 1
fi

read -p "Press enter to continue..."
