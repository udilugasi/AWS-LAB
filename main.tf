provider "aws" {
  access_key = "${var.aws_access_key_id}"

  secret_key = "${var.aws_secret_access_key}"
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

  #iam_instance_profile
  availability_zone           = "${var.av_zone}"
  subnet_id                   = "${aws_subnet.subnet_lab.id}"
  associate_public_ip_address = true

  key_name = "${var.key_name}"

  connection {
    user        = "${var.ubuntu_user}"
    host        = "${self.public_dns}"
    private_key = "${file("${path.module}/${var.private_key_name}")}"
  }

  provisioner "file" {
    source      = "sys_info.sh"
    destination = "/tmp/sys_info.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/sys_info.sh",
      "/tmp/sys_info.sh",
    ]
  }

  tags {
    Name = "lab1-public"
  }

  provisioner "local-exec" {
    command = "aws ec2 stop-instances --region ${var.aws_region} --instance-ids ${self.id}"
  }
}

resource "aws_instance" "lab2" {
  ami           = "${var.ami_ubuntu}"
  instance_type = "t2.micro"

  user_data              = "${data.template_file.user_data.rendered}"
  vpc_security_group_ids = ["${aws_security_group.sec_group.id}"]

  #iam_instance_profile
  availability_zone           = "${var.av_zone}"
  subnet_id                   = "${aws_subnet.subnet_lab.id}"
  associate_public_ip_address = true

  key_name = "${var.key_name}"

  connection {
    user        = "${var.ubuntu_user}"
    host        = "${self.public_dns}"
    private_key = "${file("${path.module}/${var.private_key_name}")}"
  }

  provisioner "file" {
    source      = "sys_info.sh"
    destination = "/tmp/sys_info.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/sys_info.sh",
      "/tmp/sys_info.sh",
    ]
  }

  tags {
    Name = "lab2-public"
  }

  provisioner "local-exec" {
    command = "aws ec2 stop-instances --region ${var.aws_region} --instance-ids ${self.id}"
  }
}

data "template_file" "user_data" {
  template = "${file("${path.module}/user-data/user-data.sh")}"
}

/*
output "lab1_ip" {
  value = "${aws_instance.lab1.public_ip}"
}

output "lab2_ip" {
  value = "${aws_instance.lab2.public_ip}"
}
*/

