# terraform-linode-network

Creates a Linode VPC and one or more subnets for an environment.

The repo name follows the `terraform-<provider>-<name>` convention that HCP Terraform's private registry requires, so it publishes as `app.terraform.io/<ORG>/network/linode`.

## Usage

```hcl
module "network" {
  source  = "app.terraform.io/<ORG>/network/linode"
  version = "~> 1.0"

  name        = "pilot"
  environment = "dev"
  region      = "se-sto"
  subnets     = { app = "10.0.1.0/24" }
}
```

## Inputs

| Name | Type | Default | Description |
| --- | --- | --- | --- |
| `name` | string | — | Base name; the VPC is labelled `<name>-<environment>` |
| `environment` | string | — | `dev`, `staging` or `prod` |
| `region` | string | — | Linode region ID |
| `subnets` | map(string) | `{ app = "10.0.1.0/24" }` | Subnet label → IPv4 CIDR |

## Outputs

| Name | Description |
| --- | --- |
| `vpc_id` | VPC ID |
| `vpc_label` | VPC label, used by other workspaces to look the VPC up |
| `subnet_ids` | Map of subnet label → subnet ID |

## Releasing

Merge to `main`, then push a semver tag (`git tag v1.0.0 && git push --tags`). HCP Terraform publishes the new version automatically.

###
