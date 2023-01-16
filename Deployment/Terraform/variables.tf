variable "region" {
  description = "Infrastructure AWS region"
  default     = "us-east-1"
}

variable "us-east-1a" {
  default = "us-east-1a"
  description = "Availability Zone us-east-1a"
}

variable "us-east-1b" {
  default = "us-east-1b"
  description = "Availability Zone us-east-1b"
}

variable "name" {
  description = "Name of this microservice"
  default     = "Transaction service"
}

variable "env" {
  description = "Environment of the application"
  default     = "production"
}

variable "ami" {
  default = "ami-00eb0dc604a8124fd"
  description = "AMI to use in the EC2"
}
variable "instance_type" {
  description = "EC2 instance hardware"
  default     = "t2.micro"
}

variable "repo" {
  description = "Application repository"
  default     = "github.com/lgarcia93/app"
}

variable "rds_address" {
  type = string
  description = "The RDS instance address"
}

variable "rds_user" {
  type = string
  description = "The user for the RDS instance"
}

variable "rds_password" {
  type = string
  description = "The password for the RDS instance"
}

variable "container-name" {
  type = string
  default = "financial-management"
  description = "The name of the container"
}