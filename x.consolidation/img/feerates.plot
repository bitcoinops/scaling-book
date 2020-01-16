#!/usr/bin/gnuplot

load '../../lib/settings.plot'  ## Shared settings

set terminal pngcairo size 800,200 font "Sans,12" transparent
set grid
set tics nomirror
unset border
unset key

set output './feerate-ratio.png'
#set x2label "Total fee: 13,575 = 100 * 135.75"
#set label 1 "\ \ 1-in, 2-out\n135.75 vbytes" at 40,60 textcolor ls 1
set timefmt "%s"
set xdata time
set ylabel "Savings"
set xlabel "Date (year = 2019)"
set format y "%0.f%%"
set format x "%m/%d"
seconds_per_month = 60 * 60 * 24 * (365.25/12)
seconds_per_week = 60 * 60 * 24 * 7
set xtics seconds_per_week
start_date=1572566400 ## 2019-11-01
end_date=1577854800   ## 2020-01-01
set xrange [start_date:end_date]
plot 'feerate.data' u 1:((1 - $3/$2)*100)
