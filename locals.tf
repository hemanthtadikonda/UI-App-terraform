locals {
  vpc_id = lookup(lookup(module.vpc,"main",null), "vpc_id",null)

  app_subnets = app_subnets = [ for k, v in lookup(lookup(lookup(lookup(module.vpc, "main", {}), "vpc", {}), "app", {}), "subnets_ids", {}) : v.id ]
}


