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
    default = true
}
variable "engine_version" {
    type    = string
}
variable "db_subnet_group_name" {
    type    = string
}
variable "allocated_storage" {
    type    = number
}
variable "iops" {
    type    = number
}
variable "maintenance_window" {
    type    = string
}
variable "storage_type" {
    type    = string
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
}
variable "snapshot_identifier" {
    type    = string
}
variable "skip_final_snapshot" {
    type    = bool
    default = false
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
    type    = list(string)
    default = []
}
variable "password" {
    type    = string
}
variable "performance_insights_enabled"  {
    type    = bool
    default = false
}
variable "create_monitoring_role" {
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
variable "monitoring_role_arn" {
    type    = string
    default = ""
}
variable "copy_tags_to_snapshot" {
    type    = bool
    default = true
}
variable "default_tags" {
    type    = map(string)
    default = {}
}
