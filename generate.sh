#!/bin/bash

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

jar=~/workspace/sonar-rule-api/target/rule-api-*.jar

if [ ! -f ${jar} ]
then
  echo "I don't see the Rule API jar. Goodbye"
  exit
fi

java -jar $jar generate -rule $1 -language $language

if [[ $language = java ]]
then
  mv ${1}.html *-checks/src/main/resources/org/sonar/l10n/${language}/rules/squid/.
else
  mv ${1}.html *-checks/src/main/resources/org/sonar/l10n/${language}/rules/${language}/.
fi
