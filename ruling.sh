#!/bin/bash

basedir=~/workspace
targetDir=its/ruling
currentDir=${PWD##*/}

#set up env
if [[ $currentDir = sonar-javascript ]]
then
  versionName="-DjavascriptVersion"
  expected=src/test/expected
fi
if [[ $currentDir = sonar-java ]]
then 
  versionName="-DjavaVersion"
  expected=src/test/resources/guava
fi

export ORCHESTRATOR_CONFIG_URL=file:///home/ganncamp/workspace/orchestrator.properties


#sanity checks
if [[ $currentDir != sonar-*  ]]
then
  echo "Not a plugin directory. Goodbye"
  exit
fi

if [ ! -d $targetDir ]
then
  echo "I don't see '${targetDir}'. Goodbye"
  exit
fi

#build project
mvn clean install
if [[ $? != 0 ]] ; then
  echo 'Build failed!'
  exit $rc
fi


cd $targetDir

#run ruling
mvn install -Dmaven.test.redirectTestOutputToFile=false ${versionName}="DEV" -Dsonar.runtimeVersion="LATEST_RELEASE"


#copy new .json file
if [[ $? != 0 ]]
then
  actual=target/actual
  newFile=$(diff -qr $expected $actual | grep "Only in" | awk '{print $4}')
  echo $newFile
#  if [[ ! -z $newFile ]] 
#  then 
#    cp ${actual}/${newFile} ${expected}/.
#    git add ${actual}/${newFile}
#    echo Copied $newFile to $actual
#  fi
fi