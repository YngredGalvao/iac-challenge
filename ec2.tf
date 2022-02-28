resource "aws_instance" "private" {
  ami                    = var.ami_id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.private.id
  vpc_security_group_ids = [aws_security_group.private.id]

  tags = {
    Name = "${var.name}-db"
  }
}

resource "aws_instance" "public" {
  ami                    = var.ami_id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.public.id]
  user_data = "${file("install_apache.sh")}"

  tags = {
    Name = "${var.name}-ec2"
  }
}

