output "elasticsearch_domain_endpoint" {
  value = module.elasticsearch.elasticsearch_domain_endpoint
}

output "snapshot_bucket_arn" {
  value = module.s3.snapshot_bucket_arn
}