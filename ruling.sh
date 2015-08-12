#!/bin/bash

currentDir=${PWD}

if [[ $currentDir = *sonar-javascript/its/ruling ]]
then
  rulingDir=/home/ganncamp/workspace/javascript-test-sources
fi

export SONAR_IT_SOURCES=$rulingDir
export ORCHESTRATOR_CONFIG_URL=file:///home/ganncamp/workspace/orchestrator.properties

mvn test