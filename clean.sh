#!/bin/bash

if [ $# -eq 0 ]
then
  ver=( $(<~/sonarVersions/default.txt) )
else
  ver=$1
fi

target="/home/ganncamp/sonarVersions/sonarqube-${ver}/"

#rm $target/extensions/plugins/*.jar
rm -R $target/data/*
rm -R $target/temp/*

/bin/bash ~/scripts/reset.sh
