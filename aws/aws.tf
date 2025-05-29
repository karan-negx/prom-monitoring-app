provider "aws" {
    name = "us-east"
}

resource "aws_key_pair" "ec2_key"{
    key_name = "ec2-key"
    public_key = "path to the folder where your public key is located"
 }

 aws "aws_security_group" "ec2_sg" {
    name = "ec2-sg"
    description = "Allow SSH"

    ingress{
        from_port = 22
        to_port = 22
        protocol = "tcp"
    }
    egress{
        from_port = 0
        to_port = 0
        protocol = "-1"
    }
 }

 resource "aws_instance" "ec2" {
    ami = ami-id
    instance_type = "t2-micro"
    key_name = aws_key_pair.ec2_key.key_name
    availability_zone = "us-east-1a"
    tags = {
        name = "ec2-instance"
    }
    depends_on = [aws_ebs_volume.extra_ebs_volume]
 }


 resource "aws_ebs_volume" "extra_ebs_volume"{
    availability_zone = "us-east-1a"
    size = 10          #GB
    type = "gp2"
    tags = {
        name = "extra_ebs_volume"
    }
 }

 resource  "aws_volume_attachment" "ebs_ec2_attachment" {
    device_name = "/dev/home"
    volume_id = aws_ebs_volume.extra_ebs_volume.id
    instance_id = aws_instance.ec2.id
    force_detach = true
 }




