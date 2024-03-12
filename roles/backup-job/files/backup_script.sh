#!/bin/bash

# Create the backup destination directory if it doesn't exist
if [ ! -d "$backup_destination" ]; then
  mkdir -p "$backup_destination"
fi

# Perform the backup
backup_filename="backup_$(date '+%Y%m%d').tar.gz"
tar czf "$backup_destination/$backup_filename" "$source_directory"


### NEW VERSION ###

#!/bin/bash

# Check if the correct number of positional arguments are provided
if [ "$#" -ne 3 ]; then
  echo "Usage: $0 <source_directory> <backup_destination> <log_file>"
  exit 1
fi


# Source directory to backup
source_directory="$1"

# Destination directory for backups
backup_destination="$2"

# Log file for errors
log_file="$3"


# Maximum number of backups to retain
max_backups=5  # Adjust this to the desired number of backups to keep


# Check if /mnt/path exists
if [ ! -d "/mnt/path" ]; then
  echo "/mnt/path does not exist. Backup cannot proceed." | tee -a "$log_file"
  exit 1
fi


# Check if backup destination exists
if [ ! -d "$backup_destination" ]; then
  echo "Backup destination directory does not exist. Creating it." | tee -a "$log_file"
  mkdir -p "$backup_destination"
fi

# Perform the backup
# backup_filename="backup_$(date '+%Y%m%d').tar.gz"
# tar czf "$backup_destination/$backup_filename" "$source_directory"


# Perform the backup
backup_filename="backup_$(date '+%Y%m%d').tar.gz"
if tar czf "$backup_destination/$backup_filename" "$source_directory"; then
  # Backup successful, remove old backups if there are more than max_backups
  if [ "$(ls -1 "$backup_destination" | wc -l)" -gt "$max_backups" ]; then
    ls -1t "$backup_destination" | tail -n +"$((max_backups + 1))" | xargs -I {} rm -f "$backup_destination/{}"
  fi
else
  # Backup failed, create a status file and log the error
  touch "$backup_destination/.dot"
  echo "Backup failed at $(date '+%Y-%m-%d %H:%M:%S')" >> "$log_file"
fi

# Remove old backups if there are more than max_backups
# if [ "$(ls -1 "$backup_destination" | wc -l)" -gt "$max_backups" ]; then
#   ls -1t "$backup_destination" | tail -n +"$((max_backups + 1))" | xargs -I {} rm -f "$backup_destination/{}"
# fi
