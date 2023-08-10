#!/bin/bash

# Define the Docker Compose directory and file
compose_dir="./HomeServiceDocker"
compose_file="docker-compose.yml"

# Change to project directory
cd "$compose_dir"

# Destination folder for the backups
backup_dir="./backups"
timestamp=$(date +"%Y%m%d%H%M%S")
backup_file="backup_$timestamp.tar.gz"

# Folders to backup
folders=("envs" "data" "config")

# Stop the Docker Compose services
echo "Stopping Docker Compose services..."
docker-compose -f "$compose_file" down

# Create the destination folder if it doesn't exist
mkdir -p "$backup_dir"

# Generate the backup
tar -czvf "$backup_dir/$backup_file" "${folders[@]}"

# Check if the backup was successful
if [ $? -eq 0 ]; then
  echo "Backup successfully generated: $backup_dir/$backup_file"
  
  # Upload the backup to Google Drive
  echo "Uploading backup to Google Drive..."
  rclone copy --update "$backup_dir/$backup_file" "gdrive:backups"

  if [ $? -eq 0 ]; then
    echo "Backup successfully uploaded to Google Drive."
  else
    echo "Error while uploading backup to Google Drive."
  fi
else
  echo "Error while generating the backup."
fi

# Always restart the Docker Compose services at the end
echo "Restarting Docker Compose services..."
docker-compose -f "$compose_file" up -d