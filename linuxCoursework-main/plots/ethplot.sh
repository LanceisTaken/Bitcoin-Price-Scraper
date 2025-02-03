#!/usr/bin/gnuplot

# Set output file and terminal
set terminal png
set output "Ethereum_price_plot.png"

# Set data file format
set datafile separator ","

# Set plot title and labels
set title "Ethereum Price Over Time"
set xlabel "Time"
set ylabel "Price (Ethereum)"

# Set time formatting
set xdata time
set timefmt "%Y-%m-%d %H:%M:%S"
set format x "%Y-%m-%d\n%H:%M:%S"

# Set font size for x-axis labels
set xtics font ",7"

# Plot data
plot "EthTracker.csv" using 1:3 with linespoints title "Ethereum Price"
