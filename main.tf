module "elasticsearch" {
  source     = "./modules/elasticsearch"

  project_name     = var.project_name
  environment      = var.environment
  region           = var.region
  region_azs       = var.region_azs
  domain_access_ip = var.domain_access_ip

  create_elastic_iam_service_linked_role = var.create_elastic_iam_service_linked_role
}

module "s3" {
  source = "./modules/s3"
  project_name = var.project_name
  environment = var.project_name
}

#module "lambda" {
#    source = "./modules/lambda"
#}