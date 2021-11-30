resource "aws_subnet" "week13-pri-b" {
  vpc_id                  = aws_vpc.week13-vpc.id
  cidr_block              = "10.0.4.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = "false"

  tags = {
    Name = "week13-pri-b"
  }
}
