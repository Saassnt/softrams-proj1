#### Public Subnets

# Public Subnet on us-east-2 "Ohio"

resource "aws_subnet" "public_subnet_us_east_2a" {
  vpc_id                  = aws_vpc.cluster_vpc.id
  cidr_block = "10.10.16.0/20"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-2a"

  tags = {
    Name = "${var.cluster_name}-public-subnet-2a"
  }
}

# Public Subnet on us-east-2b
resource "aws_subnet" "public_subnet_us_east_2b" {
  vpc_id                  = aws_vpc.cluster_vpc.id
  cidr_block = "10.10.32.0/20"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-2b"

  tags = {
    Name = "${var.cluster_name}-public-subnet-2b"
  }
}

# Associate subnet public_subnet_us_east_2a to public route table
resource "aws_route_table_association" "public_subnet_us_east_2a_association" {
  subnet_id      = aws_subnet.public_subnet_us_east_2a.id
  route_table_id = aws_vpc.cluster_vpc.main_route_table_id
}

# Associate subnet public_subnet_us_east_2b to public route table
resource "aws_route_table_association" "public_subnet_us_east_2b_association" {
  subnet_id      = aws_subnet.public_subnet_us_east_2b.id
  route_table_id = aws_vpc.cluster_vpc.main_route_table_id
}
