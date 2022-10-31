project = "ami-ec2"

variable "aws_access_key" {
  type = string
  env  = ["AWS_ACCESS_KEY_ID"]
}

variable "aws_secret_key" {
  type = string
  env  = ["AWS_SECRET_ACCESS_KEY"]
}

variable "aws_session_token" {
  type = string
  env  = ["AWS_SESSION_TOKEN"]
}


app "ami-ec2" {
  labels = {
    "service" = "ami-ec2"
  }

  build {
    use "aws-ami" {
      region = "ap-northeast-1"
      name   = "apache2-initd"
    }
  }

  deploy {
    use "aws-ec2" {
      region        = "ap-northeast-1"
      instance_type = "t2.micro"
      service_port  = "80"
      extra_ports   = [22, 443]
      key           = "hc-handson"
    }
  }

  release {
    use "aws-alb" {
      port = 80
    }
  }

  url {
    auto_hostname = false
  }
}
