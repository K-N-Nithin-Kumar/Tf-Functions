resource "aws_instance" "app-server-pub" {
  # ami = "${data.aws_ami.my_ami.id}"
  #   count = length(var.public_cird_block)

  #  Deploy 2 instances if the environment is production else deploy 0
  count = var.environment == "Production" ? 2 : 0
  ami   = lookup(var.amis, var.aws_region)
  #ami = "ami-0d857ff0f5fc4e03b"
  instance_type               = "t2.micro"
  key_name                    = var.key_name
  subnet_id                   = element(aws_subnet.public-subnet.*.id, count.index)
  vpc_security_group_ids      = ["${aws_security_group.allow_all.id}"]
  associate_public_ip_address = true
  tags = merge(
    local.common_tags,
    {
      Name        = "${var.public_ec2_name}-${count.index + 1}"
      environment = "${var.environment}"
  })
}
