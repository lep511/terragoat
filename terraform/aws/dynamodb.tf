# Example of a DynamoDB table
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table
resource "aws_dynamodb_table" "basic-dynamodb-table" {
  # checkov:skip=CKV_AWS_119: "DynamoDB tables are not encrypted by default"
  name           = "GameScores"
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "UserId"
  range_key      = "GameTitle"

  attribute {
    name = "UserId"
    type = "S"
  }

  attribute {
    name = "GameTitle"
    type = "S"
  }

  attribute {
    name = "TopScore"
    type = "N"
  }

  ttl {
    attribute_name = "TimeToExist"
    enabled        = false
  }

  global_secondary_index {
    name               = "GameTitleIndex"
    hash_key           = "GameTitle"
    range_key          = "TopScore"
    write_capacity     = 10
    read_capacity      = 10
    projection_type    = "INCLUDE"
    non_key_attributes = ["UserId"]
  }

  tags = merge({
    Name        = "dynamodb-table-1"
    Environment = "production"
    }, {
    another-key          = "another_val"
    git_commit           = "2ab007c97354c8a8889ba5834cdeb7e573cb1536"
    git_file             = "terraform/aws/dynamodb.tf"
    git_last_modified_at = "2023-03-23 22:22:25"
    git_last_modified_by = "estebanpbuday@gmail.com"
    git_modifiers        = "estebanpbuday"
    git_org              = "lep511"
    git_repo             = "terragoat"
    somekey              = "somevalue"
    yor_trace            = "d7ed1b5d-a0b0-4cec-be7d-47001072a97a"
  })
  point_in_time_recovery {
    enabled = true
  }
}