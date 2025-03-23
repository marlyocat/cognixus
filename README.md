# Table of Contents
1. [Project](#project)
    - [Description](#description)
    - [Getting Started](#getting-started)
        - [Dependencies and Tools](#dependencies-and-tools)
        - [Steps to Setup the Tasks](#steps-to-setup-the-tasks)

2. [Task 1 - Gitea Application (Terraform)](#task-1---gitea-application-terraform)
    - [Initialization](#initialization)
    - [Teardown](#teardown)

3. [Task 2 - Nodejs Application (Terraform)](#task-2---nodejs-application-terraform)
    - [Initialization](#initialization-1)
    - [Teardown](#teardown-1)

4. [Task 3 - Nodejs Application (Docker and Docker Swarm)](#task-3---nodejs-application-docker-and-docker-swarm)
    - [Docker](#docker)
        - [Initialization](#initialization-2)
        - [Teardown](#teardown-2)
    - [Docker Swarm](#docker-swarm)
        - [Initialization](#initialization-3)
        - [Teardown](#teardown-3)

4. [Accessing my Running Application](#accessing-my-running-application)
    - [Gitea Application (Task 1)](#gitea-application-task-1)
    - [Nodejs Application (Task 2)](#nodejs-application-task-2)
    - [Nodejs Application using Docker and Docker Swarm (Task 3)](#nodejs-application-using-docker-and-docker-swarm-task-3)

# Project

Cognixus

## Description

Take Home Test

## Getting Started

### Dependencies and Tools

* Terraform (https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

* AWS CLI (https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

* Docker (https://docs.docker.com/get-docker/)

* Python3 (https://www.python.org/downloads/)

## Steps to setup the tasks

Git Clone the repository

    1. Run the command "git clone https://github.com/marlyocat/cognixus.git"

Update the AWS credentials

    1. Run the command "aws configure" and follow the prompts to enter your AWS credentials

Login to Docker

    1. Run the command "docker login" and follow the prompts to enter your Docker credentials

## Execution

### Task 1 - Gitea Application (Terraform)

#### Initialization

    1. Navigate to the directory "cd tasks/task1/gitea"

    2. Run the command "terraform init"

    3. Run the command "terraform apply"

    4. Access the url "chipichapa.site" in your web browser to see the gitea application

#### Teardown

    1. Run the command "terraform destroy"

### Task 2 - Nodejs Application (Terraform)

#### Initialization
    1. Navigate to the directory "cd tasks/task2/nodejs/terraform"

    2. Run the command "terraform init"

    3. Run the command "terraform apply"

    4. Run the command "terraform output nodejs_public_ips" to get the public ip of the nodejs ecs instance

    5. Navigate to the directory "cd tasks/task2/nodejs/terraform/ansible"

    6. Run the script "./run_ansible_playbook.sh" to deploy the nodejs application

    7. Access the url "http://<nodejs_public_ip>:30100" in your web browser to see the nodejs application

#### Teardown

    1. Run the command "terraform destroy"

### Task 3 - Nodejs Application (Docker and Docker Swarm)

### Docker

#### Initialization
    1. Navigate to the directory "cd tasks/task3/nodejs/docker"

    2. Run the command "./setup_app.sh" to build the docker image and run the container

    3. Run the command "docker ps" in another terminal to see the running container

    4. Access the url "localhost:3000" in your web browser to see the nodejs application

#### Teardown

    1. Run the command "docker container stop <container-id>" to stop the container

    2. Run the command "docker rmi <image-id>" to remove the image

### Docker Swarm

#### Initialization
    1. Navigate to the directory "cd tasks/task3/nodejs/dockerswarm"

    2. Run the command "docker swarm init" to initialize the swarm

    3. Run "docker stack deploy -c docker-compose.yaml my-docker-stack" to start the swarm

    4. Access the url "localhost:3000" in your web browser to see the nodejs application

#### Teardown

    1. Run the command "docker stack rm my-docker-stack" to remove the stack

## Accessing my Running Application

### Gitea Application (Task 1)

1. Access the url "https://chipichapa.site" in your web browser to see the gitea application

### Nodejs Application (Task 2)

1. Access the url "http://13.213.56.212:30100/" in your web browser to see the nodejs application

### Nodejs Application using Docker and Docker Swarm (Task 3)

1. Run "docker stack deploy -c docker-compose.yaml my-docker-stack" to view locally
2. Access the url "localhost:3000" in your web browser to see the nodejs application
