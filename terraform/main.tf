provider aws {
    region = "us-east-2"
}

resource "aws_key_pair" "group_2" {
  key_name   = "group-2"
  public_key = file("~/.ssh/id_rsa.pub")
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}


resource "aws_instance" "web" {

   ami = data.aws_ami.ubuntu.id
   instance_type = "t2.micro"
   key_name = aws_key_pair.group_2.key_name
   vpc_security_group_ids = [aws_security_group.group-2.id]
   
   tags = {
    Name = "group-2"
  }
}

