# Aviatrix Public Subnet Filtering (PSF) Terraform module

Terraform module for Aviatrix which deploys Aviatrix PSF Gateway on an existing VPC

## Module usage

```hcl
module "ingress_psf_gw" {
  source  = "bayupw/psf-gw/aviatrix"
  version = "1.0.0"

  gw_name = "ingress-psf"
  account = "aws-account"
  region = "ap-southeast-2"
  vpc_id = "vpc-0a1b2c3d4e"
  instance_size = "t2.micro"
  route_table_ids = ["rtb-0a1b2c3d4e"]
  ha_gw = false
}
```

## License

Apache 2 Licensed. See [LICENSE](https://github.com/terraform-aviatrix-firenet-vendor-integration/tree/master/LICENSE) for full details.
