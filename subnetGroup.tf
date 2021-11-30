# Create a subnet group for database
resource "aws_db_subnet_group" "week13-subnetgroup" {
  name       = "week13-subnetgroup"
  subnet_ids = [aws_subnet.week13-pri-a.id, aws_subnet.week13-pri-b.id]

  tags = {
    Name = "week13-subnetgroup"
  }
}
