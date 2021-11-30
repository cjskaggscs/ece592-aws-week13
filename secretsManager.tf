# Create a secret for Secrets Manager to manage (rather redundant...)
resource "aws_secretsmanager_secret" "week13-secret" {
  name = "week13-secret"
}

# Create the secret actually containing the information we want
resource "aws_secretsmanager_secret_version" "week13-secret" {
  secret_id     = aws_secretsmanager_secret.week13-secret.id
  secret_string = jsonencode(local.week13-secret)
}

# Secret to be converted to JSON
locals {
  week13-secret = {
    username = aws_rds_cluster.week13-rds.master_username
    password = aws_rds_cluster.week13-rds.master_password
    db       = aws_rds_cluster.week13-rds.endpoint
  }
}
