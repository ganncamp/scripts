#!/bin/bash

if [ $# -eq 0 ]
then
  ver=( $(<~/sonarVersions/default.txt) )
else
  ver=$1
fi

target="${HOME}/sonarVersions/sonarqube-${ver}/"
if [[ ! -d $target ]]
then
  target="${HOME}/sonarVersions/sonar-${ver}/"
fi

/bin/bash  ${target}/bin/linux-x86-64/sonar.sh stop

