data "aws_ami" "amazon_linux" {

  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

}

resource "aws_kms_key" "ebs_key" {
  description = "KMS key for encrypting EBS volume"
}

resource "aws_instance" "smallcase_instance" {

  ami           = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type
  key_name      = var.key_pair_name
  associate_public_ip_address = true

  vpc_security_group_ids = [
    aws_security_group.instance_sg.id
  ]

  user_data = file("userdata.sh")

  root_block_device {
    volume_size = 10
    encrypted   = true
    kms_key_id  = aws_kms_key.ebs_key.arn
  }

  tags = {
    Name = "smallcase-devops-assignment"
  }

}