data "aws_canonical_user_id" "current" {}

resource "aws_s3_bucket" "bucket" {
  bucket = "${var.app_name}-files"
}

resource "aws_s3_bucket_policy" "s3_policy" {
  bucket = aws_s3_bucket.bucket.id
  policy = <<EOF
  {
    "Version": "2012-10-17",
    "Id": "Policy1586088133829",
    "Statement": [
      {
      "Sid": "Stmt1586088060284",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::${aws_s3_bucket.bucket.bucket}/*"
      }
    ]
  }
EOF
}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.bucket.id
  
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_ownership_controls" "example" {
  bucket = aws_s3_bucket.bucket.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}


resource "aws_s3_bucket_acl" "example" {
  bucket = aws_s3_bucket.bucket.id
  access_control_policy {
    grant {
      grantee {
        id   = data.aws_canonical_user_id.current.id
        type = "CanonicalUser"
      }
      permission = "FULL_CONTROL"
    }

    grant {
      grantee {
        type = "Group"
        uri  = "http://acs.amazonaws.com/groups/global/AllUsers"
      }
      permission = "READ_ACP"
    }

    owner {
      id = data.aws_canonical_user_id.current.id
    }
  }
}