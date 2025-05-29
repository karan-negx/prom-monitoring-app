resource "aws_instance" "this" {
    ami = var.ami_id
    instance_type = var.instance_type
    tags = {
        name = var.instance_name
    }
}