#!/bin/bash

# Directory to process (current directory)
DIR=$(pwd)

# Output file
OUTPUT="resume.txt"

# Clear the output file if it exists
> $OUTPUT

# Function to process each file
process_file() {
  local file_path=$1
  echo "Processing $file_path"
  echo "File: $file_path" >> $OUTPUT
  cat "$file_path" >> $OUTPUT
  echo -e "\n\n" >> $OUTPUT
}

# Export the function to be used by find
export -f process_file
export OUTPUT

# Find all files excluding specified patterns and process them
find $DIR -type f \
  ! -path "*/node_modules/*" \
  ! -path "*/.github/*" \
  ! -path "*/.git/*" \
  ! -path "*/.next/*" \
  ! -name "README*" \
  ! -name "package-lock.json" \
  ! -name "LICENSE" \
  ! -name ".gitignore" \
  ! -name "*.svg" \
  ! -name "*.woff" \
  ! -name "*.ico" \
  ! -name "*.css" \
  ! -name ".env.example" \
  ! -name "*.Dockerfile" \
  -exec bash -c 'process_file "$0"' {} \;

echo "All files have been processed and written to $OUTPUT"
