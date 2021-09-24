terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 2.62"
    }
    github = {
      source  = "integrations/github"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  features {}
}

provider "github" {
  owner = "tjcorr"
}

resource "azurerm_resource_group" "rg-aks" {
  name     = var.resource_group_name
  location = var.location
}

data "github_repository" "repo" {
  full_name = "tf-pipeline-demo"
}

resource "github_actions_secret" "example_secret" {
  repository      = data.github_repository.repo.full_name
  secret_name     = "tf_sample_secret"
  plaintext_value = "super_sekret"
}
