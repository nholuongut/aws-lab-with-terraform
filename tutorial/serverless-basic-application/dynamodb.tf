resource "aws_dynamodb_table" "basic_dynamodb_table" {
  name           = "DebugTableHelloWorld"
  billing_mode   = "PROVISIONED"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "ID"

  attribute {
    name = "ID"
    type = "S"
  }

  tags = {
    Name        = "nholuong-dynamodb-table-prod"
    Environment = "production"
  }
}
