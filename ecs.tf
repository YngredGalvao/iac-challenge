
# Create the ECS Cluster and Fargate launch type service in the private subnets
resource "aws_ecs_cluster" "ecs_cluster" {
  name  = "demo-ecs-cluster"
}

resource "aws_ecs_service" "demo-ecs-service" {
  name            = "demo-ecs-svc"
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.ecs_taskdef.arn
  desired_count   = 1
  deployment_maximum_percent = 200
  deployment_minimum_healthy_percent = 50
  enable_ecs_managed_tags = false
  health_check_grace_period_seconds = 60
  launch_type = "FARGATE"
  platform_version = "1.3.0"

  depends_on      = [aws_lb_target_group.alb_ecs_tg, aws_lb_listener.ecs_alb_listener]

  load_balancer {
    target_group_arn = aws_lb_target_group.alb_ecs_tg.arn
    container_name   = "web"
    container_port   = 80
  }

  network_configuration {
    security_groups = [aws_security_group.ecs_security_group.id]
    subnets = [aws_subnet.public_a.id]
  }
}

# Create the ECS Service task definition. 
# ECS task execution role and the task role is used which can be attached with additional IAM policies to configure the required permissions.
resource "aws_ecs_task_definition" "ecs_taskdef" {
  family = "service"
  container_definitions = jsonencode([
    {
      name      = "web"
      image     = "519583048954.dkr.ecr.us-east-2.amazonaws.com/ecsdocker"
      essential = true
      portMappings = [
        {
          containerPort = 80
          protocol      = "tcp"
        }
      ]
    }
  ])
  cpu       = 512
  memory    = 1024
  execution_role_arn = aws_iam_role.ecs_task_exec_role.arn
  task_role_arn = aws_iam_role.ecs_task_role.arn
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
}

resource "aws_iam_role" "ecs_task_exec_role" {
  name = "ecs_task_exec_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
        Effect= "Allow"
        Sid= ""
      }
    ]
  })
}

resource "aws_iam_role_policy" "ecs_task_exec_policy" {
  name        = "ecs_policy"
  role        = "${aws_iam_role.ecs_task_exec_role.name}"
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ecr:*",
                "cloudtrail:LookupEvents"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "iam:CreateServiceLinkedRole"
            ],
            "Resource": "*",
            "Condition": {
                "StringEquals": {
                    "iam:AWSServiceName": [
                        "replication.ecr.amazonaws.com"
                    ]
                }
            }
        }
    ]
  })
}

resource "aws_iam_role" "ecs_task_role" {
  name = "ecs_task_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
        Effect= "Allow"
        Sid= ""
      }
    ]
  })
}

resource "aws_iam_role_policy" "ecs_task_policy" {
  name        = "ecs_policy"
  role        = "${aws_iam_role.ecs_task_role.name}"
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ecr:*",
                "cloudtrail:LookupEvents"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "iam:CreateServiceLinkedRole"
            ],
            "Resource": "*",
            "Condition": {
                "StringEquals": {
                    "iam:AWSServiceName": [
                        "replication.ecr.amazonaws.com"
                    ]
                }
            }
        }
    ]
  })
}