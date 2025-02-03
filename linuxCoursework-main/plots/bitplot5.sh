#!/usr/bin/gnuplot

# Set output file and terminal
set terminal png
set output "bitcoin_max_supply_plot.png"

# Set data file format
set datafile separator ","

# Set plot title and labels
set title "Bitcoin Data Over Time"
set xlabel "Time"
set ylabel "Max Supply"

# Set time formatting
set xdata time
set timefmt "%Y-%m-%d %H:%M:%S"
set format x "%Y-%m-%d\n%H:%M:%S"

# Set font size for x-axis labels
set xtics font ",7"

# Plot data
plot "cryptocurrency_data3.csv" using 1:5 with linespoints title "Max Supply", \
     