env                    = "dev"
default_vpc_id         = "vpc-05642ce42b99a7fae"
default_vpc_cidr_block = "172.31.0.0/16"
def_route_table_id     = "rtb-0dbc8b1b5e435955e"
az                     = [ "us-east-1a", "us-east-1b"]
hosted_zone_id         = "Z08613511MUJYQJT5FVBT"


tags   = {
  Application = "UserInfoApp"
  Region      = "us-east-1"
  Client      = "Hemanth"
  BusinessUnit = "Cloud Autonomics"
  CostCenter   = "UIApp123"
}

vpc = {
  main = {
    cidr    = "10.0.0.0/16"
    subnets = {
      public = {
        public1 = { az = "us-east-1a", cidr = "10.0.0.0/24" }
        public2 = { az = "us-east-1b", cidr = "10.0.1.0/24" }
      }
      app = {
        app1 = { az = "us-east-1a", cidr = "10.0.2.0/24" }
        app2 = { az = "us-east-1b", cidr = "10.0.3.0/24" }
      }
      db = {
        db1 = { az = "us-east-1a", cidr = "10.0.4.0/24" }
        db2 = { az = "us-east-1b", cidr = "10.0.5.0/24" }
      }
    }
  }
}

alb = {
  public = {
    internal   = false
    sg_port    = 80
    load_balancer_type = "application"
    sg_ingress_cidr    = [ "0.0.0.0/0" ]

  }

  private = {
    internal   = true
    sg_port    = 80
    load_balancer_type = "application"
    sg_ingress_cidr    =  [ "172.31.0.0/16" , "10.10.0.0/16" ]
  }
}


app = {
  frontend = {
    app-port    = 80
    health_check_path = "/"
    lb_priority = 1
    instance_type = "t3.micro"
    desired_capacity = 1
    max_size   = 1
    min_size   = 1
    ami_id     = "ami-0df8c184d5f6ae949"
    key_name   = "hemaN.vir"
  }
  backend= {
    app_port    = 5000
    health_check_path = "/health"
    lb_priority = 1
    instance_type = "t3.micro"
    desired_capacity = 1
    max_size   = 1
    min_size   = 1
    ami_id     = "ami-0df8c184d5f6ae949"
    key_name   = "hemaN.vir"
  }

}


variable "env" {}
variable "service" {}
variable "vpc_id" {}
variable "tags" {}
variable "app_port" {}
variable "sg_ingress_cidr_blocks" {}
variable "default_vpc_cidr" {}
variable "health_check_path" {}
variable "default_vpc_id" {}
variable "private_lb_add" {}
variable "public_lb_dns_name" {}
variable "private_lb_dns_name" {}
variable "private_lb_listener_arn" {}
variable "lb_priority" {}
variable "public_alb_listener_arn" {}
variable "instance_type" {}
variable "app_subnet_ids" {}
variable "desired_capacity" {}
variable "max_size" {}
variable "min_size" {}
variable "ami_id" {}