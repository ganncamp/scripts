#!/bin/bash

if [ $# -eq 0 ]
then
  ver=( $(<~/sonarVersions/default.txt) )
else
  ver=$1
fi

target="/home/ganncamp/sonarVersions/sonarqube-${ver}"
if [[ ! -d $target ]]
then
  target="/home/ganncamp/sonarVersions/sonar-${ver}"
fi

echo "target: $target"
/bin/bash ${target}/bin/linux-x86-64/sonar.sh start

if test [-f  "${target}/logs/sonar.log" ]; then
  tail -f ${target}/logs/sonar.log
else
  tail -f ${target}/logs/sonar.$(date +'%Y%m%d').log
fi
