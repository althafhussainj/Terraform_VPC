# Creating VPC
resource "aws_vpc" "myvpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "MyterraformVPC"
  }
}

# Creating Public Subnet
resource "aws_subnet" "publicsubnet" {
  vpc_id = aws_vpc.myvpc.id
  cidr_block = "10.0.1.0/24"
}

# Creating Private Subnet
resource "aws_subnet" "privatesubnet" {
  vpc_id = aws_vpc.myvpc.id
  cidr_block = "10.0.2.0/24"
}

# Create Internet Gateway
resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.myvpc.id
  tags = {
    Name = "myvpc"
  }

}

# Create Route Table
resource "aws_route_table" "PublicRT" {
  vpc_id = aws_vpc.myvpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW.id
  }
  tags = {
    Name = "MyRoute"
  }
  
}

# Create route table association 
resource "aws_route_table_association" "publicRTassociation"{
    subnet_id = aws_subnet.publicsubnet.id
    route_table_id = aws_route_table.PublicRT.id
    
}

