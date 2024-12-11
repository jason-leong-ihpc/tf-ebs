# Create EC2 instance
resource "aws_instance" "ec2_ebs" {


  ami                    = "ami-04c913012f8977029"
  instance_type          = var.instance_type
  subnet_id              = data.aws_subnet.first.id # just use first private/public subnet in the vpc 
  vpc_security_group_ids = [aws_security_group.ec2_security_group.id]
  key_name               = "${var.name_prefix}-ec2" # use pre-created key
  # key_name = aws_key_pair.auth.key_name # use this if key is created in tf code

  associate_public_ip_address = true
  tags = {
    Name = "${var.name_prefix}-ec2"
  }
}

resource "aws_security_group" "ec2_security_group" {
  name_prefix = "${var.name_prefix}-ec2"
  description = "Allow traffic to webapp"
  vpc_id      = data.aws_vpc.selected.id


  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    from_port        = -1
    to_port          = -1
    protocol         = "icmp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }


  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }


  lifecycle {
    create_before_destroy = true
  }
}

# Create EBS volume
resource "aws_ebs_volume" "attached_storage" {
  availability_zone = data.aws_subnet.first.availability_zone
  size              = 1
  type              = "gp3"
  iops              = 3000
  throughput        = 125
  tags = {
    Name = "${var.name_prefix}-ebs-volume"
  }
}

# Attach the EBS volume to the EC2 instance
resource "aws_volume_attachment" "ebs-ec2-attach" {
  device_name = "/dev/sdb"
  volume_id   = aws_ebs_volume.attached_storage.id
  instance_id = aws_instance.ec2_ebs.id
}