#!/bin/bash

if [ $# -eq 0 ]
then
  ver=( $(<~/sonarVersions/default.txt) )
else
  ver=$2
fi

jar=$1

echo $ver
/bin/bash ~/scripts/move.sh $jar $ver
/bin/bash ~/scripts/start.sh $ver
