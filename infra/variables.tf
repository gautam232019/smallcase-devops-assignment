variable "aws_region" {
  description = "AWS region"
  default     = "us-west-2"
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t3.micro"
}

variable "key_pair_name" {
  description = "Name of the existing AWS key pair to use for SSH access"
  default     = "smallcase"
}