variable "eks_cluster_name" {}
variable "region" {}
variable "profile" {}
variable "tag_environment" {}

variable "public_subnets_id" {}
variable "vpc_id" {}

variable "node_group_services_min" {
    default = 1
}
variable "node_group_services_max" {
    default = 4
}
variable "node_group_services_desired_capacity"{
    default = 1
}
variable "node_group_services_instance_type" {
    default = "m4.large"
}

