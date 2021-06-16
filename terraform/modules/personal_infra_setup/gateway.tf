resource "aws_internet_gateway" "internet-gateway" {
    vpc_id = aws_vpc.vpc.id
    tags = {
        Name = "${var.prefix}_internet_gateway"
    }
}

resource "aws_eip" "nat" {
    vpc = true
    tags = {
        Name = "${var.prefix}_eip_nat"
    }
}

resource "aws_nat_gateway" "nat_gateway" {
    allocation_id = element(concat(aws_eip.nat.*.id), 0)
    subnet_id = aws_subnet.public_subnet[0].id

    depends_on = [
        "aws_internet_gateway.internet-gateway"
    ]
}


