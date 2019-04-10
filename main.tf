#Github Webhook Demo
provider "aws" {
  region = "ap-south-1"
}

module "exampleapp" {
  source = "git::github.com/rajlocuz/tfexample_vpc_subnet_ec2_eip.git"
}

resource "aws_key_pair" "deployer" {
    key_name = "jenkins"
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDXRy5a85XQWHf/M/xGwoTir608j1ToXkd09idr3btvnMxkTMYrY72qnFBCDceIHscQGUi32xDYS2J9FRHAbyKK5Fw5jio2KYADNKHjJijUM3Tl2Khz/Z4FvG+GDJ/2qzRc0ddIExf1VHfH55mwIsiMf7tMLub6hp8WS3CFbQHB3qsnkQbcnhMqo6XBr8LUvmyh03LcLMTOVsWfHan5qGFYtHidVJMQxPryNu/GX68tUPTjO/4NjEsM+IKpYmbh+QrNqbVLssdq7jCI/nRYn7eCDYk4LJyeMNbIgfKlgo4BtT2zKjY+XZJ3ZY5hBHrAbEnq5Tad0ZBeMMsJKj0IBuup root@localhost.localdomain"
}
