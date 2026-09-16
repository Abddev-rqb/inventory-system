resource "aws_key_pair" "inventory" {
  key_name   = "${var.project_name}-key"
  public_key = var.ssh_public_key

  tags = {
    Name    = "${var.project_name}-key"
    Project = var.project_name
  }
}

