#!/bin/bash
set -e
set -u
#This script copies artifact to s3 bucket which has been built by maven.
mkdir -p /root/scripts/jtest
cd /root/scripts/jtest
git clone https://github.com/ravikiran529/jenkinsRepo.git

echo "____ Git repository JenkinsRepo cloned successfully. ____"

cd jenkinsRepo/shivasai-app

mvn clean package

if [ "$?" != "0" ]
then
   echo "******** Build failed! ********"
   exit 1
fi

PATH=/root/scripts/j2test/jenkinsRepo/shivasai-app/target/shivasai-app-1.0-SNAPSHOT.jar
BUCKET=s3://cloudzindagi.tk/

aws s3 cp $PATH $BUCKET

if [ "$?" == "0" ]     

   echo "deploying artifact to s3 bucket is successful!"

else
   
   echo "Copying artifact to S3 bucket failed."

fi



