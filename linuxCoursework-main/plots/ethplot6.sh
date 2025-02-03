#!/usr/bin/gnuplot

# Set output file and terminal
set terminal png
set output "ethereum_FDMC_plot.png"

# Set data file format
set datafile separator ","

# Set plot title and labels
set title "Ethereum Data Over Time"
set xlabel "Time"
set ylabel "US Dollars "

# Set time formatting
set xdata time
set timefmt "%Y-%m-%d %H:%M:%S"
set format x "%Y-%m-%d\n%H:%M:%S"

# Set font size for x-axis labels
set xtics font ",7"

# Plot data
plot "EthTracker2.csv" using 1:6 with linespoints title "Fully Diluted Market Cap"
