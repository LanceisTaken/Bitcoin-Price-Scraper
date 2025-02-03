#!/bin/bash

# Redirect output to a log file
exec >> /home/pi4r/Desktop/linuxCoursework/cron.log 2>&1

# Define the URL of the cryptocurrency website to scrape
URL="https://coinmarketcap.com/currencies/bitcoin/?timestamp=$(date +%s)"

# Fetch the webpage content using curl 
HTML=$(curl -s "$URL")

# Check if curl command was successful
if [ $? -ne 0 ]; then
    echo "Error: Failed to fetch webpage content." >> "$log_file"
    exit 1
fi

# Extract the Bitcoin price (text content within the span)
PRICE=$(echo "$HTML" | grep -Eo '<span class="sc-f70bb44c-0 jxpCgO base-text">([^<]+)' | cut -d '>' -f2)

# Check if extraction was successful
if [ -z "$PRICE" ]; then
    echo "Error: Failed to extract Bitcoin price." >> "$log_file"
    exit 1
fi

# Remove commas and dollar sign from the price value
PRICE=$(echo "$PRICE" | tr -d ',\$')

# Print the extracted data
echo "Bitcoin Price: $PRICE"

# Store the extracted data in a file
echo "$(date +"%Y-%m-%d %H:%M:%S"),Bitcoin,$PRICE" >> /home/pi4r/Desktop/linuxCoursework/cryptocurrency_data.csv

# Check if data was successfully stored
if [ $? -ne 0 ]; then
    echo "Error: Failed to store data in CSV file." >> "$log_file"
    exit 1
fi

echo "Data stored successfully."