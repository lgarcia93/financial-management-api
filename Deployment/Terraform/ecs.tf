resource "aws_ecr_repository" "default" {
  name                 = "financial-management-repository"
  image_tag_mutability = "IMMUTABLE"

  provisioner "local-exec" {
    command = "./build-images.sh ${local.account_id}"
  }
}

resource "aws_ecr_repository_policy" "financial-management-erc-policy" {
  repository = aws_ecr_repository.default.name
  policy     = <<EOF
{
    "Version": "2008-10-17",
    "Statement": [
        {
            "Sid": "ECR_RepoPolicy",
            "Effect": "Allow",
            "Principal": "*",
            "Action": [
                "ecr:GetDownloadUrlForLayer",
                "ecr:BatchGetImage",
                "ecr:BatchCheckLayerAvailability",
                "ecr:PutImage",
                "ecr:InitiateLayerUpload",
                "ecr:UploadLayerPart",
                "ecr:CompleteLayerUpload",
                "ecr:DescribeRepositories",
                "ecr:GetRepositoryPolicy",
                "ecr:ListImages",
                "ecr:DeleteRepository",
                "ecr:BatchDeleteImage",
                "ecr:SetRepositoryPolicy",
                "ecr:DeleteRepositoryPolicy"
            ]
        }
    ]
}
EOF
}

resource "aws_ecs_cluster" "financial-management-cluster" {
  name = "financial-management-cluster"
}

resource "aws_ecs_task_definition" "financial-management-ecs-task" {
  family       = "financial-management-family"
  network_mode = "host"

  requires_compatibilities = ["EC2"]

  container_definitions = jsonencode([
    {
      name      = var.container-name
      image     = "${aws_ecr_repository.default.repository_url}:financial-management-v1"
      cpu       = 1000
      memory    = 500
      essential = true
      portMappings = [
        {
          containerPort = 5000
          hostPort      = 5000
        }
      ]
    },
  ])
}

resource "aws_ecs_service" "default" {
  name        = "financial-management-ecs-service"
  cluster     = aws_ecs_cluster.financial-management-cluster.id
  launch_type = "EC2"

  task_definition = aws_ecs_task_definition.financial-management-ecs-task.arn
  desired_count   = 2
}