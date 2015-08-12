#!/bin/bash

if [ $# -eq 0 ]
then
  ver=( $(<~/sonarVersions/default.txt) )
else
  ver=$1
fi

target="/home/ganncamp/sonarVersions/sonarqube-${ver}/"
if [[ ! -d $target ]]
then
  target="/home/ganncamp/sonarVersions/sonar-${ver}/"
fi

rm $target/extensions/plugins/*.jar
rm -R $target/data/*

/bin/bash ~/scripts/reset.sh
