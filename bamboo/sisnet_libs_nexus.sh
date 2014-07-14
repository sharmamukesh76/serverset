#!/bin/sh

rm -rf pom.xml
clear

GROUP='es.mutuadepropietarios'
ARTIFACT=$1'-libs'
ARTIFACT_CHILD=$1'-libs-child'
REPO_ID='snapshots'
REPO_URL='http://192.168.0.41:8081/nexus/content/repositories/snapshots'
VERSION=$2'-SNAPSHOT'

if [ "$3" == "releases" ]; then
	VERSION=$2
	REPO_ID='releases'
	REPO_URL='http://192.168.0.41:8081/nexus/content/repositories/releases'
fi

echo '<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">' > parent.xml

echo '<modelVersion>4.0.0</modelVersion><groupId>'$GROUP'</groupId><artifactId>'$ARTIFACT'</artifactId><version>'$VERSION'</version><packaging>pom</packaging><dependencies>' >> parent.xml

for x in `ls *.jar`; do
        CLASSIFIER="$(echo $x | sed "s/.jar//g" | tr '.' '#' | sed "s/#//g")"
        /usr/local/apache-maven/bin/mvn deploy:deploy-file -DgeneratePom=false -DrepositoryId=$REPO_ID -Durl=$REPO_URL -DgroupId=$GROUP -DartifactId=$ARTIFACT_CHILD -Dversion=$VERSION -Dpackaging=jar -Dfile=$x -Dclassifier=$CLASSIFIER
        echo '<dependency><groupId>'$GROUP'</groupId><artifactId>'$ARTIFACT_CHILD'</artifactId><version>'$VERSION'</version><classifier>'$CLASSIFIER'</classifier><type>jar</type></dependency>' >> parent.xml
done

echo '</dependencies></project>' >> parent.xml
mv parent.xml pom.xml

/usr/local/apache-maven/bin/mvn deploy:deploy-file -DgeneratePom=true -DrepositoryId=$REPO_ID -Durl=$REPO_URL -DpomFile=pom.xml -Dfile=pom.xml

