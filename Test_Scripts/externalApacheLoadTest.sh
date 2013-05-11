#!/bin/bash

before="$(date +%s)"

x=0
while [ $x -le 10000 ]
do
  wget http://www.eastco.sa3 -O /dev/null -q
  x=$(( $x + 1 ))
done

after="$(date +%s)"
elapsed_seconds="$(expr $after - $before)"
echo Elapsed time: $elapsed_seconds seconds $x
