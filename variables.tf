variable "create" {
    type = bool
    default = true
}
variable "db_name" {
    type    = string
}
variable "instance_class" {
    type    = string
}
variable "engine" {
    type    = string
}
variable "multi_az" {
    type    = bool
    default = false
}
variable "engine_version" {
    type    = string
}
variable "allocated_storage" {
    type    = number
    default = "50"
}
variable "iops" {
    type    = number
    default = null
}
variable "maintenance_window" {
    type    = string
    default = null
}
variable "storage_type" {
    type    = string
    default = "gp2"
}
variable "auto_minor_version_upgrade" {
    type    = bool
    default = false
}
variable "apply_immediately" {
    type    = bool
    default = false
}
variable "backup_window" {
    type    = string
}
variable "backup_retention_period" {
    type    = number
    default = "1"
} 
variable "vpc_security_group_ids" {
    type    = list
    default = [] 
}
variable "snapshot_identifier" {
    type    = string
    default = null
}
variable "skip_final_snapshot" {
    type    = bool
    default = true
}
variable "publicly_accessible" {
    type    = bool
    default = false
}
variable "storage_encrypted" {
    type    = bool
    default = false
}
variable "enabled_cloudwatch_logs_exports" {
    type    = any
    default = []
}
variable "password" {
    type    = string
}
variable "username" {
    type    = string
}
variable "performance_insights_enabled"  {
    type    = bool
    default = false
}
variable "monitoring_interval" {
    type    = number
    default = 0
}
variable "ca_cert_identifier" {
    type    = string
    default = "rds-ca-2019"
}
variable "copy_tags_to_snapshot" {
    type    = bool
    default = true
}
variable "default_tags" {
    type    = map(string)
    default = {}
}
variable "db_subnet_group" {
    type = any
    default = []
}
variable "db_parameter_group" {
    type = any 
    default = []
}
variable "enhanced_monitoring" {
    type = bool
    default = false
}
variable "parameter_group_name" {
    type = any 
    default = ""
}
variable "db_replicate_source" {
  type = string
  default = null
}
