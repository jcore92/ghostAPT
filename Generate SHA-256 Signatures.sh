#!/bin/bash

# Get the directory where the script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR" || exit 1

# Define the signature ID
signatureid="The Ghost Team"
signature_file="ghostAPT_signatures.sha256"
key_file="key.sha256"

# Show folder selection dialog using zenity
FOLDERS=$(zenity --file-selection \
                --title="Select Folder(s) to Scan for .ghost Files" \
                --multiple \
                --directory 2>/dev/null)

# Exit if no folder selected
if [ -z "$FOLDERS" ]; then
    zenity --error --text="No folder selected. Exiting." --title="Selection Cancelled"
    exit 1
fi

# Convert colon-separated list to array
IFS=':' read -ra FOLDER_ARRAY <<< "$FOLDERS"

# Check if signature file exists and ask whether to append or overwrite
if [ -f "$signature_file" ]; then
    zenity --question \
           --text="Signature file already exists.\nDo you want to append to it?\n(Choose No to overwrite.)" \
           --title="Append or Overwrite?"
    if [ $? -eq 0 ]; then
        APPEND=true
    else
        > "$signature_file"  # Truncate file (overwrite)
        APPEND=false
    fi
else
    APPEND=false
    > "$signature_file"  # Create empty file
fi

# Function to process a single file
process_file() {
    local file="$1"
    local base_name=$(basename "${file%.ghost}")

    # Generate SHA-256 checksum
    if checksum=$(sha256sum "$file" 2>/dev/null | cut -d' ' -f1); then
        echo "${checksum} $signatureid [${base_name}]" >> "$signature_file"
    else
        zenity --warning --text="Failed to compute checksum for: $file" --title="Checksum Error"
    fi
}

# Counter for found files
file_count=0

# Process each selected folder
for FOLDER in "${FOLDER_ARRAY[@]}"; do
    if [ -d "$FOLDER" ]; then
        while IFS= read -r -d '' file; do
            process_file "$file"
            ((file_count++))
        done < <(find -L "$FOLDER" -type f -name "*.ghost" -print0)
    fi
done

# Show results
if [ $file_count -eq 0 ]; then
    zenity --info --text="No .ghost files found in the selected folder(s)." --title="No Files Found"
else
    zenity --info --text="Processed $file_count .ghost file(s).\nSignatures saved to:\n$SCRIPT_DIR/$signature_file" --title="Success"
fi

# Output checksums to terminal
echo "sha256sum for all .ghost files recursively:"
find -L "${FOLDER_ARRAY[@]}" -type f -name "*.ghost" -exec sha256sum {} \;

# Generate the hash of the signature file
if sha256sum "$signature_file" | cut -d' ' -f1 > "$key_file"; then
    echo "SHA-256 signature successfully created: $key_file"
else
    zenity --error --text="Failed to create hash of signature file." --title="Error"
    echo "Error: Failed to create SHA-256 signature."
    exit 1
fi

zenity --info --text="Process complete!\n\nSignature file: $signature_file\nKey hash: $key_file" --title="Operation Complete"
