# Amazon Key pair
resource "aws_key_pair" "iquant-key" {
  key_name   = "iquantkeys"
  public_key = file("iquantkeys.pub")
}

# Amazon EC2 Instance Resource 
resource "aws_instance" "terra_ec2" {
  ami                    = var.AMI
  instance_type          = var.TYPE
  key_name               = aws_key_pair.iquant-key.key_name
  vpc_security_group_ids = ["sg-040c1fca5fe860748"]
  tags = {
    "Name"        = "Terra EC2"
    "Environment" = "Dev"
  }
  provisioner "file" {
    source      = "iquant.sh"
    destination = "/tmp/iquant.sh"
  }
  provisioner "remote-exec" {
    inline = ["chmod 777 /tmp/iquant.sh", "sudo /tmp/iquant.sh"]
  }
  connection {
    type        = "ssh"
    user        = var.USER
    private_key = file("iquantkeys")
    host        = self.public_ip
  }
}

