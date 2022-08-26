# main.tf
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}


provider "aws" {
  region = var.instance_region
}

resource "aws_security_group" "main" {
  egress = [
    {
      cidr_blocks      = [ "0.0.0.0/0", ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    }
  ]
 ingress                = [
   {
     cidr_blocks      = [ "0.0.0.0/0", ]
     description      = ""
     from_port        = 0
     ipv6_cidr_blocks = []
     prefix_list_ids  = []
     protocol         = "tcp"
     security_groups  = []
     self             = false
     to_port          = 81
  }
  ]

  tags = {
    Name = "Allow TLS"
  }
}

resource "aws_instance" "app_server" {
  ami           = "ami-08d70e59c07c61a3a"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.main.id]
  key_name= "ssh_key"
  #user_data = file("apache.sh")
  user_data = <<-EOF
  #!/bin/bash
  apt update -y
  apt install apache2 -y
  service apache2 start
  echo "<html><head><title>Apache2 Server Terraform Message Page</title></head><body><h1>My message to say that the Terraform deployment was a success. Apache2 server is running my custom html page</h1></body></html>" > /var/www/html/index.html
  EOF

    connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ubuntu"
      private_key = file("~/.ssh/id_rsa.")
      timeout     = "5m"
   }


  tags = {
    Name = var.instance_name
  }
}


resource "aws_key_pair" "deployer" {
  key_name   = "ssh_key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDDf2+iQ1u57wfR4ozboCmUbt2kuB7GRqc2IPBS1Oegdi7W1lPdxbwgH9wRUuiI4a75WCeahfzMm+8Q4llcKAB5XsGGSWjqV+bIusT9Kt5Y97xmXHmyKoZ1BAZIi980fLK9V/VVwdJ/EtkdUIJtZs9T8qd2QkmdVAKnzRzAAaYHYcxEvG1VczFKcZipDTzHTLf1T3MUtDgJi4UPZkEvmlz13XdefdjqPzj2QgvxCBkRXYAp3iCx8xD+2vs5c/UJUEix/1VlmN6Gv50R2mjWMiMj2YpYV6mm6Wd1VythkRXelWgUaKCaoJK1esLibREUrxX2QwGSrfQjpPDJvwxVdALkfGw41TjKq3jNuwAOudJHMSCg6dO6l1a5CUG2pDxZHKOjzpY3wo8An7qfaLXb06jJKiHhCYy5yIKrUMinj0ea9/Z+fhJH2reUsratpwsuXlk5ia7fQnyUOVH1Uvtpcfv8/927DMw0z9eULNgrUpD4dskHi+NciyxlDACsUjNk638= tech@3520_341MZM2"
}



