provider "aws" {
    region = var.aws_region
}

module "web_server" {
    source = "./modules/ec2-instances"
    ami_id = var.ami_id
    instance_type = var.instance_type
    instance_name = "web-server-ec2"
}

module "ebs_volume {
    source = "path to module"
    size = 
    type = 
}"