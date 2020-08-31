provider "aws" {
  version = "3.4.0"
  region  = local.region
}

provider "kubernetes" {
  version                = "1.12.0"
  host                   = data.aws_eks_cluster.main.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.main.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.main.token
  load_config_file       = false
}

provider "helm" {
  version = "1.2.4"
  kubernetes {
    host                   = data.aws_eks_cluster.main.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.main.certificate_authority.0.data)
    token                  = data.aws_eks_cluster_auth.main.token
    load_config_file       = false
  }
}

data "aws_eks_cluster" "main" {
  name = local.eks_cluster_id
}

data "aws_eks_cluster_auth" "main" {
  name = local.eks_cluster_id
}
