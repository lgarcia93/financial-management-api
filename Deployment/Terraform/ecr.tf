resource "aws_ecr_repository" "default" {
  name                 = "${var.app_name}-repository"
  image_tag_mutability = "IMMUTABLE"

  provisioner "local-exec" {
    command = "./build-images.sh ${local.account_id} ${var.app_name}"
  }
}

resource "aws_ecr_repository_policy" "ecr-repo-policy" {
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