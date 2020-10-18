
# Due to: Error creating ElasticSearch domain: ValidationException: Before you can proceed, you must enable a service-linked role to give Amazon ES permissions to access your VPC.
# Solved with: https://stackoverflow.com/questions/47229247/validationexception-before-you-can-proceed-you-must-enable-a-service-linked-ro (Terraform related Answer)


resource "aws_iam_service_linked_role" "es" {
  count = var.create_elastic_iam_service_linked_role == true ? 1 : 0
  aws_service_name = "es.amazonaws.com"
  description      = "Allows Amazon ES to manage AWS resources for a domain on your behalf."
}

# ------------------------------------- Domain access --------------------------------------- #

resource "aws_elasticsearch_domain_policy" "main" {
  domain_name = aws_elasticsearch_domain.es_domain.domain_name

  access_policies = <<POLICIES
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "es:*",
            "Principal": "*",
            "Effect": "Allow",
            "Condition": {
                "IpAddress": { "aws:SourceIp": "${var.domain_access_ip}" }
            },
            "Resource": "${aws_elasticsearch_domain.es_domain.arn}/*"
        }
    ]
}
POLICIES
}


# ------------------------------------- Logging --------------------------------------- #
data "aws_iam_policy_document" "elasticsearch-log-publishing-policy" {
  statement {
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:PutLogEventsBatch",
    ]

    resources = ["arn:aws:logs:*"]

    principals {
      identifiers = ["es.amazonaws.com"]
      type        = "Service"
    }
  }
}

resource "aws_cloudwatch_log_resource_policy" "elasticsearch-log-publishing-policy" {
  policy_document = data.aws_iam_policy_document.elasticsearch-log-publishing-policy.json
  policy_name     = "elasticsearch-log-publishing-policy"
}