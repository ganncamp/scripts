#!/bin/bash

if [ $# -eq 0 ]
then
  lim=10
else
  lim=$1
fi


x=1
while [ $x -le $lim ]; do
  sonar-scanner -Dsonar.branch=${x}

  ((x++))
done

