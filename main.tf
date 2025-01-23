module "vpc" {

  source = "git::https://github.com/hemanthtadikonda/UI-App-tf-vpc.git"

  for_each = var.vpc

  env                    = var.env
  tags                   = var.tags
  default_vpc_id         = var.default_vpc_id
  default_vpc_cidr_block = var.default_vpc_cidr_block
  def_route_table_id     = var.def_route_table_id

  cidr    = each.value[ "cidr" ]
  subnets = each.value[ "subnets" ]

}

module "alb" {

  source = "git::https://github.com/hemanthtadikonda/UI-App-tf-alb.git"

  for_each = var.alb

  env            = var.env
  tags           = var.tags
  default_vpc_id = var.default_vpc_id

  vpc_id  = local.vpc_id
  subnets = each.value[ "internal" ] ? local.app_subnets : data.aws_subnets.main.ids

  internal           = each.value[ "internal" ]
  sg_port            = each.value[ "sg_port" ]
  sg_ingress_cidr    = each.value[ "sg_ingress_cidr" ]
  load_balancer_type = each.value[ "load_balancer_type" ]

}


module "app" {
  source = "git::https://github.com/hemanthtadikonda/UI-App-services.git"

  for_each =  var.app

  env      = var.env
  tags     = var.tags
  default_vpc_id      = var.default_vpc_id
  az     = var.az
  hosted_zone_id = var.hosted_zone_id
  default_vpc_cidr_block = var.default_vpc_cidr_block

  vpc_id  = local.vpc_id
  sg_ingress_cidr_blocks = local.app_subnets_cidr
  app_subnet_ids       = local.app_subnets

  service   = each.key
  app_port  = each.value["app_port"]
  health_check_path  = each.value["health_check_path"]
  lb_priority = each.value["lb_priority"]
  instance_type = each.value["instance_type"]
  desired_capacity = each.value["desired_capacity"]
  max_size = each.value["max_size"]
  min_size =each.value["min_size"]
  ami_id =each.value["ami_id"]
  key_name= each.value["key_name"]

  public_lb_dns_name = lookup(lookup(lookup(module.alb , "public" , null) , "alb" ,null), "dns_name",null)
  private_lb_dns_name = lookup(lookup(lookup(module.alb , "private" , null) , "alb" ,null), "dns_name",null)
  public_alb_listener_arn = lookup(lookup(lookup(module.alb , "public" ,null ), "lb_listener" , null) , "arn" , null )
  private_lb_listener_arn = lookup(lookup(lookup(module.alb , "private" ,null ), "lb_listener" , null) , "arn" , null )





}






