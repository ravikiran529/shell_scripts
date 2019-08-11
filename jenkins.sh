#!/bin/bash
mkdir -p /root/scripts/jtest
cd /root/scripts/jtest
git clone https://github.com/ravikiran529/jenkinsRepo.git

echo "Git repository JenkinsRepo cloned..."

cd jenkinsRepo/shivasai-app

mvn clean deploy
aws s3 cp /root/scripts/j2test/jenkinsRepo/shivasai-app/target/shivasai-app-1.0-SNAPSHOT.jar s3://cloudzindagi.tk/
if (( $? == 0 )); then
   echo "###########################################################################"     

   echo "deploying artifact to s3 bucket is successful!"

   echo "###########################################################################"
else
   echo "============================================================================"

   echo "Sorry! Not able to process your request at the moment."

   echo "============================================================================"
fi



