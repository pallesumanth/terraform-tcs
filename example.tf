provider "aws" {
region = "ap-south-1"
}
resource "aws_instance" "instance01" {
ami = "ami-09ba48996007c8b50"
instance_type = "t2.micro"
tags = {
"Name" = "terraform-91"
"environment" = "dev"
}
depends_on = [aws_ebs_volume.diskSize]
}
resource "aws_ebs_volume" "diskSize" {
availability_zone = "ap-south-1a"
size = 10
}
resource "aws_volume_attachment" "ebs_add" {
device_name = "/dev/xvdf"
volume_id = aws_ebs_volume.diskSize.id
instance_id = aws_instance.instance01.id
}
resource "aws_eip" "newIP" {
instance = aws_instance.instance01.id
vpc = true
}