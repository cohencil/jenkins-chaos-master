provider "aws" {
  profile = terraform.workspace
  region  = var.region
  version = "~> 2.11"
}

provider "template" {
  version = "~> 2.0"
}
