#!/usr/bin/gnuplot

load '../../lib/settings.plot'  ## Shared settings

set terminal pngcairo size 800,200 font "Sans,12" transparent
set grid
set tics nomirror
unset border
unset key

## Constants
spend_feerate = 100
consolidation_feerate = 10
set xrange [1:10]

avg_cost_after_cons(c_size, utxos, c_rate, s_size) = \
  (c_size * (spend_feerate * c_rate))/(100/utxos) + s_size * spend_feerate

## Calculate the average cost to create a P2WPKH transaction assuming we
## consolidate 100 UTXOs and then use that consolidated UTXO the same
## number of times we would use if we had an average UTXO consumption rate
## of x.  We'll describe the benefits of creating larger consolidation
## transactions in a separate section.
avg_p2wpkh_cost_after_cons(utxos, cons_rate) = \
  avg_cost_after_cons(p2wpkh_size(100, 1), utxos, cons_rate, p2wpkh_size(1,2))
avg_p2wpkh_savings_after_cons(utxos, cons_rate) = 1 -  (avg_p2wpkh_cost_after_cons(utxos, cons_rate)) / (p2wpkh_size(utxos, 2) * spend_feerate)

####################################################################################
## The average cost of creating P2WPKH transactions with two outputs and x inputs ##
####################################################################################
set output './estimating-savings-normal-spending.png'
set label 1 "Without consolidation" at 4,40000 rotate by 8 textcolor ls 1
set xlabel "UTXOs spent"
set ylabel "Fee"
set ytics 25000
plot p2wpkh_size(x, 2) * spend_feerate ls 1

###########################################################################
## Average cost of unconsolidated P2WPKH transaction versus consolidated ##
###########################################################################
set output './estimating-savings-unconsolidated-vs-consolidated.png'
set label 2 "With consolidation" at 4,22000 rotate by 1 textcolor ls 2
plot p2wpkh_size(x, 2) * spend_feerate ls 1, \
  avg_p2wpkh_cost_after_cons(x, 1./10) ls 2

########################################
## Average savings from consolidation ##
########################################
set output './estimating-savings-p2wpkh-savings.png'
set yrange [-30:100] ## Keep the same for all plots
set ylabel "Fee savings"
set ytics 20
set format y '%.0f%%'
unset label 1 ; unset label 2
set label 3 "Savings from consolidation" at 20,70 textcolor ls 3
plot avg_p2wpkh_savings_after_cons(x, 1./10)*100 ls 3

###############################################
## Savings for different consolidation rates ##
###############################################
set output './estimating-savings-by-feerate.png'
#savings(inputs, consolidation_percentage) = p2wpkh_size(inputs, 2) * spend_feerate - (p2wpkh_size(inputs, 1) * (spend_feerate*consolidation_percentage) + p2wpkh_size(1, 2) * spend_feerate)
savings(inputs, consolidation_percentage) = avg_p2wpkh_savings_after_cons(inputs, consolidation_percentage)
unset label 3
set key bottom right horizontal
plot \
  savings(x, (1./50))*100 ls 4 title "2% of fast feerate", \
  savings(x, (1./10))*100 ls 3 title "10% of fast feerate", \
  savings(x, (1./4))*100 ls 5 title "25% of fast feerate", \
  savings(x, (1./2))*100 ls 6 title "50% of fast feerate"

###################################
## Savings for different scripts ##
###################################
set output './estimating-savings-by-script-type.png'

plot \
  (1 - (avg_cost_after_cons(p2wpkh_size(100, 1), x, (1./10), p2wpkh_size(1, 2))) / (p2wpkh_size(x, 2) * spend_feerate)) * 100 ls 3 title "P2wPKH", \
  (1 - (avg_cost_after_cons(p2pkh_size(100, 1), x, (1./10), p2pkh_size(1, 2))) / (p2pkh_size(x, 2) * spend_feerate)) * 100 ls 4 title "P2PKH", \
  (1 - (avg_cost_after_cons(p2sh23_size(100, 1), x, (1./10), p2sh23_size(1,2))) / (p2sh23_size(x, 2) * spend_feerate)) * 100 ls 5 title "P2SH 2-of-3", \
  (1 - (avg_cost_after_cons(p2wsh23_size(100, 1), x, (1./10), p2wsh23_size(1,2))) / (p2wsh23_size(x, 2) * spend_feerate)) * 100 ls 6 title "P2WSH 2-of-3", \
  (1 - (avg_cost_after_cons(p2tr_size(100, 1), x, (1./10), p2tr_size(1,2))) / (p2tr_size(x, 2) * spend_feerate)) * 100 ls 7 title "P2TR" \
