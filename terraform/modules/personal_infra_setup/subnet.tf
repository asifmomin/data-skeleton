// public subnet
resource "aws_subnet" "public_subnet" {
    vpc_id = aws_vpc.vpc.id
    count = length(split(",", var.availability_zones))
    cidr_block = element(var.public_subnet_cidrs, count.index)
    availability_zone = element(split (",", var.availability_zones), count.index)
    tags = {
        Name = "${var.prefix}-public-subnet-${element(split (",", var.availability_zones) ,count.index)}"
        Tier = "private"
    }
}

resource "aws_route_table" "public_route_table" {
    vpc_id = aws_vpc.vpc.id
    tags = {
        Name = "${var.prefix}_private_rt"
    }
}

resource "aws_route_table_association" "public_route_table_association" {
    count = length(split(",", var.availability_zones))
    subnet_id = element(aws_subnet.public_subnet.*.id, count.index)
    route_table_id = aws_route_table.public_route_table.id
}


resource "aws_route" "internet_on_public" {
    route_table_id = aws_route_table.public_route_table.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet-gateway.id
}


// private subnet
resource "aws_subnet" "private" {
    vpc_id = aws_vpc.vpc.id
    count = length(split(",", var.availability_zones))
    cidr_block = element(var.private_subnet_cidrs, count.index)
    availability_zone = element(split (",", var.availability_zones), count.index)
    tags = {
        Name = "${var.prefix}-private-subnet-${element(split (",", var.availability_zones) ,count.index)}"
        Tier = "private"
    }
}

resource "aws_route_table" "private" {
    vpc_id = aws_vpc.vpc.id

    tags = {
        Name = "${var.prefix}-private-route-table"
    }
}

resource "aws_route" "private_internet" {
    route_table_id = aws_route_table.private.id
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
    destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route_table_association" "private_association" {
    count = length(split(",", var.availability_zones))
    subnet_id = element(aws_subnet.private.*.id, count.index)
    route_table_id = aws_route_table.private.id
}
