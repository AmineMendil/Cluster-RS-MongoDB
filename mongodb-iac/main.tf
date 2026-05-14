resource "aws_key_pair" "mongo_key" {

  # Nom de la clé dans AWS
  key_name = var.key_name

  # Clé publique locale
  public_key = file("~/.ssh/mongo-key.pub")
}

resource "aws_security_group" "mongo_sg" {

  # Nom du SG
  name = "mongo-sg"

  # SSH access
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # MongoDB access
  ingress {
    from_port   = 27017
    to_port     = 27017
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # trafic sortant
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "mongo" {

  # 3 machines pour Replica Set
  count = 3

  # AMI Ubuntu venant des variables
  ami = var.ami_id

  # type machine
  instance_type = var.instance_type

  # clé SSH
  key_name = aws_key_pair.mongo_key.key_name

  # sécurité réseau
  vpc_security_group_ids = [aws_security_group.mongo_sg.id]

  # nom des nodes
  tags = {
    Name = "mongo-node-${count.index + 1}"
  }
}