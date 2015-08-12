#!/bin/bash

old=$1
oldDir=/usr/share/sonarqube-${old}
new=$2
newDir=/usr/share/sonarqube-${new}

if [[ -z $old || -z $new ]]
then
        echo "usage: ${0} oldVer newVer"
        echo "E.g ${0} 2.9 2.10"
else
        if [[ ! -e $oldDir ]]
        then
                echo "Cannot upgrade from ${old}. Directory does not exist: ${oldDir}"
                exit
        else
                echo "Upgrade from sonarqube-${old} to sonarqube-${new}"

                if [[ ! -e "sonarqube-${new}.zip" ]]
                then
                        echo "sonarqube-${new}.zip not found. Skipping expansion"
                else
                        if [ ! -e /usr/share/sonarqube-${new} ]
                        then
                                echo "expanding sonarqube-${new}.zip to /usr/share"
                                sudo unzip -d /usr/share sonarqube-${new}.zip

                                echo "copying plugins"
                                sudo cp $oldDir/extensions/plugins/*.jar $newDir/extensions/plugins/.

                                echo "copying conf"
                                sudo mv $newDir/conf/sonar.properties $newDir/conf/sonar.properties.bak
                                sudo cp $oldDir/conf/sonar.properties $newDir/conf/sonar.properties
                        fi
                fi

                if [[ ! -e ${newDir} ]]
                then
                        echo "Cannot complete upgrade. Directory for new version does not exist: ${newDir}"
                else
                        echo "Stopping service"
                        sudo service sonar stop

                        echo "Updating symlink in /usr/bin"
                        sudo rm /usr/bin/sonar
                        sudo ln -s ${newDir} /usr/bin/sonar

                        echo "Backing up database"
                        d=`date +"%y%m%d"`
                        mysqldump -u root -p sonar | gzip -9 > sonar-db-ver${old}-${d}.sql.gz
                        sudo cp sonar-db-ver${old}-${d}.sql.gz ${oldDir}/.

                        echo "Starting service"
                        sudo service sonar start

                        echo ""
                        echo "To complete upgrade, access the following in a browser and follow instructions:"
                        echo "http://$(hostname):9000/setup"
                fi
        fi
fi
