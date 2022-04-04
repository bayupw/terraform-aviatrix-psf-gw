# Aviatrix Public Subnet Filtering (PSF) Gateway Terraform module

Terraform module to deploy Aviatrix PSF Gateway

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

## Deploy PSF Gateway with HA

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

## Create a VPC from Aviatrix and Deploy PSF Gateway with HA 

```hcl
resource "aviatrix_vpc" "protected_vpc" {
  cloud_type           = 1
  account_name         = "aws-account"
  region               = "ap-southeast-2"
  name                 = "protected-vpc"
  cidr                 = "10.0.0.0/16"
  aviatrix_transit_vpc = false
  aviatrix_firenet_vpc = false
  subnet_size          = 26
  num_of_subnet_pairs  = 2
}

data "aws_route_table" "protected_vpc_pub_rtb1" {
  subnet_id = aviatrix_vpc.protected_vpc.public_subnets[0].subnet_id
}

data "aws_route_table" "protected_vpc_pub_rtb2" {
  subnet_id = aviatrix_vpc.protected_vpc.public_subnets[1].subnet_id
}

module "protected_psf_gw" {
  source  = "bayupw/psf-gw/aviatrix"
  version = "1.0.1"

  gw_name            = "psf"
  account            = "aws-account"
  region             = "ap-southeast-2"
  cidr               = aviatrix_vpc.protected_vpc.cidr
  vpc_id             = aviatrix_vpc.protected_vpc.vpc_id
  route_table_ids    = [data.aws_route_table.protected_vpc_pub_rtb1.route_table_id]
  ha_route_table_ids = [data.aws_route_table.protected_vpc_pub_rtb2.route_table_id]
}
```

## Create Spoke with Aviatrix mc-spoke module and Deploy PSF Gateway with HA 

```hcl
module "spoke_aws_1" {
  source  = "terraform-aviatrix-modules/mc-spoke/aviatrix"
  version = "1.1.1"

  cloud           = "AWS"
  name            = "Spoke1"
  cidr            = "10.0.0.0/16"
  region          = "ap-southeast-2"
  account         = "aws-account"
  transit_gw      = "avx-ap-southeast-2-transit"
}

data "aws_route_table" "spoke_aws_1_pub_rtb1" {
  subnet_id = module.spoke_aws_1.vpc.public_subnets[0].subnet_id
}

data "aws_route_table" "spoke_aws_1_pub_rtb2" {
  subnet_id = module.spoke_aws_1.vpc.public_subnets[1].subnet_id
}

module "psf_gw_1" {
  source  = "bayupw/psf-gw/aviatrix"
  version = "1.0.1"

  gw_name            = "psf"
  account            = "aws-account"
  region             = "ap-southeast-2"
  cidr               = module.spoke_aws_1.vpc.cidr
  vpc_id             = module.spoke_aws_1.vpc.vpc_id
  route_table_ids    = [data.aws_route_table.spoke_aws_1_pub_rtb1.route_table_id]
  ha_route_table_ids = [data.aws_route_table.spoke_aws_1_pub_rtb2.route_table_id]
}
```
## Contributing

Report issues/questions/feature requests on in the [issues](https://github.com/bayupw/terraform-aviatrix-psf-gw/issues/new) section.

## License

Apache 2 Licensed. See [LICENSE](https://github.com/bayupw/terraform-aviatrix-psf-gw/tree/master/LICENSE) for full details.
