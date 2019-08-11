#!/bin/bash
#To list all buckets in your aws region.

aws s3 ls
if [ "$?" != "0" ]
then
   echo "Oops! Unable to list buckets."
fi

#To list content in particular bucket---> aws s3 ls s3://<Bucket_name>
echo " "
read -p "Enter bucket name to view content: " BUCKET
aws s3 ls s3://$BUCKET
if [ "$?" != "0" ]
then
   echo "Oops! Unable to list bucket content."
fi
