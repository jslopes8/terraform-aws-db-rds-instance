data "aws_iam_policy_document" "main" {
    count = var.create && var.enhanced_monitoring ? 1 : 0
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
resource "aws_iam_role" "main" {
    count = var.create && var.enhanced_monitoring ? 1 : 0

    name               = "${var.db_name}-MonitoringRole"
    assume_role_policy = data.aws_iam_policy_document.main.0.json

    tags = merge(
        {
            "Name" = "${format("%s", var.db_name)}-MonitoringRole"
        },
        var.default_tags,
  )
}

resource "aws_iam_role_policy_attachment" "main" {
    count = var.create && var.enhanced_monitoring ? 1 : 0

    role       = aws_iam_role.main.0.name
    policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}

resource "random_id" "snapshot_identifier" {
    count = var.create ? 1 : 0

    byte_length = 4
    keepers = {
        id = var.db_name
    }
}

resource "aws_db_instance" "main" {
    count = var.create ? 1 : 0

    identifier                      = lower(replace(var.db_name, " ", "-"))
    instance_class                  = var.instance_class
    engine                          = var.engine
    username                        = var.username
    engine_version                  = var.engine_version
    multi_az                        = var.multi_az
    password                        = var.password
    publicly_accessible             = var.publicly_accessible
    vpc_security_group_ids          = var.vpc_security_group_ids
    auto_minor_version_upgrade      = var.auto_minor_version_upgrade
    apply_immediately               = var.apply_immediately
    backup_window                   = var.backup_window
    backup_retention_period         = var.backup_retention_period
    maintenance_window              = var.maintenance_window
    ca_cert_identifier              = var.ca_cert_identifier
    allocated_storage               = var.allocated_storage
    iops                            = var.iops
    storage_type                    = var.storage_type
    storage_encrypted               = var.storage_encrypted
    replicate_source_db             = var.db_replicate_source

    db_subnet_group_name            = length(aws_db_subnet_group.main) > 0 ? aws_db_subnet_group.main.0.id : null
    parameter_group_name            = length(aws_db_parameter_group.main) > 0 ? aws_db_parameter_group.main.0.name : var.parameter_group_name

    snapshot_identifier             = var.snapshot_identifier
    final_snapshot_identifier       = "${lower(replace(var.db_name, " ", "-"))}-${random_id.snapshot_identifier.0.hex}-final-snapshot"
    skip_final_snapshot             = var.skip_final_snapshot

    enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports
    performance_insights_enabled    = var.performance_insights_enabled
    monitoring_role_arn             = length(aws_iam_role.main) > 0 ? aws_iam_role.main.0.arn : null
    monitoring_interval             = var.monitoring_interval

    copy_tags_to_snapshot   = var.copy_tags_to_snapshot
    tags    = merge(
        {
            "Name"  =   var.db_name
        },
        var.default_tags
    )

    lifecycle {
        ignore_changes = [snapshot_identifier]
    }

    depends_on = var.enabled_depends_on
}
resource "aws_db_parameter_group" "main" {
    count = var.create ? length(var.db_parameter_group) : 0

    name   = lookup(var.db_parameter_group[count.index], "name", null)
    family = lookup(var.db_parameter_group[count.index], "family", null)

    dynamic "parameter" {
        for_each = lookup(var.db_parameter_group[count.index], "parameter", null)
        content {
            name    = lookup(parameter.value, "name", null)
            value   = lookup(parameter.value, "value", null)
        }
    }
}
resource "aws_db_subnet_group" "main" {
    count = var.create ? length(var.db_subnet_group) : 0

    name       = lookup(var.db_subnet_group[count.index], "name", null)
    subnet_ids = lookup(var.db_subnet_group[count.index], "subnet_ids", null)

    tags = merge(
        {
            "Name" = "${format("%s", var.db_name)}-Subnet-Group"
        },
        var.default_tags,
  )
}







