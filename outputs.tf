output "endpoint" {
    value   = aws_db_instance.main.0.address
}
output "id" {
    value   = aws_db_instance.main.0.id
}