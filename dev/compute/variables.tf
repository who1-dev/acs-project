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

variable "env" {
  type    = string
  default = "DEV"
}

variable "app_role" {
  type    = string
  default = "Compute"
}

variable "region" {
  type    = string
  default = "us-east1"
}

variable "remote_data_sources" {
  type = map(object({
    bucket = string
    key    = string
    region = string
  }))
  default = {
    network = {
      bucket = "backend-jcaranay-tf"
      key    = "dev/networking/terraform.tfstate"
      region = "us-east-1"
    }
  }
}

variable "bastion_hosts" {
  type = map(object({
    name          = string
    is_public     = bool
    instance_type = string
    subnet_key    = string
    key_name      = string
    sg_key        = string
    has_user_data = bool
    user_data     = string
    custom_tags   = map(any)
  }))
  default = {
    bh1 = {
      name          = "Bastion VM"
      is_public     = true
      instance_type = "t2.micro"
      subnet_key    = "vpc1_pubsub2"
      key_name      = "pub_kp"
      sg_key        = "bh1"
      has_user_data = true
      user_data     = "/user_data/install_httpd.sh"
      custom_tags   = null
    }
  }
}

variable "public_instances" {
  type = map(object({
    name          = string
    is_public     = bool
    instance_type = string
    subnet_key    = string
    key_name      = string
    sg_key        = string
    has_user_data = bool
    user_data     = string
    custom_tags   = map(any)
  }))
  default = {
    pub_vm3 = {
      name          = "Webserver 3"
      is_public     = true
      instance_type = "t2.micro"
      subnet_key    = "vpc1_pubsub3"
      key_name      = "pub_kp"
      sg_key        = "webserver"
      has_user_data = true
      user_data     = ""
      custom_tags = {
        is_ansible_managed = true
      }
    }
    pub_vm4 = {
      name          = "Webserver 4"
      is_public     = true
      instance_type = "t2.micro"
      subnet_key    = "vpc1_pubsub4"
      key_name      = "pub_kp"
      sg_key        = "webserver"
      has_user_data = false
      user_data     = ""
      custom_tags = {
        is_ansible_managed = true
      }
    }
  }
}


variable "private_instances" {
  type = map(object({
    name          = string
    is_public     = bool
    instance_type = string
    subnet_key    = string
    key_name      = string
    sg_key        = string
    has_user_data = bool
    user_data     = string
    custom_tags   = map(any)
  }))
  default = {
    prv_vm5 = {
      name          = "Webserver 5"
      is_public     = false
      instance_type = "t2.micro"
      subnet_key    = "vpc1_prvsub1"
      key_name      = "prv_kp"
      sg_key        = "prv_vm5"
      has_user_data = false
      user_data     = ""
      custom_tags   = null
    }
    prv_vm6 = {
      name          = "Webserver 6"
      is_public     = false
      instance_type = "t2.micro"
      subnet_key    = "vpc1_prvsub2"
      key_name      = "prv_kp"
      sg_key        = "prv_vm6"
      has_user_data = false
      user_data     = ""
      custom_tags   = null
    }
  }
}

variable "key_pairs" {
  type = map(object({
    name                = string
    key_name            = string
    public_key_location = string
  }))
  default = {
    pub_kp = {
      name                = "Public KP"
      key_name            = "public_kp.pub"
      public_key_location = "./key_pairs/public_kp.pub"
    }
    prv_kp = {
      name                = "Private KP"
      key_name            = "private_kp.pub"
      public_key_location = "./key_pairs/private_kp.pub"
    }
  }
}


variable "security_groups" {
  type = map(object({
    name        = string
    vpc_key     = string
    description = string
  }))
  default = {
    alb_sg = {
      name        = "ALB-SG"
      vpc_key     = "vpc1"
      description = "Security group for Application Load Balancer"
    }
    bh1 = {
      name        = "BastionVM-SG"
      vpc_key     = "vpc1"
      description = "Security group for Bastion Host VM"
    }
    webserver = {
      name        = "Webserver-SG"
      vpc_key     = "vpc1"
      description = "Security group for Webservers VM"
    }
    prv_vm5 = {
      name        = "Webserver 5 -SG"
      vpc_key     = "vpc1"
      description = "Security group for Webserver 5"
    }
    prv_vm6 = {
      name        = "Webserver 6-SG"
      vpc_key     = "vpc1"
      description = "Security group for Webserver 6"
    }
  }
}

