# Aviatrix Public Subnet Filtering (PSF) Gateway Terraform module

Terraform module to deploy Aviatrix PSF Gateway on an existing VPC

## Deploy Single PSF Gateway

```hcl
module "ingress_psf_gw" {
  source  = "bayupw/psf-gw/aviatrix"
  version = "1.0.0"

  gw_name = "ingress-psf"
  account = "aws-account"
  region = "ap-southeast-2"
  vpc_id = "vpc-0a1b2c3d4e"
  route_table_ids = ["rtb-0a1b2c3d4e"]
  ha_gw = false
}
```

## Deploy PSF Gateway in HA

```hcl
module "ingress_psf_gw" {
  source  = "bayupw/psf-gw/aviatrix"
  version = "1.0.0"

  gw_name = "ingress-psf"
  account = "aws-account"
  region = "ap-southeast-2"
  vpc_id = "vpc-0a1b2c3d4e"
  route_table_ids = ["rtb-0a1b2c3d4e"]
  ha_route_table_ids = ["rtb-1b2c3d4e5f"]
}
```

## License

Apache 2 Licensed. See [LICENSE](https://github.com/terraform-aviatrix-firenet-vendor-integration/tree/master/LICENSE) for full details.
