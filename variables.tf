variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "ap-southeast-1"
}

variable "name_prefix" {
  description = "Name prefix for application"
  type        = string
  default     = "jason-ce8-2.7"
}

variable "instance_type" {
  description = "Instance type of ec2"
  type        = string
  default     = "t2.micro"
}

variable "vpc_id" {
  description = "Virtual private cloud id"
  type        = string
  default     = "vpc-0488a02e392e3eea1" #shared vpc created for 2.7
}

