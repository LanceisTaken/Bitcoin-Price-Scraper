#!/bin/bash

# Redirect output to a log file
log_file="/home/pi4r/Desktop/linuxCoursework/cron3.log"
exec >> "$log_file" 2>&1

# Define the URL of the cryptocurrency website to scrape
URL="https://coinmarketcap.com/currencies/ethereum/?timestamp=$(date +%s)"

# Fetch the webpage content using curl 
HTML=$(curl -s "$URL")

# Check if curl command was successful
if [ $? -ne 0 ]; then
    echo "Error: Failed to fetch webpage content." >> "$log_file"
    exit 1
fi

# Extract the Ethereum price (text content within the span)
PRICE=$(echo "$HTML" | grep -Eo '<span class="sc-f70bb44c-0 jxpCgO base-text">([^<]+)' | cut -d '>' -f2)

# Check if extraction was successful
if [ -z "$PRICE" ]; then
    echo "Error: Failed to extract Ethereum price." >> "$log_file"
    exit 1
fi

# Remove commas and dollar sign from the price value
PRICE=$(echo "$PRICE" | tr -d ',\$')

# Check if price processing was successful
if [ -z "$PRICE" ]; then
    echo "Error: Failed to process Ethereum price." >> "$log_file"
    exit 1
fi

# Print the extracted data
echo "Ethereum Price: $PRICE"

# Store the extracted data in a file
echo "$(date +"%Y-%m-%d %H:%M:%S"),Ethereum,$PRICE" >> /home/pi4r/Desktop/linuxCoursework/EthTracker.csv

# Check if data was successfully stored
if [ $? -ne 0 ]; then
    echo "Error: Failed to store data in CSV file." >> "$log_file"
    exit 1
fi

echo "Data stored successfully."
