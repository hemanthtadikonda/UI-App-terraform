locals {
  vpc_id = lookup(lookup(module.vpc,"main",null), "vpc_id",null)

  app_subnets =  [ for k, v in lookup(lookup(lookup(lookup(module.vpc, "main", null), "vpc", null), "app", null), "subnets_ids", null) : v.id ]

  app_subnets_cidr =  [ for k, v in lookup(lookup(lookup(lookup(module.vpc, "main", null), "vpc", null), "app", null), "subnets_ids", null) : v.cidr_block ]
}


