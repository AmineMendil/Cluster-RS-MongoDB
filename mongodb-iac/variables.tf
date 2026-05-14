# Région AWS
variable "region" {
  description = "AWS region"
  type        = string
}

# Type des instances EC2
variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

# AMI Ubuntu (image système)
variable "ami_id" {
  description = "AMI ID pour Ubuntu"
  type        = string
}

# Nom de la clé SSH AWS
variable "key_name" {
  description = "SSH key pair name"
  type        = string
}