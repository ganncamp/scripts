#!/bin/bash

superDir=~/sonarVersions
sourceDir=sonar-application/build/distributions


# update sources
out=$(git pull origin)
echo $out

# build snapshot
/bin/bash ./build.sh -x test

if [ $? != 0 ]
then
  echo 
  echo QUICK BUILD SCRIPT FAILED
  exit
fi

# calculate version 
ver=$(ls ${sourceDir}/sonar-application-*-SNAPSHOT.zip)
len=${#sourceDir}+19 #+19 for /sonar-application-
ver=${ver:$len}
len=${#ver}-4 #-4 for .zip
ver=${ver:0:$len}


if [ ! -f ${sourceDir}/sonar-application-${ver}.zip ]
then
  echo 
  echo BUILD FAILED
  exit
fi

# copy, expand, delete zip
cp ${sourceDir}/sonar-application-${ver}.zip ${superDir}/.
cd ${superDir}
unzip sonar-application-${ver}.zip
rm sonar-application-${ver}.zip

echo 
echo ver: ${ver}
echo


# start server
if [[ -d sonarqube-${ver} ]] 
then
  mv default.txt default.bak
  echo $ver > default.txt
  touch sonarqube-${ver}/logs/sonar.log
  /bin/bash ~/scripts/start.sh ${ver}
else
  echo Deploy failed
fi
