variable "default_tags" {
  default = {
    "Name"  = "GroupX-vpc"
    "Owner" = "GroupX"
  }
  type        = map(any)
  description = "Default tags to be applied to all AWS resources"
}

variable "namespace" {
  type    = string
  default = "GroupX"
}

variable "app_role" {
  type    = string
  default = "Networking"
}

variable "env" {
  type    = string
  default = "DEV"
}

variable "region" {
  type    = string
  default = "us-east-1"
}


variable "vpcs" {
  type = map(object({
    name       = string
    cidr_block = string
  }))
  default = {
    vpc1 = {
      name       = "VPC-1"
      cidr_block = "10.1.0.0/16"
    }
  }
}

variable "igws" {
  type = map(object({
    name    = string
    vpc_key = string
    rt_key  = string
  }))
  default = {
    vpc1_igw = {
      name    = "IGW"
      vpc_key = "vpc1"
      rt_key  = "vpc1_pubrt1"
    }
  }
}

variable "public_route_table" {
  type = map(object({
    name    = string
    vpc_key = string
  }))
  default = {
    vpc1_pubrt1 = {
      name    = "Public-Route-Table-1"
      vpc_key = "vpc1"
    }
  }
}

variable "public_subnets" {
  type = map(object({
    name              = string
    vpc_key           = string
    rt_key            = string
    cidr_block        = string
    availability_zone = string

  }))
  default = {
    vpc1_pubsub1 = {
      name              = "Public-Subnet-1"
      vpc_key           = "vpc1"
      rt_key            = "vpc1_pubrt1"
      cidr_block        = "10.1.1.0/24"
      availability_zone = "us-east-1a"
    }
    vpc1_pubsub2 = {
      name              = "Public-Subnet-2"
      vpc_key           = "vpc1"
      rt_key            = "vpc1_pubrt1"
      cidr_block        = "10.1.2.0/24"
      availability_zone = "us-east-1b"
    }
    vpc1_pubsub3 = {
      name              = "Public-Subnet-3"
      vpc_key           = "vpc1"
      rt_key            = "vpc1_pubrt1"
      cidr_block        = "10.1.3.0/24"
      availability_zone = "us-east-1c"
    }
    vpc1_pubsub4 = {
      name              = "Public-Subnet-4"
      vpc_key           = "vpc1"
      rt_key            = "vpc1_pubrt1"
      cidr_block        = "10.1.4.0/24"
      availability_zone = "us-east-1d"
    }                    
  }
}

variable "private_route_table" {
  type = map(object({
    name    = string
    vpc_key = string
  }))
  default = {
    vpc1_prvrt1 = {
      name    = "Private-Route-Table-1"
      vpc_key = "vpc1"
    }
  }
}

variable "private_subnets" {
  type = map(object({
    name              = string
    vpc_key           = string
    rt_key            = string
    cidr_block        = string
    availability_zone = string
  }))
  default = {
    vpc1_prvsub1 = {
      name              = "Private-Subnet-1"
      vpc_key           = "vpc1",
      rt_key            = "vpc1_prvrt1"
      cidr_block        = "10.1.5.0/24"
      availability_zone = "us-east-1a"
    }
    vpc1_prvsub2 = {
      name              = "Private-Subnet-2"
      vpc_key           = "vpc1",
      rt_key            = "vpc1_prvrt1"
      cidr_block        = "10.1.6.0/24"
      availability_zone = "us-east-1b"
    }
  }
}

variable "eips" {
  type = map(object({
    name = string
  }))
  default = {
    "eip1" = {
      name = "EIP"
    }
  }
}


variable "natgws" {
  type = map(object({
    name        = string
    eip_key     = string
    pub_sub_key = string,
    rt_key      = string
  }))
  default = {
    pubsub1_natgw1 = {
      name        = "NATGW"
      eip_key     = "eip1"
      pub_sub_key = "vpc1_pubsub1"
      rt_key      = "vpc1_prvrt1"
    }
  }
}
