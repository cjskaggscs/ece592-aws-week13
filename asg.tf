# Create the auto-scaling group to ensure bastion VM is always up
resource "aws_autoscaling_group" "week13-bastion-asg" {
  name             = "week13-bastion-asg"
  max_size         = 1
  min_size         = 1
  desired_capacity = 1

  launch_template {
    id      = aws_launch_template.week13-bastion-lt.id
    version = "$Latest"
  }
}
