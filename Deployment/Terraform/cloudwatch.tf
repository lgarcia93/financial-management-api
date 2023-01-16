
resource "aws_cloudwatch_log_group" "log-group" {
  name = "/aws/${var.app_name}-logs"
}
