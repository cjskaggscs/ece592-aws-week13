resource "aws_iam_role" "week13-role" {
  name = "week13-role"

  assume_role_policy = <<EOF
{
"Version": "2012-10-17",
"Statement": [
	{
	"Sid": "AllowEc2ToUseThisRole",
	"Action": "sts:AssumeRole",
	"Principal": {
		"Service": "ec2.amazonaws.com"
	},
	"Effect": "Allow"
	}
]
}
EOF
}

resource "aws_iam_role_policy_attachment" "week13-roleAttachment" {
  role       = aws_iam_role.week13-role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}
