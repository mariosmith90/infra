output "task_role" {
  value = aws_iam_role.task_role.arn
}

output "main_ecs_role" {
  value = aws_iam_role.main_ecs_tasks.arn
}

output "aws_lb_target_group" {
  value = aws_lb_target_group.alb_tg.arn
}

output "arn" {
  value = aws_ecs_cluster.main.arn
}

output "id" {
  value = aws_ecs_cluster.main.id
}

output "alb_arn" {
  value       = aws_lb.alb.arn
  description = "ARN for the internal NLB"
}

output "alb_dns_name" {
  value       = aws_lb.alb.dns_name
  description = "DNS name for the internal NLB"
}

output "public_id" {
  value = aws_ecs_service.main.network_configuration
}

output "ecs_vpc" {
  value = aws_ecs_service.main.network_configuration
}