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
  type = string  
  description = "AMI to use in the EC2"
}
variable "instance_type" {
  description = "EC2 instance hardware"
  default     = "t2.micro"
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

variable "container_name" {
  type = string
  default = "financial-management"
  description = "The name of the container"
}

variable "app_name" {
  type = string
  description = "The application name"
}

variable "db_name" {
  type = string
  description = "Application database name"
}

variable "app_port" {
  type = number
  description = "The port the application runs on"
}

variable "desired_task_count" {
  type = number
  description = "How many tasks should be running"
}

variable "ecs_cpu" {
  type = number
  description = "The number of CPU units for the task"
}

variable "ecs_memory" {
  type = number
  description = "The amount of memory in Mb"
}

variable "rds_storage_type" {
  type = string
  description = "Type of storage for the RDS Instance"
}

variable "rds_instance_class" {
  type = string
  description = "The class for the RDS Instance"
}

#VPC

variable "cidr_everywhere" {
  type = string
  description = "CIDR Constant - All IPs"
}
variable "vpc_cidr" {
  type = string
  description = "The VPC CIDR Block"
}

variable "subnet_public_us_east_1a_cidr" {
  type = string
  description = "The CIDR block for the public subnet in us_east_1a"
}
variable "subnet_private_us_east_1a_cidr" {
  type = string
  description = "The CIDR block for the private subnet in us_east_1a"
}
variable "subnet_public_us_east_1b_cidr" {
  type = string
  description = "The CIDR block for the public subnet in us_east_1b"
}
variable "subnet_private_us_east_1b_cidr" {
  type = string
  description = "The CIDR block for the private subnet in us_east_1b"
}