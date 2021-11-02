#!/bin/bash

no1=1
no2=0

for (( i=0; i<10; i++ ))
do
  echo "$no1"
  tmp=$no1
  no1=$(($no1+$no2))
  no2=$tmp
done
