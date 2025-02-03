#!/bin/bash

# Define MySQL credentials and database name
MYSQL_USER="root"
MYSQL_PASSWORD="raspberry4"
MYSQL_DATABASE="test"

# Define CSV file paths
CSV_FILE="/home/pi4r/Desktop/linuxCoursework/cryptocurrency_data.csv"
CSV_FILE_2="/home/pi4r/Desktop/linuxCoursework/cryptocurrency_data3.csv"
CSV_FILE_3="/home/pi4r/Desktop/linuxCoursework/EthTracker.csv"
CSV_FILE_4="/home/pi4r/Desktop/linuxCoursework/EthTracker2.csv"

# Define the SQL statements to create tables
SQL_CREATE_TABLE="CREATE TABLE IF NOT EXISTS Bitcoin_price (timestamp TIMESTAMP, currency VARCHAR(50), price DECIMAL(10,2));"
SQL_CREATE_TABLE_2="CREATE TABLE IF NOT EXISTS Bitcoin_data (timestamp TIMESTAMP, ratio DECIMAL(10, 2), circulating_supply BIGINT, total_supply BIGINT, max_supply BIGINT, fully_diluted_market_cap DECIMAL(20, 2));"
SQL_CREATE_TABLE_3="CREATE TABLE IF NOT EXISTS Ethereum_price (timestamp TIMESTAMP, currency VARCHAR(50), price DECIMAL(10,2));"
SQL_CREATE_TABLE_4="CREATE TABLE IF NOT EXISTS Ethereum_data (timestamp TIMESTAMP, ratio DECIMAL(10, 2), circulating_supply BIGINT, total_supply BIGINT, max_supply VARCHAR(5), fully_diluted_market_cap DECIMAL(20, 2));"

# Define the SQL statements to insert data from CSV files
SQL_INSERT_DATA="LOAD DATA LOCAL INFILE '$CSV_FILE' INTO TABLE Bitcoin_price FIELDS TERMINATED BY ',' ENCLOSED BY '\"' LINES TERMINATED BY '\n' IGNORE 1 LINES;"
SQL_INSERT_DATA_2="LOAD DATA LOCAL INFILE '$CSV_FILE_2' INTO TABLE Bitcoin_data FIELDS TERMINATED BY ',' ENCLOSED BY '\"' LINES TERMINATED BY '\n' IGNORE 1 LINES;"
SQL_INSERT_DATA_3="LOAD DATA LOCAL INFILE '$CSV_FILE_3' INTO TABLE Ethereum_price FIELDS TERMINATED BY ',' ENCLOSED BY '\"' LINES TERMINATED BY '\n' IGNORE 1 LINES;"
SQL_INSERT_DATA_4="LOAD DATA LOCAL INFILE '$CSV_FILE_4' INTO TABLE Ethereum_data FIELDS TERMINATED BY ',' ENCLOSED BY '\"' LINES TERMINATED BY '\n' IGNORE 1 LINES;"

# Function to execute MySQL commands with error checking
execute_mysql_command() {
    local command="$1"
    echo "Executing MySQL command: $command"
    if ! mysql -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" -D"$MYSQL_DATABASE" -e "$command"; then
        echo "Error executing MySQL command: $command"
        exit 1
    fi
}

# Execute SQL commands with error checking
execute_mysql_command "$SQL_CREATE_TABLE"
execute_mysql_command "$SQL_INSERT_DATA"
execute_mysql_command "$SQL_CREATE_TABLE_2"
execute_mysql_command "$SQL_INSERT_DATA_2"
execute_mysql_command "$SQL_CREATE_TABLE_3"
execute_mysql_command "$SQL_INSERT_DATA_3"
execute_mysql_command "$SQL_CREATE_TABLE_4"
execute_mysql_command "$SQL_INSERT_DATA_4"
