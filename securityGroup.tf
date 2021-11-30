# Create a security group for DB traffic on port 3306
resource "aws_security_group" "week13-rds-sg" {
  name        = "week13-rds-sg"
  description = "Allow TCP traffic on port 3306"
  vpc_id      = aws_vpc.week13-vpc.id

  ingress {
    description      = "TCP from anywhere"
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "week13-rds-sg"
  }
}

