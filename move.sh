#!/bin/bash

if [ $# -eq 0 ]
then
  echo "Usage: jar-to-move [target-version]"
  exit;
elif [ $# -eq 1 ]
then
  ver=( $(<~/sonarVersions/default.txt) )
else
  ver=$2
fi

target0="${HOME}/sonarVersions/sonarqube-${ver}/extensions"
if [[ ! -d $target0 ]]
then
  target0="${HOME}/sonarVersions/sonar-${ver}/extensions"
fi

target="${target0}/downloads"
if [[ ! -d $target ]]
then
  target="${target0}/plugins"
fi

echo target: $target
cp -f $1 ${target}/.
