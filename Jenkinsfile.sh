#This script does jenkins work
#!/bin/bash

#Step-1: cloning git repository..
git clone https://github.com/ravikiran529/Maven-Java-Project.git
echo "source code updated updated.."
cd /Maven-Java-Project

#Step-2: Perform test cases
mvn clean test

#Step-3: Package application and deploy to artifact repo
mvn clean deploy

#Step-4: Deploy to App-Server
cd /target
scp *.war http://192.168.35.15:/root/StagingServer/webapps/

#Step-5: Deploy to production


