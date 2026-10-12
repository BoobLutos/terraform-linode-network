resource "linode_vpc" "this" {
  label       = "${var.name}-${var.environment}"
  region      = var.region
  description = "Managed by Terraform (${var.environment})"
}

resource "linode_vpc_subnet" "this" {
  for_each = var.subnets

  vpc_id = linode_vpc.this.id
  label  = each.key
  ipv4   = each.value
}
