#!/bin/bash

echo "Starting btsync Docker container..."

# Only proceed if we have a sync key
if [ -z "$SYNCKEY" ]; then
    echo "Using Sync Key $SYNCKEY"
    echo "No sync key found. Exiting."
    exit 1
fi

# Only proceed if a hostname was passed
if [ -z "$MYHOSTNAME" ]; then
    echo "No hostname defined. Exiting."
    exit 1
fi

# Do not accept read-write keys
# These keys starts with A or D
if [[ "$SYNCKEY" =~ ^(A|D).* ]]; then
  echo -e"\n\nRead-write key found.\nPlease only use read-only keys.\n\nAborting.\n\n"
  exit 1
fi

# Make sure the folder exists
mkdir -p /data
