provider "aws" {
    region = "${var.aws_region}"
}

/*
terraform {
  backend "pg" {
    conn_str = "postgres://user:password@dbserver.org/terraform_backend"
  }
}
*/

terraform {
  backend "s3" {
    bucket = "mybucket"
    key = "terraform/test"
    region = "us-west-2"
  }
}
