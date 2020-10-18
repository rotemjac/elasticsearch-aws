
# --------- General --------- #

variable "project_name" {
  description = "Name to be used on all the resources as project identifier"
  default     = "elastic-kibana-lab"
}

variable "environment" {
  description = "Project environment"
  default =     ""
}


variable "region" {
  description = "Name of region"
  default     = ""
}

variable "region_azs" {
  description = ""
  type = "list"
  default = []
}


# --------- Networking --------- #
variable "vpc_cidr"              { default = "172.21.0.0/16" }
variable "data_tier_subnet_cidr" { default = "172.21.0.0/20"}
variable "data_tier_number_of_subnets"  { default = 3 }


##### Data Tier #####
variable "data_tier_name" {
  description = ""
  default = "Data"
}

variable "data_tier_propagating_vgws" {
  description = "A list of VGWs the public route table should propagate."
  default     = []
}


# --------- Instances --------- #
variable "master_instance_type" {
  default = "r5.large.elasticsearch"
}

variable "instance_type" {
  default = "r5.large.elasticsearch"
}

# --------- Security --------- #

variable "domain_access_ip" {
  description = ""
  default = ""
}

variable "https_port" {
  description = ""
  default = 443
}

variable "http_port" {
  description = ""
  default = 80
}

variable "log_retention_in_days" {
  description = ""
  default = 90
}

# -------------------------------------------------- #
variable "create_elastic_iam_service_linked_role" {
  description = ""
  default     = ""
}

