# Create SNS service
resource "aws_sns_topic" "week13-sns" {
  name              = "week13-sns"
  kms_master_key_id = "alias/aws/sns"
}

# Create the SNS subscription
resource "aws_sns_topic_subscription" "week13-sns-subscription" {
  topic_arn = aws_sns_topic.week13-sns.arn
  protocol  = "email"
  endpoint  = "cameronskaggscs@gmail.com"
}
