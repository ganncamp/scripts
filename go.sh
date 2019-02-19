#!/bin/bash


if [ $# -eq 0 ]
then
  ver=( $(<~/sonarVersions/default.txt) )
else
  ver=$1
fi



currentDir=${PWD##*/}

if [[ $currentDir == sonar-enterprise ]]
then
  /bin/bash ~/scripts/platformSnapshot.sh
  exit
fi

if [[ $currentDir != sonar-* ]]
then
  echo
  echo Running downloaded SQ
  echo
  /bin/bash ~/scripts/runDownload.sh

  exit
fi

# run rebuild script
/bin/bash ~/scripts/rebuild.sh
rc=$?
if [[ $rc != 0 ]]
then
  echo "Plugin build failed!"
  exit $rc
fi


jar=target/${currentDir}-plugin-*SNAPSHOT.jar

if [ -d "${currentDir}" ]
then
  jar="${currentDir}/${jar}"
fi

if [ -d "${currentDir}-plugin" ]
then
  jar="${currentDir}-plugin/${jar}"
fi

#resolve wildcards
jar=$(ls $jar)

if [ ! -e "$jar" ]
then
  jar=target/${currentDir}-plugin.jar

  if [ -d "${currentDir}" ]
  then
    jar="${currentDir}/${jar}"
  fi

  if [ -d "${currentDir}-plugin" ]
  then
    jar="${currentDir}-plugin/${jar}"
  fi
fi


echo $jar


# run mvstart script
/bin/bash ~/scripts/mvstart.sh $jar $ver
