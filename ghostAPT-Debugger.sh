#!/bin/bash

# === Step 1: File Selection ===
SCRIPT_PATH=$(zenity --file-selection \
                    --title="Select a Script to Debug" \
                    --file-filter="Shell Scripts | *.sh" \
                    --file-filter="Ghost Scripts | *.ghost" \
                    --file-filter="All Files | *")

# Exit if no file selected
if [ -z "$SCRIPT_PATH" ] || [ ! -f "$SCRIPT_PATH" ]; then
    zenity --error --text="No valid file selected. Exiting."
    exit 1
fi

# Extract just the filename
FILENAME=$(basename "$SCRIPT_PATH")

# === Step 2: Set Log File ===
LOG_FILE="script.log"  # Default fallback

if [ "$FILENAME" = "ghostAPT.sh" ]; then
    DESKTOP_DIR="$HOME/Desktop"
    LOG_FILE="$DESKTOP_DIR/ghostAPT-debugger.log"

    # Fallback if Desktop doesn't exist
    if [ ! -d "$DESKTOP_DIR" ]; then
        zenity --warning --text="Desktop directory not found. Using home folder."
        LOG_FILE="$HOME/ghostAPT-debugger.log"
    fi
fi

# === Step 3: Mode Selection for ghostAPT.sh ===
if [ "$FILENAME" = "ghostAPT.sh" ]; then
    MODE=$(zenity --list --title="Debug Mode" --text="Select debug mode for $FILENAME:" \
                  --column="Select" \
                  " " \
                  "run" \
                  "install" \
                  "testing")

    if [ -z "$MODE" ]; then
        zenity --error --text="No mode selected. Exiting."
        exit 1
    fi

    # Build command: bash -x ghostAPT.sh [mode] + log
    FULL_COMMAND="bash -x '$SCRIPT_PATH' '$MODE' 2>&1 | tee '$LOG_FILE'"
else
    # Regular script: debug without arguments
    FULL_COMMAND="bash -x '$SCRIPT_PATH' 2>&1 | tee '$LOG_FILE'"
fi

# === Step 4: Notify and Launch in Konsole ===
zenity --info --text="Debugging: $FILENAME\nLog saved to:\n$LOG_FILE" --timeout=3

konsole -e bash -c "$FULL_COMMAND; echo '--- Debugging session ended ---'; read -p 'Press Enter to close...'"
