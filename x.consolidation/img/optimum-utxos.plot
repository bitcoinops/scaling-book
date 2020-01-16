#!/usr/bin/gnuplot

load '../../lib/settings.plot'  ## Shared settings

set terminal pngcairo size 800,250 font "Sans,12" transparent
set grid
set tics nomirror
unset border
unset key

set output './optimum-utxos.png'
set xlabel "UTXOs spent"
set ylabel "Vbytes per\nUTXO"
set ytics 100

set key rmargin vertical center

plot [1:10] \
  p2sh23_size(x, 1)/x ls 5 title "P2SH (2-of-3)", \
  p2pkh_size(x, 1)/x ls 7 title "P2PKH", \
  p2wsh23_size(x, 1)/x ls 3 title "P2WSH (2-of-3)", \
  p2wpkh_size(x, 1)/x ls 2 title "P2WPKH", \
  p2tr_size(x, 1)/x ls 8 title "P2TR" \

