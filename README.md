A Terraform module to create a Redis ElastiCache cluster.
===========

A terraform module providing a Redis ElastiCache cluster in AWS.

This module

- Stuff this module does


----------------------
#### Required
- `env" - "env to deploy into, should typically dev/staging/prod"
- `vpc_id"  - "VPC ID"

#### Optional

- `cluster_size` " - "Consul cluster size. This must be greater the 3, defaults to 3"

Usage
-----

```hcl
module "consul-cluster" {
  source                     = "./terraform-consul-cluster"
  alb_log_bucket             = "some-bucket-name"             # "some-bucket-name"
  cluster_size               = 3                              # Must be 3 or more
  dns_zone                   = "example.com"                  # "example.com."
  ecs_cluster_id             = "${module.ecs.cluster_id}"
  env                        = "dev"                          # dev/staging/prod
  join_ec2_tag               = "dev-infra ECS Node"           # "dev-infra ECS Node"
  subnets                    = ["10.0.0.0/24", "10.0.1.0/24"] # List of networks
  vpc_id                     = "vpc-e1234567"                 # "vpc-e1234567"
  sha_htpasswd_hash          = "consul:{SHA}zblahblah="       # "consul:{SHA}z...="
  oauth2_proxy_htpasswd_file = "/conf/htpasswd"               # "path to httpsswd file"
  oauth2_proxy_provider      = "github"                       # This module is designed to use github
  oauth2_proxy_github_org    = "FitnessKeeper"                # Github Org
  oauth2_proxy_github_team   = "devops"
  oauth2_proxy_client_id     = "0d440bd55527cfe3149e"
  oauth2_proxy_client_secret = "04b17e65fb10g96ff88fa2a4edad48528777e75b"
}

```

Outputs
=======


Authors
=======

[Tim Hartmann](https://github.com/tfhartmann)

License
=======
