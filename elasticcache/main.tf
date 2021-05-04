provider "aws" {
  region = var.aws_region
}

resource "aws_elasticache_cluster" "ec01" {
  cluster_id           = "ec01"
  engine               = "memcached"
  node_type            = "cache.m4.large"
  num_cache_nodes      = 1
  parameter_group_name = "default.memcached1.6"
  port                 = 11211
}

output "cluster-address" {
  value = aws_elasticache_cluster.ec01.cluster_address
}
