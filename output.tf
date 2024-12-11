# Output the public IP of the EC2 instance
output "instance_public_ip" {
  value = aws_instance.ec2_ebs.public_ip
  description = "The public IP address of the EC2 instance"
}

output "key_pair_name" {
  value = aws_instance.ec2_ebs.key_name
  description = "The key pair used for EC2"
}

# output "instance_dns" {
#   value = aws_instance.aws_instance_dns

# }

# Output the ID of the EC2 instance
output "instance_id" {
  value = aws_instance.ec2_ebs.id
  description = "The ID of the EC2 instance"
}

# Output the ID of the security group
output "security_group_id" {
  value = aws_security_group.ec2_security_group.id
  description = "The ID of the security group"
}

# Output the ID of the security group
output "subnet_id" {
  value = aws_security_group.ec2_security_group.id
  description = "The ID of the security group"
}

output "EBS_volume" {
  value = aws_ebs_volume.attached_storage.id
  description = "The ID of the EBS volume"
}