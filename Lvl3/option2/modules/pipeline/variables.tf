variable "cluster_name" {
  description = "The cluster_name"
}

variable "app_repository_name" {
  description = "ECR Repository name"
}

variable "app_service_name" {
  description = "Service name"
}

variable "github_token" {
  description = " Github OAuth Token"
}

variable "github_organization" {
  description = " Github organization"
  default = "Saassnt@gmail.com"
}

variable "webhook_secret" {
  type = string
  description  = "webhook secret "
}

variable "git_repository_owner" {
  description = "Owner from Repository"
}

variable "git_repository_name" {
  description = "Name of repository"
}

variable "git_repository_branch" {
  description = "Build branch Master"
}

variable "vpc_id" {
  description = "The VPC id"
}

variable "repository_url" {
  description = "The url of the ECR repository"
}

variable "subnet_ids" {
  type        = list
  description = "Subnet ids"
}

variable "region" {
  description = "The region to use"
}

variable "container_name" {
  description = "Container name"
}

variable "account_id" {
  description = "AWS Account ID"
}