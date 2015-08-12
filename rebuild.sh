#!/bin/bash

if [ $# -eq 0 ]
then
  force=false
else
  force=$1
fi


out=$(git pull origin)
echo $out
if [ "$out" != "Already up-to-date." ] || [ "$force" = true ]
then
	mvn clean install
	exit 1
fi

exit 0
