#!/usr/bin/gnuplot

load '../../lib/settings.plot'  ## Shared settings

set terminal pngcairo size 800,200 font "Sans,12" transparent
set grid
set tics nomirror
unset border
unset key

## Keep consistent for all examples
set style data boxes
## $1: x coordinate (centered)
## $2: y coordinate (e.g. height)
## $3: width

set xrange [-5:400]
set yrange [0:120]  ## Keep consistent for all examples
set ytics 50
set ylabel "Feerate"  ## Explicitly not mentioning units as it doesn't matter
set xlabel "Size in vbytes"

#################
## 1-in, 2-out ##
#################
set output './consolidation-example-1in2out.png'
set x2label "Total fee: 14,050 = 100 * 140.50"
set label 1 "\ \ 1-in, 2-out\n140.50 vbytes" at 40,60 textcolor ls 1
plot '<echo start=0 feerate=100 vbytes=140.50 | sed "s/\<[a-z]*=//g"' u ($1+$3/2):2:3 ls 1

#################
## 3-in, 2-out ##
#################
set output './consolidation-example-3in2out.png'
set x2label "Total fee: 27,600 = 100 * 276.00"
set label 1 "\ \ 3-in, 2-out\n276.00 vbytes" at 100,60 textcolor ls 1
plot '<echo start=0 feerate=100 vbytes=276.00 | sed "s/\<[a-z]*=//g"' u ($1+$3/2):2:3 ls 1

##############################
## 3-in, 1-out; 1-in, 2-out ##
##############################
set output './consolidation-example-3in1out-1in2out.png'
## ------
## 135.75
set x2label "Total fee: 15,900 = 10 * 245.00 + 100 * 140.50"
set label 1 "\ \ 3-in, 1-out\n245.00 vbytes" at 80,60 textcolor ls 1
set label 2 "\ \ 1-in, 2-out\n140.50 vbytes" at 285,60 textcolor ls 2
plot '<echo start=0 feerate=10 vbytes=245.00 | sed "s/\<[a-z]*=//g"' u ($1+$3/2):2:3 ls 1, \
     '<echo start=245.00 feerate=100 vbytes=140.50 | sed "s/\<[a-z]*=//g"' u ($1+$3/2):2:3 ls 2
