#!/bin/bash

# read aws account details from the user
read -p "Enter your aws_access_key_id and press [ENTER]: " access_key
read -p "Enter your aws_secret_access_key and press [ENTER]: " secret_access_key
read -p "Enter your aws_region and press [ENTER]: " region

####Installing AWS CLI with all dependencies.
wget https://s3.amazonaws.com/aws-cli/awscli-bundle.zip
unzip awscli-bundle.zip
sudo ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws
./awscli-bundle/install -b ~/bin/aws
./awscli-bundle/install -h

###Configure the config and credentials with your account.
aws configure set aws_access_key_id $access_key
aws configure set aws_secret_access_key $secret_access_key
aws configure set default.region $region

###Get all instances details in table format
aws ec2 describe-instances --query "Reservations[*].Instances[*].{Name: Tags[?Key=='Name'] | [0].Value, Instance_ID: InstanceId, State: State.Name}" --output table
