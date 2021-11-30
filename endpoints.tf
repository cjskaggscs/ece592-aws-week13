resource "aws_security_group" "week13-ssh-pri-sg" {
  name        = "week13-ssh-pri-sg"
  description = "Allow SSH from bastion"
  vpc_id      = aws_vpc.week13-vpc.id

  ingress = [
    {
      description      = "Bastion to host SSH"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = []
      security_groups  = [aws_security_group.week13-ssh-sg.id]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      self             = false
    }
  ]

  # cbb - Added this to allow all traffic outbound.
  egress = [
    {
      description = "Allow all outbound"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]

      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]
}

# Create SG to accept traffic from worker VM
resource "aws_security_group" "week13-https-sg" {
    name = "week13-https-sg"
    description = "Allow traffic from ssh SG over port 443"
    vpc_id = aws_vpc.week13-vpc.id

    ingress = [
        {
            description = "HTTP from bastion to worker node"
            from_port = 443
            to_port = 443
            protocol = "tcp"
            cidr_blocks      = [aws_vpc.week13-vpc.cidr_block]
            security_groups  = []
            ipv6_cidr_blocks = []
            prefix_list_ids  = []
            self = false
        }
    ]

    # TODO: This egress might not be needed but the worker node hangs on aws cli commands. This
    # will allow outbound traffic, but might be insecure in a real-world scenario because data
    # stolen can be exfiltrated to the internet. Delete if not needed
    egress = [
        {
            description = "All traffic from worker node to bastion"
            from_port = 0
            to_port = 0
            protocol = "-1"
            cidr_blocks = ["0.0.0.0/0"]

            ipv6_cidr_blocks = []
            prefix_list_ids = []
            security_groups = []
            self = false
        }
    ]
}

# Create an EC2 endpoint
resource "aws_vpc_endpoint" "week13-sm-ep" {
    vpc_id = aws_vpc.week13-vpc.id
    service_name = "com.amazonaws.us-east-1.secretsmanager"
    vpc_endpoint_type = "Interface"
    security_group_ids = [aws_security_group.week13-https-sg.id]
    private_dns_enabled = true
    subnet_ids = [aws_subnet.week13-pri-a.id, aws_subnet.week13-pri-b.id]

    tags = {
        name = "week13-sm2-ep"
    }
}
