locals {
  eks_cluster_name = var.eks_cluster_name
  region           = var.region
  common_tags = {
    Owner       = "Yavinenana"
    Environment = var.tag_environment
    platform    = "webapp"
  }
}
