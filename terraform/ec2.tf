resource "aws_instance" "web" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type

  subnet_id = data.aws_subnets.selected.ids[0]

  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.sg.id]

  associate_public_ip_address = true

  # FIXED
  user_data_base64             = base64encode(file("../scripts/install.sh"))
  user_data_replace_on_change  = true

  tags = merge(
    var.tags,
    {
      Name = "Flask-Server-us-west-2"
    }
  )

  root_block_device {
    tags = merge(
      var.tags,
      {
        Name = "Flask-Server-volume"
      }
    )
  }
}