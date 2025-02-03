#!/usr/bin/gnuplot

# Set output file and terminal
set terminal png
set output "bitcoin_price_plot.png"

# Set data file format
set datafile separator ","

# Set plot title and labels
set title "Bitcoin Price Over Time"
set xlabel "Time"
set ylabel "Price (Bitcoin)"

# Set time formatting
set xdata time
set timefmt "%Y-%m-%d %H:%M:%S"
set format x "%Y-%m-%d\n%H:%M:%S"

# Plot data
plot "cryptocurrency_data.csv" using 1:3 with linespoints title "Bitcoin Price"
