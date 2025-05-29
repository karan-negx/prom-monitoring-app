variable "aws_region" {
    type = string
    default = "us-east-1"
}

variable "ami_id" {
    default = "jahkjdsghfask"
}

variable "instance_type" {
    type = string
    default = "t2.micro"
}

variable "instance_name" {
    type = string
}