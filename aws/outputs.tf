output "ami" {
  description = "AWS AMI"
  value       = data.aws_ami.ubuntu.name
}

output "ssh" {
  description = "ssh command"
  value       = "ssh ubuntu@${module.ec2.public_ip}"
}
