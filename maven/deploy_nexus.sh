#!/bin/sh

rm -rf pom.xml
clear

GROUP='es.mutuadepropietarios'
ARTIFACT='sisnet-libs'
ARTIFACT_CHILD='sisnet-libs-child'
REPO_ID='snapshots'
REPO_URL='http://192.168.0.41:8081/nexus/content/repositories/snapshots'
VERSION=$1'-SNAPSHOT'

if [ "$2" == "releases" ]; then
	VERSION=$1
	REPO_ID='releases'
	REPO_URL='http://192.168.0.41:8081/nexus/content/repositories/releases'
fi

echo '<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">' > parent.xml

echo '<modelVersion>4.0.0</modelVersion><groupId>'$GROUP'</groupId><artifactId>'$ARTIFACT'</artifactId><version>'$VERSION'</version><packaging>pom</packaging><dependencies>' >> parent.xml

for x in `ls *.jar`; do
        mvn deploy:deploy-file -DgeneratePom=false -DrepositoryId=$REPO_ID -Durl=$REPO_URL -DgroupId=$GROUP -DartifactId=$ARTIFACT_CHILD -Dversion=$VERSION -Dpackaging=jar -Dfile=$x -Dclassifier=${x%%.jar}
        echo '<dependency><groupId>'$GROUP'</groupId><artifactId>'$ARTIFACT_CHILD'</artifactId><version>'$VERSION'</version><classifier>'${x%%.jar}'</classifier></dependency>' >> parent.xml
done

echo '</dependencies></project>' >> parent.xml
mv parent.xml pom.xml

mvn deploy:deploy-file -DgeneratePom=true -DrepositoryId=$REPO_ID -Durl=$REPO_URL -DpomFile=pom.xml -Dfile=pom.xml