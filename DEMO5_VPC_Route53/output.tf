output "subnet_id" {
  value = [lookup({ for x, y in aws_subnet.subnets_us-east_1a : x => y.id }, "public_subnet_for_myvpc_1"), lookup({ for x, y in aws_subnet.subnets_us-east_1b : x => y.id }, "public_subnet_for_myvpc_2")]
}
