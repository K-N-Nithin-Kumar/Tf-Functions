resource "null_resource" "prov" {

  count = var.environment == "Production" ? 2 : 0

  provisioner "file" {
    source      = "user-data.sh"
    destination = "/tmp/user-data.sh"
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("smart-remedy.pem")
      host        = element(aws_instance.app-server-pub.*.public_ip, count.index)
    }
  }

  provisioner "remote-exec" {
    inline = [
      "sudo chmod +x /tmp/user-data.sh",
      "sudo /tmp/user-data.sh",
      "sudo apt update -y",
      "sudo apt install -jq unzip -y",
    ]
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("smart-remedy.pem")
      host        = element(aws_instance.app-server-pub.*.public_ip, count.index)
    }
  }
}