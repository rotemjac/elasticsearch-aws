
# --------- General --------- #

variable "project_name" {
  description = "Name to be used on all the resources as project identifier"
  default     = "elastic-kibana-lab"
}

variable "environment" {
  description = "Project environment"
  default =     "test-lab"
}


variable "region" {
  description = "Name of region"
  default     = "ap-south-1"
}

variable "region_azs" {
  description = ""
  type = "list"
  default = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
}

# --------- Security --------- #

variable "domain_access_ip" {
  description = ""
  default = "<my-ip>"
}

# --------------------- Use only once ----------------------------- #
variable "create_elastic_iam_service_linked_role" {
  description = ""
  default     = false
}