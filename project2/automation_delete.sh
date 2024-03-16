#!/bin/bash

# Delete udagram stack
aws cloudformation delete-stack --stack-name udagram --region us-east-1 --profile admin

# Wait for udagram stack to be deleted completely
aws cloudformation wait stack-delete-complete --stack-name udagram --profile admin

# Delete network stack
aws cloudformation delete-stack --stack-name network --region us-east-1 --profile admin

# Delete key pair
aws ec2 delete-key-pair --key-name udacity_ssh --region us-east-1 --profile admin
# Add Permission before delete
chmod +w udacity_ssh.pem
rm udacity_ssh.pem