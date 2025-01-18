module "vpc" {

  source = "git::https://github.com/hemanthtadikonda/UI-App-tf-vpc.git"

  for_each = var.vpc

  env = var.env
  default_vpc_id = var.default_vpc_id
  default_vpc_cidr_block = var.default_vpc_cidr_block
  def_route_table_id = var.def_route_table_id

  cidr = each.value["cidr"]
  subnets = each.value["subnets"]


}