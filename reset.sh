cd ~/sonarVersions

if [[ -e default.bak ]]
then
  echo Resetting default SonarQube version
  ver=( $(<~/sonarVersions/default.txt) )
  rm -R sonarqube-${ver}

  rm default.txt
  mv default.bak default.txt
fi
