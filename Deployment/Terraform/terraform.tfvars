#The app name
app_name = "financial-management"
db_name  = "dbfinancialtransaction"
app_port = 5000


#VPC
cidr_everywhere = "0.0.0.0/0"
subnet_public_us_east_1a_cidr = "172.31.0.0/26"
subnet_private_us_east_1a_cidr = "172.31.0.64/26"
subnet_public_us_east_1b_cidr = "172.31.0.128/26"
subnet_private_us_east_1b_cidr = "172.31.0.192/26"
vpc_cidr = "172.31.0.0/24"

#Instances
ami      = "ami-00eb0dc604a8124fd"

#ECS
ecs_cpu = 1000
ecs_memory = 500
desired_task_count = 2

#RDS
rds_storage_type = "gp2"
rds_instance_class = "db.t3.micro"