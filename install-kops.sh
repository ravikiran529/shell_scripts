# Install AWS CLI, Kubectl, Kops
sudo apt update
sudo apt install -y awscli
sudo snap install kubectl --classic
curl -LO https://github.com/kubernetes/kops/releases/download/1.7.0/kops-linux-amd64
chmod +x kops-linux-amd64
mv ./kops-linux-amd64 /usr/local/bin/kops

# Setup the AWS profile
aws config

# Pass the keys to Kops via env vars
printf "Enter an AWS access key"
read accesskey

printf "Enter an AWS secret key"
read secretKey

export AWS_ACCESS_KEY_ID=$accessKey
export AWS_SECRET_ACCESS_KEY=$secretKey

# Create the IAM user, groups, roles
aws iam create-group --group-name kops

aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/AmazonEC2FullAccess --group-name kops
aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/AmazonRoute53FullAccess --group-name kops
aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/AmazonS3FullAccess --group-name kops
aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/IAMFullAccess --group-name kops
aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/AmazonVPCFullAccess --group-name kops

aws iam create-user --user-name kops
aws iam add-user-to-group --user-name kops --group-name kops

# Create an S3 bucket
printf "Enter an S3 bucket name to create: "
read s3BucketName

export KOPS_STATE_STORE=s3://$s3BucketName
aws s3api create-bucket --bucket $s3BucketName --region eu-west-1

# Example of creating a cluster
printf "Enter a cluster name"
read name
export KOPS_CLUSTER_NAME=$name
kops create cluster --state $KOPS_STATE_STORE \
       --cloud=aws
       --zones "us-west-1a,us-west-1b"  \
       --master-count 3 \
       --master-size=t2.micro \
       --node-count 2 \
       --node-size=t2.micro \
       --name $KOPS_CLUSTER_NAME \
       --yes
