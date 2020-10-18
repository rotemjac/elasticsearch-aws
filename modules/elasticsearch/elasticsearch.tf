
resource "aws_elasticsearch_domain" "es_domain" {
  domain_name  = format("%s-elasticsearch", var.environment )
  elasticsearch_version = "7.4"

  depends_on = ["aws_iam_service_linked_role.es"]


  tags = {
    Domain = format("%sDomain", var.environment )
  }

  # DevOps - Clustering and Replication
  cluster_config {
    dedicated_master_enabled = true
    dedicated_master_type    = var.master_instance_type
    dedicated_master_count   = 3

    instance_type            = var.instance_type
    instance_count           = 3

    zone_awareness_enabled = true
    zone_awareness_config {
      availability_zone_count = length(var.region_azs)
    }

    warm_enabled = false
    #warm_count
    #warm_type
 }


  # Storage
  ebs_options{
    ebs_enabled = true
    volume_type = "gp2"
    volume_size = 10
    #iops
  }

  # Backups
  snapshot_options{
    automated_snapshot_start_hour = 20
  }

  # Security
  domain_endpoint_options{
    enforce_https = true
    tls_security_policy = "Policy-Min-TLS-1-0-2019-07"
  }

  encrypt_at_rest{
    enabled    = true
  }
  node_to_node_encryption{
    enabled = true
  }

  log_publishing_options     {
     cloudwatch_log_group_arn = aws_cloudwatch_log_group.es_log_group_index_slow.arn
     log_type                 = "INDEX_SLOW_LOGS"
     enabled                  = true
  }

  log_publishing_options{
     cloudwatch_log_group_arn = aws_cloudwatch_log_group.es_log_group_search_slow.arn
     log_type                 = "SEARCH_SLOW_LOGS"
     enabled                  = true
  }

  log_publishing_options{
     cloudwatch_log_group_arn = aws_cloudwatch_log_group.es_log_group_application.arn
     log_type                 = "ES_APPLICATION_LOGS"
     enabled                  = true
  }

  #log_publishing_options {
  #   cloudwatch_log_group_arn = aws_cloudwatch_log_group.es_log_group_audit.arn
  #   log_type                 = "AUDIT_LOGS"
  #   enabled                  = false #Error creating ElasticSearch domain: ValidationException: audit log publishing cannot be enabled as you do not have advanced security options configured.
  #}

  # Additional
  advanced_options={
    "rest.action.multi.allow_explicit_index" = true
  }

  #access_policies = Passed as a separated resource


  ## Use this in PROD for (security)
  #vpc_options{
    # subnet_ids = "${local.subnet_ids}"
    # security_group_ids = ["${aws_security_group.elasticsearch_domain_sg.id}"]
  #}
}
