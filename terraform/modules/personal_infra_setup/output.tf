output "private_subnet_ids" {
    value = join(",", aws_subnet.private.*.id)
}
