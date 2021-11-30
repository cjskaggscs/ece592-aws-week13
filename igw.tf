resource "aws_internet_gateway" "week13-igw" {
  vpc_id = aws_vpc.week13-vpc.id

  tags = {
    Name = "week13-igw"
  }
}
