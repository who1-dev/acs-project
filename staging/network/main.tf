module "network" {
  source = "../../modules/network"
  #source             = "git@github.com:who1-dev/terraform-network-template.git"
  default_tags        = var.default_tags
  namespace           = var.namespace
  env                 = var.env
  vpcs                = var.vpcs
  igws                = var.igws
  public_route_table  = var.public_route_table
  public_subnets      = var.public_subnets
  private_route_table = var.private_route_table
  private_subnets     = var.private_subnets
  eips                = var.eips
  natgws              = var.natgws
}