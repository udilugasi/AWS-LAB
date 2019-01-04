# ---------------------------------------------------------------------------------------------------------------------
# ENVIRONMENT VARIABLES
# ---------------------------------------------------------------------------------------------------------------------

# ---------------------------------------------------------------------------------------------------------------------
# Define secrets to access AWS
# ---------------------------------------------------------------------------------------------------------------------

# AWS_ACCESS_KEY_ID
# AWS_SECRET_ACCESS_KEY

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

variable "key_name" {
  description = "The AWS Key pair name"
  default     = "key_lab"
}

#variable "number_of_instances" {
#  description = "Number of instances to create and attach to ELB"
#  default     = 2
#}

variable "sec_group_name" {
  description = "The name of the security group"
  default     = "lab-sec-group"
}

variable "instance_port" {
  description = "The port the EC2 Instance should listen on for HTTP requests."
  default     = 8080
}

variable "instance_text" {
  description = "The text the EC2 Instance should return when it gets an HTTP request."
  default     = "<html><body><h1>Hello User You are Testing my AWS web Site</h1></body<</html>"
}

#variable  "avail-zones" {
#	type = "list"
#	default = ["eu-west-2a","eu-west-2b","eu-west-2c"]
#}
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

#variable "cluster_name" {
#  description = "The port the EC2 Instance should listen on for HTTP requests."
#  default     = "cerditFi"
#}


# ---------------------------------------------------------------------------------------------------------------------
#  REQUIRED DATA
# ---------------------------------------------------------------------------------------------------------------------


#data "aws_availability_zones" "avzs" {}


# ---------------------------------------------------------------------------------------------------------------------
# LOOK UP THE LATEST UBUNTU AMI
# ---------------------------------------------------------------------------------------------------------------------


#data "aws_ami" "ubuntu" {
#  most_recent = true
#  owners      = ["099720109477"] # Canonical


#  filter {
#    name   = "virtualization-type"
#    values = ["hvm"]
#  }


#  filter {
#    name   = "architecture"
#    values = ["x86_64"]
#  }


#  filter {
#    name   = "image-type"
#    values = ["machine"]
#  }


#  filter {
#    name   = "name"
#    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
#  }
#}

