#!/bin/bash

# get download name
cd ~/Downloads
file=( $(ls sonar-application*) )

# calculate version
ver=$file
tmp="sonar-application-"
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
