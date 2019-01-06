# ---------------------------------------------------------------------------------------------------------------------
# ENVIRONMENT VARIABLES
# ---------------------------------------------------------------------------------------------------------------------

# ---------------------------------------------------------------------------------------------------------------------
# Define secrets to access AWS
# ---------------------------------------------------------------------------------------------------------------------
variable "aws_access_key_id" {
  description = "The AWS access key ID"
  default     = ""
}

variable "aws_secret_access_key" {
  description = "The AWS secret access keys"
  default     = ""
}

# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# You must provide a value for each of these parameters.
# ---------------------------------------------------------------------------------------------------------------------

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# These parameters have reasonable defaults.
# ---------------------------------------------------------------------------------------------------------------------
variable "aws_region" {
  description = "The AWS region to deploy into"
  default     = "us-east-1"
}

variable "ami_ubuntu" {
  description = "The AWS ami to deploy"
  default     = "ami-2757f631"
}

variable "av_zone" {
  description = "The AWS availability zone to use"
  default     = "us-east-1a"
}

variable "ubuntu_user" {
  description = "The ubuntu ssh user "
  default     = "ubuntu"
}

variable "key_name" {
  description = "The AWS Key pair name"
  default     = "key_lab_ssh"
}

variable "private_key_name" {
  description = "The AWS private key name"
  default     = "key_lab_ssh.pem"
}

variable "sec_group_name" {
  description = "The name of the security group"
  default     = "lab-sec-group"
}

variable "instance_port" {
  description = "The port the EC2 Instance"
  default     = 8080
}

variable "vpc_ip" {
  default = "10.0.0.0/16"
}

variable "subnet_ip" {
  default = "10.0.1.0/24"
}

variable "ebs_optimized" {
  description = "If true, the launched EC2 instance will be EBS-optimized"
  default     = false
}
