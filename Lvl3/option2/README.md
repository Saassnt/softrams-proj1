Root level file = main.tf :
Provide your AWS access_key and secret_key values .
 

Root level file = variables.tf :

Please change all the below variables values to your own preference and environment requirements .
Provide your main oAuth Token below  from github or gitlab account ; e.g : default = "789xxxxxxxxxxxxxxxxxxx"

# Customize the Cluster Name
variable "cluster_name" {
  description = "ECS Cluster Name"
  default     = "se-cluster"
}

# Customize your ECR Registry Name
variable "app_repository_name" {
  description = "ECR Repository Name"
  default     = "myrepo1"
}

###### APPLICATION OPTIONS  ######
variable "container_name" {
  description = "Container app name"
  default     = "my-assignc"
}

# Number of containers
variable "desired_tasks" {
  description = "Number of containers desired to run app task"
  default     = 2
}

variable "min_tasks" {
  description = "Minimum"
  default     = 2
}

variable "max_tasks" {
  description = "Maximum"
  default     = 4
}

variable "cpu_to_scale_up" {
  description = "CPU % to Scale Up the number of containers"
  default     = 90
}

variable "cpu_to_scale_down" {
  description = "CPU % to Scale Down the number of containers"
  default     = 40
}

# Desired CPU
variable "desired_task_cpu" {
  description = "Desired CPU to run your tasks"
  default     = "256"
}

# Desired Memory
variable "desired_task_memory" {
  description = "Desired memory to run your tasks"
  default     = "512"
}

# Listener Application Load Balancer Port
variable "alb_port" {
  description = "Origin Application Load Balancer Port"
  default     = "80"
}

# Target Group Load Balancer Port
variable "container_port" {
  description = "Destination Application Load Balancer Port"
  default     = "80"
}

###### GITHUB OPTIONS  ######

# Github Repository Owner
variable "git_repository_owner" {
  description = "Github Repository Owner"
  default     = "Saassnt"
}

# Github Repository Project Name
variable "git_repository_name" {
  description = "Project name on Github"
  default     = "cicd"
}

# Default Branch
variable "git_repository_branch" {
  description = "Github Project Branch"
  default     = "master"
}

# Customize your AWS Region
variable "aws_region" {
  description = "AWS Region for the VPC"
  default     = "us-east-2"
}

# OAuth Github Token PUT YOUR OWN OAUTH TOKEN here 
variable "github_token" {
  description = " Github OAuth Token"
  default = ""
}

variable "webhook_secret" {
    description = " webhook secret "
    #type = "string"
    default = ""
}

# provide github_organization
variable "github_organization" {
    description = " github organization "
    type = string
    default = "Saassnt"
}



Then the commands will be :

Terraform init 
Terraform plan
Terraform apply 34 resources will be created all the way to ALB .

Check if you change the nginx in the docker file to httpd for example or replace the entire docker file with another 
one which is full of mutli-staging docker image or even one lengthy dockerfile .

Anyway , you will see a full CI/CD starting with your gitlab repo triggered because something changed "checked-in" .
AWS Codepipeline will start the Source Stage which is sourced from github or gitlab 
AWS Codebuild will execute all the commands inside the buildspec.yaml file ( build the image and then push it to AWS ECR )
AWS ECS ,Finally deploy to ECS and you can check any public IP of a container inisde the Task definition OR simply check the ALB to test your application .


