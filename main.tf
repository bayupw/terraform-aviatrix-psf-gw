resource "aviatrix_gateway" "this" {
  enable_public_subnet_filtering       = true
  cloud_type                           = 1
  gw_name                              = var.gw_name
  account_name                         = var.account
  vpc_reg                              = var.region
  vpc_id                               = var.vpc_id
  subnet                               = local.subnet
  gw_size                              = var.instance_size
  public_subnet_filtering_route_tables = var.route_table_ids
  zone                                 = "${var.region}${var.az1}"

  peering_ha_gw_size                      = var.ha_gw ? var.instance_size : null
  peering_ha_subnet                       = var.ha_gw ? local.ha_subnet : null
  peering_ha_zone                         = var.ha_gw ? "${var.region}${var.az2}" : null
  public_subnet_filtering_ha_route_tables = var.ha_gw ? var.ha_route_table_ids : null

  single_az_ha                                = var.single_az_ha
  public_subnet_filtering_guard_duty_enforced = var.guard_duty_enforced
  enable_encrypt_volume                       = var.enable_encrypt_volume
}