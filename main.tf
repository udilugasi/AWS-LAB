provider "aws" {
  access_key = "AKIAIN5VSNQYQR52JVGQ"
  secret_key = "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"
  region     = "${var.aws_region}"
}

#----------------------------------------------------------------------------------------------------------------------
# DEPLOY MAIN VPC
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_vpc" "main_vpc" {
  cidr_block           = "${var.vpc_ip}"
  instance_tenancy     = "default"
  enable_dns_hostnames = "true"

  tags {
    Name     = "Main"
    Location = "Tel-Aviv"
  }
}

#----------------------------------------------------------------------------------------------------------------------
# DEPLOY SUBNET
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_subnet" "subnet_lab" {
  availability_zone = "${var.av_zone}"
  vpc_id            = "${aws_vpc.main_vpc.id}"
  cidr_block        = "${var.subnet_ip}"

  tags {
    Name = "Subnet-Lab"

    #Location = ""
  }
}

#----------------------------------------------------------------------------------------------------------------------
# Define INTERNET GATEWAY
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.main_vpc.id}"

  tags {
    Name = "VPC-IGW"
  }
}

#----------------------------------------------------------------------------------------------------------------------
# Define ROUTE TABLE  - (Allow Public Connection)
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_route_table" "pubsub" {
  vpc_id = "${aws_vpc.main_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }

  tags {
    Name = "Public-Subnet "
  }
}

#----------------------------------------------------------------------------------------------------------------------
# Assign the route table to the public Subnet
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_route_table_association" "sub_rt" {
  subnet_id      = "${aws_subnet.subnet_lab.id}"
  route_table_id = "${aws_route_table.pubsub.id}"
}

# ---------------------------------------------------------------------------------------------------------------------
# DEPLOY EC2 INSTANCES
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_instance" "lab1" {
  ami           = "${var.ami_ubuntu}"
  instance_type = "t2.micro"

  user_data              = "${data.template_file.user_data.rendered}"
  vpc_security_group_ids = ["${aws_security_group.sec_group.id}"]

  #iam_instance_profile        = "${aws_iam_instance_profile.new_profile.name}"
  availability_zone           = "${var.av_zone}"
  subnet_id                   = "${aws_subnet.subnet_lab.id}"
  associate_public_ip_address = true

  key_name = "${var.key_name}"

  tags {
    Name = "lab1-public"
  }
}

resource "aws_instance" "lab2" {
  ami           = "${var.ami_ubuntu}"
  instance_type = "t2.micro"

  user_data              = "${data.template_file.user_data.rendered}"
  vpc_security_group_ids = ["${aws_security_group.sec_group.id}"]

  #iam_instance_profile        = "${aws_iam_instance_profile.new_profile.name}"
  availability_zone           = "${var.av_zone}"
  subnet_id                   = "${aws_subnet.subnet_lab.id}"
  associate_public_ip_address = true

  key_name = "${var.key_name}"

  tags {
    Name = "lab2-public"
  }
}

data "template_file" "user_data" {
  template = "${file("${path.module}/user-data/user-data.sh")}"

  vars {
    instance_text = "${var.instance_text}"
    instance_port = "${var.instance_port}"
  }
}

#resource "aws_instance" "lab1" {
#  ami           = "ami-2757f631"
#  instance_type = "t2.micro"
#}

output "lab1_ip" {
  value = "${aws_instance.lab1.public_ip}"
}

output "lab2_ip" {
  value = "${aws_instance.lab2.public_ip}"
}
