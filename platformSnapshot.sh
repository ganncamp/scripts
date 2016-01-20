#!/bin/bash

superDir=~/sonarVersions
sourceDir=sonar-application/target


# update sources
out=$(git pull origin)
echo $out

#clean
mvn clean

# build snapshot
/bin/bash ./quick-build.sh

# calculate version 
ver=$(ls ${sourceDir}/sonarqube-*-SNAPSHOT.zip)
len=${#sourceDir}+11 #+11 for /sonarqube-
ver=${ver:$len}
len=${#ver}-4 #-4 for .zip
ver=${ver:0:$len}

if [ ! -f ${sourceDir}/sonarqube-${ver}.zip ]
then
  echo 
  echo BUILD FAILED
fi

# copy, expand, delete zip
cp ${sourceDir}/sonarqube-${ver}.zip ${superDir}/.
cd ${superDir}
unzip sonarqube-${ver}.zip
rm sonarqube-${ver}.zip

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
