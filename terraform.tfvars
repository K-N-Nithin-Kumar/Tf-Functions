aws_region = "us-east-1"
vpc_cidr   = "172.18.0.0/16"
vpc_name   = "DevSecOPs-Vpc"
key_name   = "smart-remedy"
amis = {
  "us-east-1" = "ami-0866a3c8686eaeeba"
  "us-east-2" = "ami-0ea3c35c5c3284d82"

}
public_ec2_name  = "App-server"
private_ec2_name = "Db-server"
azs              = ["us-east-1a", "us-east-1b", "us-east-1c"]
# Creating 2 public and private subnets
public_cird_block  = ["172.18.1.0/24", "172.18.2.0/24"]
private_cird_block = ["172.18.10.0/24", "172.18.20.0/24"]

public_subnet_name  = "Application-subnet"
private_subnet_name = "Databse-subnet"
# Main_Routing_Table = "public-subnet"
# Private_Routing_Table = "public-subnet"
service_ports = ["80", "8080", "443", "22", "3306"]
environment   = "Production"