resource "aws_ecs_cluster" "cluster" {
  name = "${var.app_name}-cluster"
}

resource "aws_ecs_task_definition" "ecs-task" {
  family       = "${var.app_name}-family"
  network_mode = "host"

  requires_compatibilities = ["EC2"]

  container_definitions = jsonencode([
    {
      name      = var.container_name
      image     = "${aws_ecr_repository.default.repository_url}:${var.app_name}-v1"
      cpu       = var.ecs_cpu
      memory    = var.ecs_memory
      essential = true
      portMappings = [
        {
          containerPort = var.app_port
          hostPort      = var.app_port
        }
      ]
    },
  ])
}

resource "aws_ecs_service" "default" {
  name        = "${var.app_name}-ecs-service"
  cluster     = aws_ecs_cluster.cluster.id
  launch_type = "EC2"

  task_definition = aws_ecs_task_definition.ecs-task.arn
  desired_count   = var.desired_task_count
}