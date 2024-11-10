# # Security group config

# resource "aws_security_group" "allow_all" {
#   name        = "${var.vpc_name}-sg"
#   description = "Allow all inbound traffic"
#   vpc_id      = aws_vpc.default.id

#   # Ingress rules
#   ingress {
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   ingress {
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   ingress {
#     from_port   = 443
#     to_port     = 443
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   # Egress rules
#   egress {
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = merge(
#     local.common_tags,
#     {
#       Name        = "${var.vpc_name}-sg"
#       environment = "${var.environment}"
#     }
#   )
# }


# ABOVE CODE IS ALSO WORKING BUT THE BELOW CODE IS BETTER CODE FOR SECURITY GROUP BECAUSE OF DYNAMIC BLOCK NO REPEATING INGRESS AND EGRESS RULES.


# Security group using dynamic block config

resource "aws_security_group" "allow_all" {
  name        = "${var.vpc_name}-sg"
  description = "Allow all inbound traffic"
  vpc_id      = aws_vpc.default.id

  # Ingress rules
  dynamic "ingress" {
    for_each = var.service_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  # Egress rules
  egress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    local.common_tags,
    {
      Name        = "${var.vpc_name}-sg"
      environment = "${var.environment}"
    }
  )
}