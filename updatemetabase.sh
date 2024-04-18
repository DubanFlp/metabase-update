#!/bin/bash

# Check if the script is called with the correct number of arguments
if [ $# -ne 2 ]; then
    echo "Usage: $0 <backup_suffix> <metabase_version>"
    exit 1
fi

backup_suffix=$1
metabase_version=$2

# Stop Metabase and Nginx services
sudo systemctl stop metabase
sudo systemctl stop nginx

# Move the previous Metabase file and download the new one
sudo mv /opt/metabase/metabase.jar "/opt/metabase/metabase$backup_suffix.jar"
sudo wget -O "/opt/metabase/metabase.jar" "https://downloads.metabase.com/$metabase_version/metabase.jar"

# Change owner and permissions of the Metabase directory
sudo chown -R metabase:metabase /opt/metabase
sudo chmod -R 755 /opt/metabase

# Start Metabase and Nginx services
sudo systemctl start metabase
sudo systemctl start nginx