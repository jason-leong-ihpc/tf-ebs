data "aws_vpc" "selected" {
  id = var.vpc_id
}

data "aws_subnets" "all" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.selected.id]
  }
}

# Get details for the first subnet in the list
data "aws_subnet" "first" {
  id = data.aws_subnets.all.ids[0]
}
