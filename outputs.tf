output "vpc_id" {
  description = "ID of the VPC."
  value       = linode_vpc.this.id
}

output "vpc_label" {
  description = "Label of the VPC. Other workspaces look the VPC up by this label."
  value       = linode_vpc.this.label
}

output "subnet_ids" {
  description = "Map of subnet label to subnet ID."
  value       = { for k, s in linode_vpc_subnet.this : k => s.id }
}
