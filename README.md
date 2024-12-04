# terraform-google-network

This module creates a Google Cloud Platform (GCP) Virtual Private Cloud (VPC) and optional subnets.

## Features
- Create a VPC with optional subnets.
- Configure subnets with specific CIDR ranges and regions.

## Usage

```hcl
module "vpc" {
  source = "./modules/vpc"

  name                    = "my-vpc"
  auto_create_subnetworks = false
  description             = "VPC for my project"
  subnets = [
    {
      name   = "subnet-1"
      cidr   = "10.0.1.0/24"
      region = "us-central1"
    },
    {
      name   = "subnet-2"
      cidr   = "10.0.2.0/24"
      region = "us-east1"
    }
  ]
}
