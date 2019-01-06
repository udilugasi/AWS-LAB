# AWS-LAB

This is AWS-LAB project for basic AWS commands.

Prerequisites:
1. Linux box with terraform installed.

How to run?

1. clone the project to your pc
   git clone https://github.com/udilugasi/AWS-LAB.git
2. cd to the project directory
3. Configure your aws access and security details:
   3.1 Under variables.tf file insert your: 
       aws_access_key_id
       aws_secret_access_key
       aws_region
   3.2 Inside your aws account (console): 
   Configure IAM user and key pair with full ec2 access and update "key_name" & "private_key_name" variables accordingly.
   See an example in: https://www.youtube.com/watch?v=RA1mNClGYJ4
4. terraform init
   terraform plan
   terraform apply
   
5. The output will be:
   * 2 created ec2 instances
   * ssh connection and System Information for each instance
   * shutdown the instances
   
**************************************************************************************
   
Script to get a table with information about ec2 instances in your aws account:
Run:
chmod +x aws_instances.sh
./aws_instances.sh

The output will be:
------------------------------------------------------
|                  DescribeInstances                 |
+---------------------+---------------+--------------+
|     Instance_ID     |     Name      |    State     |
+---------------------+---------------+--------------+
|  i-061ffaa3ad81361b3|  lab2-public  |  stopped     |
|  i-05b02e903aa176d16|  lab1-public  |  stopped     |
|  i-0e621b4a331bcbfe1|  lab2-public  |  terminated  |
|  i-0842a2d02ea0ed131|  lab1-public  |  terminated  |
|  i-0ff9ad22340c671eb|  lab2-public  |  terminated  |
|  i-03fa4bf1763c3dcdd|  lab1-public  |  terminated  |
+---------------------+---------------+--------------+
   
