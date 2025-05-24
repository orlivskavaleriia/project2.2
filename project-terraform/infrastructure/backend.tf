# Перевірка існування S3 бакета та DynamoDB таблиці перед ініціалізацією Terraform
data "aws_s3_bucket" "terraform_state" {
  bucket = "glovo-terraform-backend"
}

data "aws_dynamodb_table" "terraform_locks" {
  name = "terraform-lock-table"
}

# Виведення перевірки
output "s3_bucket_exists" {
  value = data.aws_s3_bucket.terraform_state.id
}

output "dynamodb_table_exists" {
  value = data.aws_dynamodb_table.terraform_locks.name
}
