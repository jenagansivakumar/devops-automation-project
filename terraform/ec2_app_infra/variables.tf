variable "ec2_name" {
  description = "This is the name of the EC2 instance"
  type = string
}

variable "region" {
  description = "This is the region the EC2 instance will be set to"
  type = string
}

variable "ami_id" {
  description = "This will indicate which AMI ID we will use for the EC2 instance"
  type = string
}

variable "cidr_block" {
  description = "This specifies the CIDR block"
}

variable "subnet_config" {
  description = "Map of subnets with names, CIDR blocks and public/private designations"
  type = map(object({
    cidr_block = string
    public = bool
  }))
  default = {
    public_subnet = {
      cidr_block = "10.0.1.0/24"
      public = true
    }
    private_subnet = {
      cidr_block = "10.0.2.0/24"
      public = false
    }
  }
}