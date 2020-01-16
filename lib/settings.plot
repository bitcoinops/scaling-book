#!/usr/bin/gnuplot -p

## Shared settings across various gnuplots used in the book

set style line 1 lc rgb '#8b1a0e' pt 6 ps 0.1 lt 1 lw 2
set style line 2 lc rgb '#5e9c36' pt 6 ps 0.1 lt 1 lw 2
set style line 3 lc rgb '#0025ad' pt 6 ps 0.1 lt 1 lw 2
set style line 4 lc rgb '#9400d3' pt 6 ps 0.1 lt 1 lw 2
set style line 5 lc rgb '#d95319' pt 6 ps 0.1 lt 1 lw 2
set style line 6 lc rgb '#edb120' pt 6 ps 1 lt 1 lw 2
set style line 7 lc rgb '#4dbeee' pt 6 ps 1 lt 1 lw 2
set style line 8 lc rgb '#9400d3' pt 6 ps 1 lt 1 lw 2
set style line 9 lc rgb '#d3d3d3' pt 6 ps 1 lt 1 lw 2
set style line 10 lc rgb '#808080' pt 1 ps 1 lt 1 lw 2
set style line 11 lc rgb '#808080' lt 1
set style line 12 lc rgb '#808080' lt 0 lw 1
set style line 12 lc rgb '#e0e0e0' lt 0 lw 1

p2wpkh_size(inputs, outputs) =  10.0 +  67.75  * inputs + 31 * outputs
p2pkh_size(inputs, outputs) =   10.0 + 148     * inputs + 34 * outputs
p2sh23_size(inputs, outputs) =  10.0 + 294     * inputs + 32 * outputs
p2wsh23_size(inputs, outputs) = 10.0 + 104.25  * inputs + 43 * outputs
p2tr_size(inputs, outputs) =    10.0 +  57.25  * inputs + 43 * outputs
