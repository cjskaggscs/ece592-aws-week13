resource "aws_subnet" "week13-sub-b" {
  vpc_id                  = aws_vpc.week13-vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "week13-sub-b"
  }
}
