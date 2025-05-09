# Create SNS Topic
resource "aws_sns_topic" "tadka_twist_alerts" {
  name = "tadka-twist-alerts"
}

# Email subscription to SNS Topic
resource "aws_sns_topic_subscription" "email_alert" {
  topic_arn = aws_sns_topic.tadka_twist_alerts.arn
  protocol  = "email"
  endpoint  = var.alert_email
}

# CloudWatch Alarm for RDS CPU > 70%
resource "aws_cloudwatch_metric_alarm" "rds_cpu_high" {
  alarm_name          = "TadkaTwistRDSHighCPU"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/RDS"
  period              = 60
  statistic           = "Average"
  threshold           = 70

  dimensions = {
    DBInstanceIdentifier = aws_db_instance.tadka_twist_db.id
  }

  alarm_description = "This alarm triggers when RDS CPU usage exceeds 70%."
  alarm_actions     = [aws_sns_topic.tadka_twist_alerts.arn]

  tags = {
    Name = "rds-cpu-alarm"
  }
}
