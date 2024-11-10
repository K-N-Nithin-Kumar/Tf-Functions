resource "aws_subnet" "public-subnet" {
  count             = length(var.public_cird_block)
  vpc_id            = aws_vpc.default.id
  cidr_block        = element(var.public_cird_block, count.index)
  availability_zone = element(var.azs, count.index)

  # tags = {
  #   Name        = "${var.public_subnet_name}-${count.index + 1}"
  #   Owner       = locals.Owner
  #   costcenter  = locals.costcenter
  #   TeamDL      = locals.TeamDL
  #   environment = "${var.environment}"
  # }

  tags = merge(
    local.common_tags,
    {
      Name        = "${var.public_subnet_name}-${count.index + 1}"
      environment = "${var.environment}"
    }
  )
}

resource "aws_subnet" "private-subnet" {
  count             = length(var.public_cird_block)
  vpc_id            = aws_vpc.default.id
  cidr_block        = element(var.private_cird_block, count.index)
  availability_zone = element(var.azs, count.index)

  # tags = {
  #   Name        = "${var.private_subnet_name}-${count.index + 1}"
  #   Owner       = locals.Owner
  #   costcenter  = locals.costcenter
  #   TeamDL      = locals.TeamDL
  #   environment = "${var.environment}"
  # }
  tags = merge(
    local.common_tags,
    {
      Name        = "${var.private_subnet_name}-${count.index + 1}"
      environment = "${var.environment}"
    }
  )
}
