A Terraform module to create a Redis ElastiCache cluster.
===========

A terraform module providing a Redis ElastiCache cluster in AWS.

This module

- Creates redis ElastiCache clusters
- Create, manage and export a Security group

----------------------
#### Required
- `env" - "env to deploy into, should typically dev/staging/prod"
- `name` - "Name for the Redis replication group i.e. UserObject"
- `redis_clusters` - "Number of Redis cache clusters (nodes) to create"
- `subnets` - "List of VPC Subnet IDs for the cache subnet group"
- `vpc_id"  - "VPC ID"


#### Optional

- `apply_immediately` - "Specifies whether any modifications are applied immediately, or during the next maintenance window. Default is false."
- `allowed_cidr` - "A list of Security Group ID's to allow access to. Defaults to localhost"
- `allowed_security_groups` - "A list of Security Group ID's to allow access to. Defaults to empty list"
- `redis_failover` - "Defaults to false"
- `redis_node_type` - "Instance type to use for creating the Redis cache clusters Defaults to cache.t2.micro"
- `redis_port` - "Defaults to 6379"
- `redis_version` - "Redis version to use, defaults to 3.2.4"

Usage
-----

```hcl
module "redis" {
  source = "../modules/terraform-redis-elasticache"
  env            = "${var.env}"
  name           = "thtest"
  redis_clusters = "2"
  redis_failover = "true"
  subnets        = "${module.vpc.database_subnets}"
  vpc_id         = "${module.vpc.vpc_id}"
}
```

Outputs
=======

- `redis_security_group_id`
- `parameter_group`
- `redis_subnet_group_name`
- `redis_subnet_group_ids`
- `id`
- `port`
- `endpoint` 
- `configuration_endpoint_address`


Authors
=======

[Tim Hartmann](https://github.com/tfhartmann)

License
=======
