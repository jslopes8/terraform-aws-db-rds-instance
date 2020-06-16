data "aws_iam_policy_document" "enhanced_monitoring" {
    statement {
        actions = [
            "sts:AssumeRole",
        ]

        principals {
            type        = "Service"
            identifiers = ["monitoring.rds.amazonaws.com"]
        }
    }
}
resource "aws_iam_role" "enhanced_monitoring" {
    count = var.create_monitoring_role ? 1 : 0

    name               = "${var.db_name}-MonitoringRole"
    assume_role_policy = "${data.aws_iam_policy_document.enhanced_monitoring.json}"

    tags = merge(
        {
            "Name" = "${format("%s", var.db_name)}-MonitoringRole"
        },
        "${var.default_tags}",
  )
}

resource "aws_iam_role_policy_attachment" "enhanced_monitoring" {
    count = var.create_monitoring_role ? 1 : 0

    role       = "${aws_iam_role.enhanced_monitoring[0].name}"
    policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}


resource "aws_db_instance" "mydb" {
    identifier                      = "${lower(replace(var.db_name, " ", "-"))}"
    instance_class                  = "${var.instance_class}"
    engine                          = "${var.engine}"
    engine_version                  = "${var.engine_version}"
    multi_az                        = "${var.multi_az}"
    db_subnet_group_name            = "${var.db_subnet_group_name}"
    allocated_storage               = "${var.allocated_storage}"
    auto_minor_version_upgrade      = "${var.auto_minor_version_upgrade}"
    apply_immediately               = "${var.apply_immediately}"
    iops                            = "${var.iops}"
    storage_type                    = "${var.storage_type}"
    vpc_security_group_ids          = "${var.vpc_security_group_ids}"
    snapshot_identifier             = "${var.snapshot_identifier}"
    final_snapshot_identifier       = "${lower(replace(var.db_name, " ", "-"))}-final-snapshot"
    skip_final_snapshot             = "${var.skip_final_snapshot}"
    publicly_accessible             = "${var.publicly_accessible}"
    backup_window                   = "${var.backup_window}"
    backup_retention_period         = "${var.backup_retention_period}"
    maintenance_window              = "${var.maintenance_window}"
    storage_encrypted               = "${var.storage_encrypted}"
    ca_cert_identifier              = "${var.ca_cert_identifier}"
    enabled_cloudwatch_logs_exports = "${var.enabled_cloudwatch_logs_exports}"
    password                        = "${var.password}"
    performance_insights_enabled    = "${var.performance_insights_enabled}"

    monitoring_role_arn = "${coalesce(var.monitoring_role_arn, aws_iam_role.enhanced_monitoring.*.arn, null)}"
    monitoring_interval = "${var.monitoring_interval}"

    copy_tags_to_snapshot   = "${var.copy_tags_to_snapshot}"
    tags    = merge(
        {
            "Name"  =   "${var.db_name}"
        },
        "${var.default_tags}"
    )
}

