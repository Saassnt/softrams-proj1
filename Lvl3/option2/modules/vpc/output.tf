output "vpc_id" {
  value = "${aws_vpc.cluster_vpc.id}"
}

output "public_subnet_2a" {
  value = "${aws_subnet.public_subnet_us_east_2a.*.id}"
}

output "public_subnet_2b" {
  value = "${aws_subnet.public_subnet_us_east_2b.*.id}"
}

output "app_sg_id" {
  value = "${aws_security_group.app_sg.id}"
}

output "alb_sg_id" {
  value = "${aws_security_group.alb_sg.id}"
}

output "ecs_sg_id" {
  value = "${aws_security_group.ecs_sg.id}"
}
