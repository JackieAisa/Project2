provider aws {
    region = "us-east-2"
}

resource "aws_key_pair" "group_2" {
  key_name   = "group-2"
  public_key = file("~/.ssh/id_rsa.pub")
}

data "aws_ami" "wordpress" {

  filter {
    name   = "name"
    values = ["wordpress-ami"]  
  }

  owners = ["self"]
} 


resource "aws_instance" "web" {

   ami =data.aws_ami.wordpress.id
   instance_type = "t2.micro"
   key_name = aws_key_pair.group_2.key_name
   vpc_security_group_ids = [aws_security_group.group-2.id]
   subnet_id = aws_subnet.main.id
   
   tags = {
    Name = "group-2"
  }
}

