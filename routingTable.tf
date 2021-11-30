# Create the private routing table
resource "aws_route_table" "week13-pri-rt" {
  vpc_id = aws_vpc.week13-vpc.id

  route = []

  tags = {
    Name = "week13-pri-rt"
  }
}

# Create the routing table association for the first private subnet
resource "aws_route_table_association" "week13-rtAssociation1" {
  subnet_id      = aws_subnet.week13-pri-a.id
  route_table_id = aws_route_table.week13-pri-rt.id
}

# Create the routing table association for the second private subnet
resource "aws_route_table_association" "week13-rtAssociation2" {
  subnet_id      = aws_subnet.week13-pri-b.id
  route_table_id = aws_route_table.week13-pri-rt.id
}



# Create the public routing table
resource "aws_route_table" "week13-routeTablePublic" {
  vpc_id = aws_vpc.week13-vpc.id

  route = [
    {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.week13-igw.id

      # The following was added because it seems without this, the routing table cannot be created
      egress_only_gateway_id     = ""
      instance_id                = ""
      ipv6_cidr_block            = ""
      mat_gateway_id             = ""
      network_interface_id       = ""
      transit_gateway_id         = ""
      vpc_endpoint_id            = ""
      vpc_peering_connection_id  = ""
      carrier_gateway_id         = ""
      destination_prefix_list_id = ""
      local_gateway_id           = ""
      nat_gateway_id             = ""
    },
  ]

  tags = {
    Name = "week13-routeTablePublic"
  }
}

# Create the routing table association for the first public subnet
resource "aws_route_table_association" "week13-rtPublicAssociation1" {
  subnet_id      = aws_subnet.week13-sub-a.id
  route_table_id = aws_route_table.week13-routeTablePublic.id
}

# Create the routing table association for the first public subnet
resource "aws_route_table_association" "week13-rtPublicAssociation2" {
  subnet_id      = aws_subnet.week13-sub-b.id
  route_table_id = aws_route_table.week13-routeTablePublic.id
}
