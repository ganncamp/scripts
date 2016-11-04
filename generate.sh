#!/bin/bash

jar=~/workspace/sonar-rule-api/target/rule-api-*.jar


if [ $# -eq 0 ]
then
  echo Nothing to generate. Goodbye
  exit
fi

currentDir=${PWD##*/}
arr=(${currentDir//-/ })
language=${arr[1]}

subdirs=$(ls -d *-checks)

if [[ $subdirs != *-checks ]]
then
  echo "I don't see a checks directory. Goodbye"
  exit
fi

if [ ! -f ${jar} ]
then
  echo "I don't see the Rule API jar. Goodbye"
  exit
fi


langDir=*-checks/src/main/resources/org/sonar/l10n/${language}/rules/${language}
if [[ $language = java ]]
then
  langDir=*-checks/src/main/resources/org/sonar/l10n/${language}/rules/squid
fi

java -jar $jar generate -rule $1 -language $language -directory ${langDir}

cd ${langDir}
git add ${1}.*

