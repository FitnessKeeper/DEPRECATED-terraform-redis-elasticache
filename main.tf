data "aws_vpc" "vpc" {
  id = "${var.vpc_id}"
}

#data "aws_route53_zone" "zone" {
#  name = "${var.dns_zone}"
#}
# End Data


resource "aws_elasticache_replication_group" "redis" {
  #replication_group_id          = "tf-${var.name}-${data.aws_vpc.vpc.tags["Name"]}"
  replication_group_id          = "${format("%.20s","${var.name}-${var.env}")}"
  replication_group_description = "Terraform-managed ElastiCache replication group for ${var.name}-${data.aws_vpc.vpc.tags["Name"]}"
  number_cache_clusters         = "${var.redis_clusters}"
  node_type                     = "${var.redis_node_type}"
  #automatic_failover_enabled    = "${var.redis_failover}"
  engine_version                = "${var.redis_version}"
  port                          = "${var.redis_port}"
  parameter_group_name          = "${aws_elasticache_parameter_group.redis_parameter_group.id}"
  subnet_group_name             = "${aws_elasticache_subnet_group.redis_subnet_group.id}"
  security_group_ids            = ["${aws_security_group.redis_security_group.id}"]
  apply_immediately             = "${var.apply_immediately}"
}

resource "aws_elasticache_parameter_group" "redis_parameter_group" {
  name        = "tf-redis-${var.name}-${data.aws_vpc.vpc.tags["Name"]}"
  description = "Terraform-managed ElastiCache parameter group for ${var.name}-${data.aws_vpc.vpc.tags["Name"]}"
  family      = "redis${replace(var.redis_version, "/\\.[\\d+]$/","")}" # Strip the patch version from redis_version var
}

resource "aws_elasticache_subnet_group" "redis_subnet_group" {
  name       = "tf-redis-${var.name}-${data.aws_vpc.vpc.tags["Name"]}"
  subnet_ids = ["${var.subnets}"]
}

resource "aws_security_group" "redis_security_group" {
  name        = "tf-sg-ec-${var.name}-${data.aws_vpc.vpc.tags["Name"]}"
  description = "Terraform-managed ElastiCache security group for ${var.name}-${data.aws_vpc.vpc.tags["Name"]}"
  vpc_id      = "${var.vpc_id}"

  tags {
    Name = "tf-sg-ec-${var.name}-${data.aws_vpc.vpc.tags["Name"]}"
  }
}
/*
# evaluate these  - https://www.terraform.io/docs/providers/aws/r/security_group.html#ingress
# ingress blocks allow passing lists as an input, where as group_rules only allow a single SG/CIDR blocks
resource "aws_security_group_rule" "redis_application_ingress" {
  type                     = "ingress"
  from_port                = "${var.redis_port}"
  to_port                  = "${var.redis_port}"
  protocol                 = "tcp"
  source_security_group_id = "${var.application_security_group}"
  security_group_id        = "${aws_security_group.redis_security_group.id}"
}

resource "aws_security_group_rule" "redis_dba_ingress" {
  type                     = "ingress"
  from_port                = "${var.redis_port}"
  to_port                  = "${var.redis_port}"
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.dba_security_group.id}"
  security_group_id        = "${aws_security_group.redis_security_group.id}"
}
*/
