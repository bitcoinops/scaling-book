#!/bin/bash -eu

FILE=feerate.data
lines=$( cat $FILE | wc -l )

echo "| Savings | Percentage of time possible |"
for ratio in 2 4 10 25 50 100
do
  sum=$(
    cat $FILE | while read line ; do
      high=$( echo $line | cut -d' ' -f2 )
      low=$( echo $line | cut -d' ' -f3 )
      if [ $(( high / low )) -ge $ratio ]; then
        echo 1
      else
        echo 0
      fi
    done | numsum
  )
  avg=$( echo $sum / $lines \* 100 | bc -l | sed 's/\(\...\).*/\1/' )
  savings=$( echo "(1 - 1 / $ratio) * 100" | bc -l | sed 's/\(\...\).*/\1/' )
  echo "| $savings | $avg |"
done
