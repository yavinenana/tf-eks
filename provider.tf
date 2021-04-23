data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}
data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}

# provider "null" {
#   version = "3.0.0"
#   region  = local.region
# }

provider "kubernetes" {
  config_path             = "~/.kube/config"
#  config_context = "my-context"
#  config_context_cluster  = "minikube"
  host                   = data.aws_eks_cluster.cluster.endpoint
#  client_certificate     = "${file("~/.kube/client-cert.pem")}"
#  client_key             = "${file("~/.kube/client-key.pem")}"
#  cluster_ca_certificate = "${file("~/.kube/cluster-ca-cert.pem")}"
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
  load_config_file       = false
  version                = "~> 1.11"
}
#provider "helm" {
#  kubernetes {
#        config_path             = "~/.kube/config"
#        config_context_cluster   = "minikube"
#  }
#}

provider "aws" {
        region = local.region
        profile = var.profile
}

output "endpoint" {
  value = data.aws_eks_cluster.cluster.endpoint
}
output "kubeconfig-certificate-authority-data" {
  value = data.aws_eks_cluster.cluster.certificate_authority[0].data
}
# Only available on Kubernetes version 1.13 and 1.14 clusters created or upgraded on or after September 3, 2019.
output "identity-oidc-issuer" {
  value = data.aws_eks_cluster.cluster.identity[0].oidc[0].issuer
}
