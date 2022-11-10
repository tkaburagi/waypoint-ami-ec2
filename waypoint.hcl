project = "waypoint-ami-ec2"

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

variable "aws_session_expiration" {
  type = string
  env  = ["AWS_SESSION_EXPIRATION"]
}

app "ami-ec2" {
  labels = {
    "service" = "ami-ec2"
  }

  runner {
    profile = "docker-01GHGJVSNHWXE3VFXX9BR1K9SN"
  }

  build {
    use "aws-ami" {
      region = "ap-northeast-1"
      name   = "ztna-connector-ami-2.10.0.1018-d4d78a70-ccbe-4173-8826-ab21f9f187fd"
    }
  }

  deploy {
    use "aws-ec2" {
      region        = "ap-northeast-1"
      instance_type = "t2.micro"
      service_port  = "80"
      extra_ports   = [22, 443]
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
