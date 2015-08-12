libdirs="/usr/share/java"
propertiesFile=sonar.properties
ext=.jar

# list libs
started=false
for dir in $libdirs
do
  for lib in $(ls ${dir}/*${ext})
  do
    if $started
    then
      libs="${libs},"
    fi
    started=true
    libs="${libs}${lib}"
  done
done

# create unified properties file
cat ${propertiesFile} > sonarAll.properties
echo "">>sonarAll.properties
echo libraries=${libs}>>sonarAll.properties

# kick off analysis
sonar-runner -Dproject.settings=sonarAll.properties

#clean up
rm sonarAll.properties
