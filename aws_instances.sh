#!/bin/bash

####Installing AWS CLI with all dependencies.
wget https://s3.amazonaws.com/aws-cli/awscli-bundle.zip
unzip awscli-bundle.zip
sudo ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws
./awscli-bundle/install -b ~/bin/aws
./awscli-bundle/install -h

###Configure the config and credentials with your account.
aws configure set aws_access_key_id **********
aws configure set aws_secret_access_key ***************
aws configure set default.region us-east-1

###Get all instances details in table format
aws ec2 describe-instances --region us-east-1 --output table
