resource "aws_db_instance" "this" {
  identifier            = var.db_identifier
  engine                = "mysql"
  instance_class        = "db.t3.micro"
  allocated_storage     = 20
  username              = var.username
  password              = var.password
  skip_final_snapshot   = true
}
