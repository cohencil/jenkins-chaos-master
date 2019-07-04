terraform {
  backend "s3" {
    profile = "tikal"
    region  = "eu-central-1"
    bucket  = "jenkins-chaos-master"
    key     = "terraform.tfstate"
  }
}
