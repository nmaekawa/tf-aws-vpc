# https://ops.tips/blog/a-pratical-look-at-basic-aws-networking/#creating-aws-vpc-subnets
resource "aws_vpc" "default" {
    cidr_block = "${var.vpc_cidr}"
    enable_dns_hostnames = true
    tags = {
        Name = "terraform-aws-vpc"
        stack = "devo-naomi-tf"
    }
}

resource "aws_internet_gateway" "default" {
    vpc_id = "${aws_vpc.default.id}"
}


resource "aws_route" "internet_access" {
  route_table_id = "${aws_vpc.default.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = "${aws_internet_gateway.default.id}"
}


resource "aws_subnet" "public" {
  count = "${length(var.az-subnet-mapping)}"

  vpc_id = "${aws_vpc.default.id}"
  map_public_ip_on_launch = true
  availability_zone = "${lookup(var.az-subnet-mapping[count.index], "az")}"
  cidr_block = "${lookup(var.az-subnet-mapping[count.index], "cidr")}"

  tags = {
    Name = "subnet${count.index}"
  }

}


