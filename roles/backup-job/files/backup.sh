#!/bin/bash

# Default values for core variables
DEFAULT_SOURCE="/opt"
DEFAULT_DEST="/path/to/backup"
DEFAULT_NUM_BACKUPS=5
DEFAULT_NOTIFY=false  # Default value for notification

# Parse named arguments
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -s|--source) SOURCE="${2:-$DEFAULT_SOURCE}"; shift ;;
        -d|--dest) DEST="${2:-$DEFAULT_DEST}"; shift ;;
        -n|--num-backups) NUM_BACKUPS="${2:-$DEFAULT_NUM_BACKUPS}"; shift ;;
        --notify) NOTIFY=true ;;  # Set NOTIFY to true if --notify flag is passed
        *) echo "Unknown parameter passed: $1"; exit 1 ;;
    esac
    shift
done

# Assign default values if not provided
SOURCE="${SOURCE:-$DEFAULT_SOURCE}"
DEST="${DEST:-$DEFAULT_DEST}"
NUM_BACKUPS="${NUM_BACKUPS:-$DEFAULT_NUM_BACKUPS}"

# Echo assigned values of core variables
echo "Source path: $SOURCE"
echo "Destination path: $DEST"
echo "Number of backups to keep: $NUM_BACKUPS"

# Function to handle curl on success
function handle_success {
    echo "Backup successful"
    # Call your success curl function here
    echo "Backup finished successfully at $(date)" > "$HOME/backup_completion.txt"
    # Check if notification flag is set
    if [ "$NOTIFY" = true ]; then
        # Apprise notification
        curl -X POST -d '{"tag":"backup", "title":"Backup job" ,"body":"Backup job succeeded 💪", "type": "success"}' \
        -H "Content-Type: application/json" \
        http://apprise-api:8000/notify/apprise
    fi
    
}

# Function to handle curl on failure
function handle_failure {
    echo "Backup failed"
    # Call your failure curl function here
    echo "Backup failed at $(date)" > "$HOME/backup_completion.txt"
    # Check if notification flag is set
    if [ "$NOTIFY" = true ]; then
        # Apprise notification
        curl -X POST -d '{"tag":"backup", "title":"Backup job" ,"body":"Backup job failed 🚫", "type": "error"}' \
        -H "Content-Type: application/json" \
        http://apprise-api:8000/notify/apprise
    fi
    
}

# Check if source and target paths are available and writable
if [ ! -d "$SOURCE" ] || [ ! -w "$SOURCE" ]; then
    echo "Source path is not available or writable"
    handle_failure
    exit 1
fi

if [ ! -d "$DEST" ] || [ ! -w "$DEST" ]; then
    echo "Destination path is not available or writable"
    handle_failure
    exit 1
fi

# Store date and time of backup
backup_date=$(date +"%Y-%m-%d_%H-%M-%S")
backup_file="backup_${backup_date}.tar.gz"

# Archive and compress contents of source path
tar -czf "${DEST}/${backup_file}" -C "$SOURCE" .

# Check if the backup was successful
if [ $? -eq 0 ]; then
    handle_success
else
    handle_failure
fi

# Rotate backups if the count exceeds the maximum threshold
backup_count=$(ls -1 "$DEST" | grep "^backup_" | wc -l)
if [ $backup_count -gt $NUM_BACKUPS ]; then
    # Determine how many backups to remove
    backups_to_remove=$((backup_count - NUM_BACKUPS))
    
    # Remove the oldest backups
    for (( i=1; i<=backups_to_remove; i++ )); do
        oldest_backup=$(ls -1t "$DEST" | grep "^backup_" | tail -n 1)
        rm -f "${DEST}/${oldest_backup}"
        echo "Removed old backup: $oldest_backup"
    done
fi
