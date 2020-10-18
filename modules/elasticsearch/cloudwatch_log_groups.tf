# ----------------- Elastic search log group ----------------- #
resource "aws_cloudwatch_log_group" "es_log_group_index_slow" {
  name              = "es-log-group-index-slow"
  retention_in_days = var.log_retention_in_days
  tags              = {
    "Environment" = var.environment
  }
}

resource "aws_cloudwatch_log_group" "es_log_group_search_slow" {
  name              = "es-log-group-search-slow"
  retention_in_days = var.log_retention_in_days
  tags              = {
    "Environment" = var.environment
  }
}

resource "aws_cloudwatch_log_group" "es_log_group_application" {
  name              = "es-log-group-application"
  retention_in_days = var.log_retention_in_days
  tags              = {
    "Environment" = var.environment
  }
}

resource "aws_cloudwatch_log_group" "es_log_group_audit" {
  count = 0
  name              = "es-log-group-audit"
  retention_in_days = var.log_retention_in_days
  tags              = {
    "Environment" = var.environment
  }
}