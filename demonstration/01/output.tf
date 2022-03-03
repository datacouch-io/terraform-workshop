output "subnet_cidr" {
  value = aws_subnet.demo_subnet.cidr_block
}

output "subnet_arn" {
  value = aws_subnet.demo_subnet.arn
}