# Aviatrix FireNet Vendor Integration Terraform module

Terraform module for Aviatrix which configures FireNet Vendor Integration

## Module usage

```hcl
module "vendor_integration" {
  source  = "bayupw/firenet-vendor-integration/aviatrix"
  version = "1.0.0"

  transit_firenet_vpc_id  = aviatrix_firewall_instance.fw_instance.vpc_id
  fw_instance_id          = aviatrix_firewall_instance.fw_instance.instance_id
  fw_name                 = aviatrix_firewall_instance.fw_instance.firewall_name
  fw_instance_vendor_type = "Palo Alto Networks VM-Series"
  fw_login_username       = "avxadmin"
  fw_instance_public_ip   = aviatrix_firewall_instance.fw_instance.public_ip
}
```

## Example usage with time_sleep delay before calling vendor integration

```hcl
# wait for after firewall instance is launched, before running vendor integration
resource "time_sleep" "wait_fw_instance" {
  create_duration = "600s"
  depends_on      = [aviatrix_firewall_instance.fw_instance]
}

module "vendor_integration" {
  source  = "bayupw/firenet-vendor-integration/aviatrix"
  version = "1.0.0"

  transit_firenet_vpc_id  = aviatrix_firewall_instance.fw_instance.vpc_id
  fw_instance_id          = aviatrix_firewall_instance.fw_instance.instance_id
  fw_name                 = aviatrix_firewall_instance.fw_instance.firewall_name
  fw_instance_vendor_type = "Palo Alto Networks VM-Series"
  fw_login_username       = "avxadmin"
  fw_instance_public_ip   = aviatrix_firewall_instance.fw_instance.public_ip

  # wait for firewall instance to be launched before calling vendor integration
  depends_on              = [time_sleep.wait_fw_instance]
}
```

## License

Apache 2 Licensed. See [LICENSE](https://github.com/terraform-aviatrix-firenet-vendor-integration/tree/master/LICENSE) for full details.
