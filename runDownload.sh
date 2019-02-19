#!/bin/bash

tmp="sonar-application-"

# get download name
cd ~/Downloads
file=( $(ls sonar-application*) )
if [ -z "$file" ] 
then
  file=( $(ls sonarqube-developer*) )
  tmp="sonarqube-developer-"
fi
if [ -z "$file" ] 
then
  file=( $(ls sonarqube-enterprise*) )
  tmp="sonarqube-enterprise-"
fi
if [ -z "$file" ] 
then
  file=( $(ls sonarqube-datacenter*) )
  tmp="sonarqube-datacenter-"
fi
if [ -z "$file" ]
then
  echo No downloaded version found. 
  exit;
fi


# calculate version
ver=$file
len=${#tmp} 
ver=${ver:$len}
len=${#ver}-4 #-4 for .zip
ver=${ver:0:$len}

# put download in place, expand, kill zip
cd  
mv Downloads/${file} ~/sonarVersions/.
cd sonarVersions
unzip $file
rm $file

# start downloaded version
mv default.txt default.bak
echo $ver > default.txt
touch sonarqube-${ver}/logs/sonar.log
/bin/bash ~/scripts/start.sh
