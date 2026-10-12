variable "name" {
  description = "Base name for the VPC. The environment is appended, e.g. \"pilot\" becomes \"pilot-dev\"."
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9-]{3,40}$", var.name))
    error_message = "name must be 3-40 characters: lowercase letters, digits and hyphens."
  }
}

variable "environment" {
  description = "Environment name (dev, staging or prod)."
  type        = string

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "environment must be one of: dev, staging, prod."
  }
}

variable "region" {
  description = "Linode region ID, e.g. se-sto (Stockholm) or eu-central (Frankfurt)."
  type        = string
}

variable "subnets" {
  description = "Map of subnet label to IPv4 CIDR. Subnet labels are used by other workspaces to look the subnet up."
  type        = map(string)
  default = {
    app = "10.0.1.0/24"
  }

  validation {
    condition     = alltrue([for cidr in values(var.subnets) : can(cidrhost(cidr, 0))])
    error_message = "Every subnet value must be a valid IPv4 CIDR."
  }
}
