
# --------- General --------- #

variable "project_name" {
  description = "Name to be used on all the resources as project identifier"
  default     = ""
}

variable "environment" {
  description = "Project environment"
  default =     ""
}

variable "bucket_name" {
  description = ""
  default     = "%s-es-snapshot-bucket"
}