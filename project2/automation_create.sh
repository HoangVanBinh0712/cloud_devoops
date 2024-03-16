#!/bin/bash

# Create key pair
aws ec2 create-key-pair --key-name "udacity_ssh" --query 'KeyMaterial' --output text > "udacity_ssh.pem" --region us-east-1 --profile admin
chmod 400 udacity_ssh.pem

# Create network stack
aws cloudformation create-stack --stack-name network --template-body file://yml/network.yml --parameters file://param/network-parameters.json --region us-east-1 --profile admin

# Wait for network stack to complete
aws cloudformation wait stack-create-complete --stack-name network --profile admin

# Create udagram stack
aws cloudformation create-stack --stack-name udagram --template-body file://yml/udagram.yml --parameters file://param/udagram-parameters.json --capabilities CAPABILITY_NAMED_IAM --region us-east-1 --profile admin