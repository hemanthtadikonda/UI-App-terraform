module "vpc" {

  source = "git::https://github.com/hemanthtadikonda/UI-App-tf-vpc.git"

  for_each = var.vpc

  env = var.env

  cidr = each.value["cidr"]
  subnets = each.value["subnets"]


}