

resource "aws_instance" "db-server-pri" {
  # ami = "${data.aws_ami.my_ami.id}"
  #   count = length(var.private_cird_block)
  #  Deploy 2 instances if the environment is production else deploy 1 
  count = var.environment == "Production" ? 1 : 0
  ami   = lookup(var.amis, var.aws_region)
  #ami = "ami-0d857ff0f5fc4e03b"
  instance_type               = "t2.micro"
  key_name                    = var.key_name
  subnet_id                   = element(aws_subnet.private-subnet.*.id, count.index)
  vpc_security_group_ids      = ["${aws_security_group.allow_all.id}"]
  associate_public_ip_address = false
  tags = merge(
    local.common_tags,
    {
      Name        = "${var.private_ec2_name}-${count.index + 1}"
      environment = "${var.environment}"
  })
  user_data = <<-EOF
        #!/bin/bash
        apt-get update -y
        apt-get install -y nginx
        echo "<h1>${var.private_ec2_name}-Server-${count.index + 1}</h1>" > /var/www/html/index.html
        systemctl start nginx
        systemctl enable nginx
    EOF
}