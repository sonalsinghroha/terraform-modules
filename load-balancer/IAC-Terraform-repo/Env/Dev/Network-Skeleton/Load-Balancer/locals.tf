locals {
  alb_sg_tags = {
    Name  = "${var.alb_name}-sg"
    env   = var.env_name
    owner = var.owner_name
  }

  alb_tags = {
    Name  = var.alb_name
    env   = var.env_name
    owner = var.owner_name
  }

}