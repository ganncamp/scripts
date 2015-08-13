#!/bin/bash

#sanity checks
currentDir=${PWD##*/}
if [[ $currentDir != sonar-*  ]]
then
  echo "Not a plugin directory. Goodbye"
  exit
fi

targetDir=its/ruling
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

#set up env
if [[ $currentDir = sonar-javascript ]]
then
  rulingDir=~/workspace/javascript-test-sources
fi

export SONAR_IT_SOURCES=$rulingDir
export ORCHESTRATOR_CONFIG_URL=file:///home/ganncamp/workspace/orchestrator.properties

cd $targetDir

#run ruling
mvn clean install -Dmaven.test.redirectTestOutputToFile=false -DjavascriptVersion="DEV" -Dsonar.runtimeVersion="LATEST_RELEASE"

#copy new .json file
if [[ $? != 0 ]]
then
  dir1=src/test/expected
  dir2=target/actual
  newFile=$(diff -r $dir1 $dir2 | grep "Only in" | awk '{print $4}')
  if [[ ! -z $newFile ]] 
  then 
    cp ${dir2}/${newFile} ${dir1}/.
    git add ${dir2}/${newFile}
    echo Copied $newFile to $dir2
  fi
fi