variable "security_group_ingress_ssh" {
  type = map(object({
    description = string
    is_local    = bool
    remote_key  = any
    source      = string
  }))
  default = {
    bh1 = {
      description = "Allow SSH from everywhere"
      is_local    = true
      remote_key  = ""
      source      = "all"
    }
    webserver = {
      description = "Allow SSH from everywhere"
      is_local    = true
      remote_key  = ""
      source      = "all"
    }
    prv_vm5 = {
      description = "Allow SSH from Bastion Host only"
      is_local    = true
      remote_key  = ""
      source      = "bh1"
    }
    prv_vm6 = {
      description = "Allow SSH from Bastion Host only"
      is_local    = true
      remote_key  = ""
      source      = "bh1"
    }
  }
}

variable "security_group_ingress_http_ec2" {
  type = map(object({
    description = string
    source      = string
  }))
  default = {

    alb_sg = {
      description = "Allow HTTP to all for Load Balancer"
      source      = "all"
    }
    webserver = {
      description = "Allow HTTP to all webservers"
      source      = "all"
    }
    # prv_vm5 = {
    #   description = "Allow HTTP to all "
    #   source      = "all"
    # },
    # prv_vm6 = {
    #   description = "Allow HTTP to all "
    #   source      = "all"
    # }
  }
}


variable "security_group_ingress_http_to_ec2_using_sg" {
  type = map(object({
    description = string
    source      = string
  }))
  default = {
    # prv_vm5 = {
    #   description = "Allow HTTP from Application Load Balancer SG "
    #   source      = "alb_sg"
    # },
    # prv_vm6 = {
    #   description = "Allow HTTP from Application Load Balancer SG "
    #   source      = "alb_sg"
    # }
  }
}


variable "alb_target_groups" {
  type = map(object({
    name       = string
    vpc_key    = string
    port       = number
    protocol   = string
    remote_key = string
  }))
  default = {
    alb_tg1 = {
      name       = "ALB1-TG"
      vpc_key    = "vpc1"
      port       = 80
      protocol   = "HTTP"
      remote_key = "network"
    }
  }
}


variable "alb_target_group_attachments" {
  type = map(object({
    alb_tg_key = string
    ec2_key    = string
  }))
  default = {
  }
}

variable "albs" {
  type = map(object({
    name             = string
    is_internal      = bool
    target_group_key = string
    security_groups  = list(string)
    subnets          = list(string)
    remote_key       = string
  }))
  default = {
    alb1 = {
      name             = "VPC1-ALB"
      is_internal      = false
      target_group_key = "alb_tg1"
      security_groups  = ["alb_sg"]
      subnets          = ["vpc1_pubsub1", "vpc1_pubsub2", "vpc1_pubsub3"]
      remote_key       = "network"
    }
  }
}

variable "launch_templates" {
  type = map(object({
    name            = string
    instance_type   = string
    key_name        = string
    user_data       = string
    security_groups = list(string)
    tags = object({
      Name = string
    })
  }))
  default = {
    webserver_lt = {
      name            = "Webserver-Launch-Template"
      instance_type   = "t2.micro"
      key_name        = "pub_kp"
      user_data       = "/user_data/install_httpd.sh"
      security_groups = ["webserver"]
      tags = {
        Name = "Webserver Launch Template"
      }
    }
  }
}

variable "auto_scaling_groups" {
  type = map(object({
    name                        = string
    desired_capacity            = number
    max_size                    = number
    min_size                    = number
    launch_template_key         = string
    vpc_zone_identifier_subnets = list(string)
    remote_key                  = string
    target_group_arns           = string
  }))
  default = {
    asg1 = {
      name                        = "VPC1-ASG"
      desired_capacity            = 2
      max_size                    = 2
      min_size                    = 2
      launch_template_key         = "webserver_lt"
      vpc_zone_identifier_subnets = ["vpc1_pubsub1", "vpc1_pubsub2"]
      remote_key                  = "network"
      target_group_arns           = "alb_tg1"
    }
  }
}
