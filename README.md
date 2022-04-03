# Aviatrix Public Subnet Filtering (PSF) Gateway Terraform module

Terraform module to deploy Aviatrix PSF Gateway on an existing VPC

## Deploy Single PSF Gateway

```hcl
module "ingress_psf_gw" {
  source  = "bayupw/psf-gw/aviatrix"
  version = "1.0.1"

  gw_name            = "ingress-psf"
  account            = "aws-account"
  region             = "ap-southeast-2"
  cidr               = "10.0.0.0/16"
  vpc_id             = "vpc-0a1b2c3d4e"
  route_table_ids    = ["rtb-0a1b2c3d4e"]
  ha_gw              = false
}
```

## Deploy PSF Gateway in HA

```hcl
module "ingress_psf_gw" {
  source  = "bayupw/psf-gw/aviatrix"
  version = "1.0.1"

  gw_name            = "ingress-psf"
  account            = "aws-account"
  region             = "ap-southeast-2"
  cidr               = "10.0.0.0/16"
  vpc_id             = "vpc-0a1b2c3d4e"
  route_table_ids    = ["rtb-0a1b2c3d4e"]
  ha_route_table_ids = ["rtb-1b2c3d4e5f"]
}
```

## Full example deploy PSF Gateway in HA

```hcl
resource "aviatrix_vpc" "ingress_vpc" {
  cloud_type           = 1
  account_name         = var.aws_account
  region               = data.aws_region.current.name
  name                 = "ingress-vpc"
  cidr                 = "10.102.0.0/16"
  aviatrix_transit_vpc = false
  aviatrix_firenet_vpc = false
  subnet_size          = 26
  num_of_subnet_pairs  = 3
}

data "aws_route_table" "ingress_vpc_pub_rtb1" {
  subnet_id = aviatrix_vpc.ingress_vpc.public_subnets[0].subnet_id
}

data "aws_route_table" "ingress_vpc_pub_rtb2" {
  subnet_id = aviatrix_vpc.ingress_vpc.public_subnets[1].subnet_id
}

module "ingress_psf_gw" {
  source  = "bayupw/psf-gw/aviatrix"
  version = "1.0.0"

  gw_name            = "ingress-psf"
  account            = var.aws_account
  region             = data.aws_region.current.name
  cidr               = aviatrix_vpc.ingress_vpc.cidr
  vpc_id             = aviatrix_vpc.ingress_vpc.vpc_id
  route_table_ids    = [data.aws_route_table.ingress_vpc_pub_rtb1.route_table_id]
  ha_route_table_ids = [data.aws_route_table.ingress_vpc_pub_rtb2.route_table_id]
}
```

## License

Apache 2 Licensed. See [LICENSE](https://github.com/terraform-aviatrix-psf-gw/tree/master/LICENSE) for full details.
