#!/bin/bash

if [ $# -eq 0 ]
then
  ver=( $(<~/sonarVersions/default.txt) )
else
  ver=$1
fi

/bin/bash ~/scripts/stop.sh $ver
/bin/bash ~/scripts/start.sh $ver
