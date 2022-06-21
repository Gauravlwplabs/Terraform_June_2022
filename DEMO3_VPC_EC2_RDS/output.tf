output "subnet-id" {
  description = "This provide public and private subnet ID's"
  value       = [for x in aws_subnet.subnets : x.id]
}