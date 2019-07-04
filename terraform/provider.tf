provider "aws" {
  profile = "tikal"
  region  = "eu-central-1"
  version = "~> 2.11"
}

provider "template" {
  version = "~> 2.0"
}
