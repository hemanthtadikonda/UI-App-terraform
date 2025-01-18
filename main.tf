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

#module "alb" {
#
#  source = "git::https://github.com/hemanthtadikonda/UI-App-tf-alb.git"
#
#  for_each = var.alb
#
#  env            = var.env
#  tags           = var.tags
#  default_vpc_id = var.default_vpc_id
#
#  vpc_id  = local.vpc_id
#  subnets = each.value[ "internal" ] ? local.app_subnets : data.aws_subnets.main.ids
#
#  internal           = each.value[ "internal" ]
#  sg_port            = each.value[ "sg_port" ]
#  sg_ingress_cidr    = each.value[ "sg_ingress_cidr" ]
#  load_balancer_type = each.value[ "load_balancer_type" ]
#
#}


