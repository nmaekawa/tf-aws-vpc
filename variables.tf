variable "aws_region" {
    description = "EC2 Region for the VPC"
    default = "us-west-2"
}

variable "aws_key_name" {
    description = "ec2 ssh key name"
    default = "some-key"
}

variable "vpc_cidr" {
    description = "CIDR for the whole VPC"
    default = "192.168.0.0/16"
}

variable "az-subnet-mapping" {
  type = "list"
  description = "list of subnets to be created"

  default = [
      {
        az = "us-west-2a"
        cidr = "192.168.0.0/24"
      },
      {
        az = "us-west-2b"
        cidr = "192.168.1.0/24"
      },
      {
        az = "us-west-2c"
        cidr = "192.168.2.0/24"
      },
    ]
}

variable "amis" {
  description = "amis by region"
  default = {
    us-west-2 = "ami-06d51e91cea0dac8d"  # ubuntu 18.04
  }
}
