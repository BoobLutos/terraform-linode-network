# Unit tests that run without a Linode account: the provider is mocked.
# Run with: terraform test

mock_provider "linode" {
  # Linode IDs are numeric strings; the default mock values are random text.
  mock_resource "linode_vpc" {
    defaults = {
      id = "1001"
    }
  }
}

variables {
  name        = "pilot"
  environment = "dev"
  region      = "se-sto"
}

run "default_subnet" {
  command = plan

  assert {
    condition     = linode_vpc.this.label == "pilot-dev"
    error_message = "VPC label should be <name>-<environment>."
  }

  assert {
    condition     = keys(linode_vpc_subnet.this) == ["app"]
    error_message = "Default should create a single 'app' subnet."
  }
}

run "multiple_subnets" {
  command = plan

  variables {
    subnets = {
      app = "10.0.1.0/24"
      db  = "10.0.2.0/24"
    }
  }

  assert {
    condition     = length(linode_vpc_subnet.this) == 2
    error_message = "Expected two subnets."
  }

  assert {
    condition     = linode_vpc_subnet.this["db"].ipv4 == "10.0.2.0/24"
    error_message = "db subnet CIDR not passed through."
  }
}

run "rejects_invalid_cidr" {
  command = plan

  variables {
    subnets = { app = "not-a-cidr" }
  }

  expect_failures = [var.subnets]
}
