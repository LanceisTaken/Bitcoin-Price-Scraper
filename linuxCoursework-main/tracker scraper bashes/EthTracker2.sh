#!/bin/bash

# Redirect output to a log file
log_file="/home/pi4r/Desktop/linuxCoursework/cron4.log"
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

# Extract the main HTML tag containing all five values
MAIN_TAG=$(echo "$HTML" | grep -Eo '<dd class="sc-f70bb44c-0 bCgkcs base-text">([^<]+)' )

# Check if extraction was successful
if [ -z "$MAIN_TAG" ]; then
    echo "Error: Failed to extract main HTML tag." >> "$log_file"
    exit 1
fi

# Extracting and formatting each value separately
# Ratio
RATIO=$(echo "$MAIN_TAG" | sed -n '1p' | sed 's/<[^>]*>//g' | tr -d '%')

# Check if ratio extraction was successful
if [ -z "$RATIO" ]; then
    echo "Error: Failed to extract ratio value." >> "$log_file"
    exit 1
fi

# Circulating Supply
CIRCULATING_SUPPLY=$(echo "$MAIN_TAG" | sed -n '2p' | sed 's/<[^>]*>//g' | tr -d 'ETH,')

# Check if circulating supply extraction was successful
if [ -z "$CIRCULATING_SUPPLY" ]; then
    echo "Error: Failed to extract circulating supply value." >> "$log_file"
    exit 1
fi

# Total Supply
TOTAL_SUPPLY=$(echo "$MAIN_TAG" | sed -n '3p' | sed 's/<[^>]*>//g' | tr -d 'ETH,')

# Check if total supply extraction was successful
if [ -z "$TOTAL_SUPPLY" ]; then
    echo "Error: Failed to extract total supply value." >> "$log_file"
    exit 1
fi

# Max Supply
MAX_SUPPLY=$(echo "$MAIN_TAG" | sed -n '4p' | sed 's/<[^>]*>//g' | tr -d 'ETH,')

# Check if max supply extraction was successful
if [ -z "$MAX_SUPPLY" ]; then
    echo "Error: Failed to extract max supply value." >> "$log_file"
    exit 1
fi

# Fully Diluted Market Cap
FULLY_DILUTED_MARKET_CAP=$(echo "$MAIN_TAG" | sed -n '5p' | sed 's/<[^>]*>//g' | tr -d 'ETH,$')

# Check if fully diluted market cap extraction was successful
if [ -z "$FULLY_DILUTED_MARKET_CAP" ]; then
    echo "Error: Failed to extract fully diluted market cap value." >> "$log_file"
    exit 1
fi

# Print the extracted data
echo "$RATIO"
echo "$CIRCULATING_SUPPLY"
echo "$TOTAL_SUPPLY"
echo "$MAX_SUPPLY"
echo "$FULLY_DILUTED_MARKET_CAP"

# Store the extracted data in a file
echo "$(date +"%Y-%m-%d %H:%M:%S"),$RATIO",$CIRCULATING_SUPPLY",$TOTAL_SUPPLY",$MAX_SUPPLY",$FULLY_DILUTED_MARKET_CAP" >> /home/pi4r/Desktop/linuxCoursework/EthTracker2.csv

# Check if data was successfully stored
if [ $? -ne 0 ]; then
    echo "Error: Failed to store data in CSV file." >> "$log_file"
    exit 1
fi

echo "Data stored successfully."
