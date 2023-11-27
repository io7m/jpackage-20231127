#!/bin/sh -ex

wget -O jdk.tar.gz -c 'https://api.foojay.io/disco/v3.0/ids/9604be3e0c32fe96e73a67a132a64890/redirect'
mkdir -p jdk
tar -x -v --strip-components=1 -f jdk.tar.gz --directory jdk

wget -O jre.tar.gz -c 'https://api.foojay.io/disco/v3.0/ids/3981936b6f6b297afee4f3950c85c559/redirect'
mkdir -p jre
tar -x -v --strip-components=1 -f jre.tar.gz --directory jre

wget -O maven.tar.gz -c 'https://dlcdn.apache.org/maven/maven-3/3.9.5/binaries/apache-maven-3.9.5-bin.tar.gz'
mkdir -p maven
tar -x -v --strip-components=1 -f maven.tar.gz --directory maven

export JAVA_HOME="jdk/"
export JPACKAGE="jdk/bin/jpackage"

maven/bin/mvn clean package

rm -rfv jars
mkdir -p jars

cp ./m1/target/m1-20231111.jar jars
cp ./m2/target/m2-20231111.jar jars
cp ./m3/target/m3-20231111.jar jars

rm -rfv jpackagetest
${JPACKAGE} --runtime-image jre -t app-image --module com.io7m.demo.m3 --module-path jars --name jpackagetest

