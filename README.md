# Project

Cognixus

## Description

Take Home Test

## Getting Started

### Dependencies and Tools

* Terraform (https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

* AWS CLI (https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

* Docker (https://docs.docker.com/get-docker/)

## Setup

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

    4. Run the command "terraform output nodejs_public_ips" to get the public ip of the nodejs application

    5. Access the ec2 instance and run the commands below
        - "sudo k3s kubectl create ns nodejs"
        - "sudo k3s kubectl apply -f deployment.yaml -n nodejs"
        - "sudo k3s kubectl apply -f service.yaml -n nodejs"

    6. Access the url "http://<nodejs_public_ip>:30100" in your web browser to see the nodejs application

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

#### Teardown

    1. Run the command "docker stack rm my-docker-stack" to remove the stack