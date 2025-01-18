env                    = "dev"
default_vpc_id         = "vpc-05642ce42b99a7fae"
default_vpc_cidr_block = "172.31.0.0/16"
def_route_table_id     = "rtb-0dbc8b1b5e435955e"


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

