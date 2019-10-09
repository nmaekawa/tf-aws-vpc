/*
  Web Servers
*/
resource "aws_security_group" "web" {
    name = "vpc_web"
    description = "Allow incoming HTTP connections."

    ingress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    vpc_id = "${aws_vpc.default.id}"

    tags = {
        Name = "WebServerSG"
        stack = "devops-naomi-tf"
    }
}

resource "aws_instance" "web" {
  count = "${length(var.az-subnet-mapping)}"
  ami = "${lookup(var.amis, var.aws_region)}"
  instance_type = "t2.micro"
  key_name = "${var.aws_key_name}"
  vpc_security_group_ids = ["${aws_security_group.web.id}"]
  subnet_id = "${aws_subnet.public[count.index].id}"
  associate_public_ip_address = true
  source_dest_check = false

  tags = {
    Name = "devops${count.index}"
    stack = "devops-naomi-tf"
    project = "devops"
    cluster = "devops"
    service = "tf"
  }
}

