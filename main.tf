module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "12.0.0"

  cluster_name    = local.eks_cluster_name
  cluster_version = "1.17"
  subnets = var.public_subnets_id
  vpc_id  = var.vpc_id

  # worker_groups = [
  #   {
  #     instance_type = "m4.large"
  #     asg_max_size  = 5
  #   }
  # ]
  node_groups = {
    example = {
      desired_capacity = var.node_group_services_desired_capacity
      max_capacity     = var.node_group_services_max
      min_capacity     = var.node_group_services_min

      instance_types = ["var.node_group_services_instance_type"]
      capacity_type  = "SPOT"
      k8s_labels = {
        Environment = "test"
        GithubRepo  = "terraform-aws-eks"
        GithubOrg   = "terraform-aws-modules"
      }
#      additional_tags = {
#        ExtraTag = "example"
#      }
      additional_tags = local.common_tags
      k8s_labels = {
        node = "services"
      }
    }
  }
  #  node_groups = {
  #    services = {
  #      desired_capacity = var.node_group_services_desired_capacity
  #      max_capacity     = var.node_group_services_max
  #      min_capacity     = var.node_group_services_min
  #      instance_type    = var.node_group_services_instance_type
  #      additional_tags   = local.common_tags
  #
  #      k8s_labels = {
  #        node = "services"
  #      }
  #    }
  #  }
}
