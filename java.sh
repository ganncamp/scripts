#!/bin/bash

if [ $# -eq 0 ]
then
  ver=( $(<~/sonarVersions/default.txt) )
else
  ver=$1
fi

target="/home/ganncamp/sonarVersions/sonarqube-${ver}/extensions/downloads/"
if [[ ! -d $target ]]
then
  target="/home/ganncamp/sonarVersions/sonar-${ver}/extensions/downloads/"
fi


basedir=~/workspace

for dir in java cobertura
do
  cd ${basedir}/sonar-${dir}
  /bin/bash ~/scripts/rebuild.sh
done

for jar in findbugs jacoco java squid-java surefire
do
	cp ${basedir}/sonar-java/sonar-${jar}-plugin/target/sonar-${jar}-plugin-*-SNAPSHOT.jar  ${target}.
done

for jar in cobertura
do
	cp ${basedir}/sonar-${jar}/target/sonar-${jar}-plugin-*-SNAPSHOT.jar  ${target}.
done


/bin/bash ~/scripts/start.sh $ver
