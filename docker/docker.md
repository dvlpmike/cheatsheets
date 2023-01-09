## Install Docker

Why should I install Docker from the official Docker repository? You can get old Docker versions.

**For Debian/Ubuntu**

Below instructions are for Debian/Ubuntu distros.

1. Remove the older version of Docker:
   ```
   sudo apt-get remove docker docker-engine docker.io containerd runc
   ```
2. Install the latest version of Docker:
   ```
   # Install packages to use HTTPS overt the apt repo
   sudo apt-get install ca-certificates curl gnupg lsb-release

   # Create a dir if it doesn't exists
   sudo mkdir -p /etc/apt/keyrings

   # Adding GPG keys
   curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

   # Adding official Docker repository
   echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
   
   # Finally install Docker
   sudo apt update
   sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin

   # OPTIONAL if you want using Docker without sudo
   sudo groupadd docker
   sudo usermod -aG docker <username>
   
   # Logout and login
   # Change group
   newgrp docker
   ```
3. Check for successful installation run
   ```
   sudo docker run hello-world
   ```

## Architecture
| Component       | Description                                                                                                                                            |
|-----------------|--------------------------------------------------------------------------------------------------------------------------------------------------------|
| Container       | A container is a running instance of an image. It is an isolated environment in which you can run applications.                                       |
| Image           | An image is a lightweight, stand-alone, executable package that includes everything needed to run a piece of software, including the application code. |
| Daemon          | The Docker daemon is a background process that manages Docker containers. It communicates with the Docker client, and handles all tasks related to containers. |
| Registry        | A registry is a collection of repositories, and a repository is a collection of images. Registries host images, which users can download and use.         |
| Client          | The Docker client is a command-line interface that communicates with the Docker daemon. It allows users to run commands to create, manage, and stop containers. |

## Files and directories
| File/Directory       | Description                                                                                                                                            |
|----------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------|
| `/var/lib/docker`   | This is the default location for Docker's data files, including volumes, images, and containers.                                                      |
| `/etc/docker`       | This directory contains configuration files for the Docker daemon and other Docker components.                                                         |
| `/usr/bin/docker`   | This is the location of the Docker executable file.                                                                                                   |
| `/usr/lib/systemd/system/docker.service` | This is the systemd unit file for the Docker daemon. It is used to control the Docker daemon on systems that use systemd as their init system.           |
| `/etc/default/docker` | This file contains default environment variables for the Docker daemon. It can be used to set options such as the default Docker registry to use.        |
|`~/.docker/config.json`| Docker stores credentials for private registries in a configuration file.|


## Most useful commands
**Build**
```
# Build an image
docker build -t IMAGE_NAME:TAG

# Build an image from a Dockerfile, ignoring the cache
docker build --no-cache -t IMAGE_NAME:TAG

# Build an image from a Dockerfile located at a specific path
docker build -f PATH/TO/DOCKERFILE -t IMAGE_NAME:TAG

# Set a build-time variable
docker build --build-arg VAR=VALUE -t IMAGE_NAME:TAG
```
**Run**
```
# Run a command in a new container in detached mode
docker run -d IMAGE_NAME:TAG

# Map a port on the host to a port in the container
docker run -p HOST_PORT:CONTAINER_PORT IMAGE_NAME:TAG

# Set an environment variable in the container
docker run -e ENV_VAR=VALUE IMAGE_NAME:TAG

# Bind mount a volume
docker run -v HOST_PATH:CONTAINER_PATH IMAGE_NAME:TAG

# Connect the container to a network
docker run --network NETWORK

# Limit the container to a specific set of CPU cores
docker run --cpuset-cpus CPU_LIST
```
**Container**
```
# List all running containers
docker container ls

# List all containers, running or stopped
docker container ls -a

# Stop one or more running containers
docker container stop CONTAINER_ID_OR_NAME

# Start one or more stopped containers
docker container start CONTAINER_ID_OR_NAME

# Restart one or more running containers
docker container restart CONTAINER_ID_OR_NAME

# Remove one or more stopped containers
docker container rm CONTAINER_ID_OR_NAME

# Remove all stopped containers
docker container prune

# Run a command in a running container
docker container exec CONTAINER_ID_OR_NAME COMMAND

# Inspect the details of a container
docker container inspect CONTAINER_ID_OR_NAME

# Display live performance statistics for one or more containers
docker container stats CONTAINER_ID_OR_NAME

# Kill all running containers
docker kill $(docker ps -q)
```
**Image**
```
# List all images
docker image ls

# Remove one or more images
docker image rm IMAGE_ID_OR_NAME

# Remove all unused images
docker image prune

# Inspect the details of an image
docker image inspect IMAGE_ID_OR_NAME

# Search the Docker Hub for images
docker search TERM

# Pull an image or a repository from a registry
docker pull IMAGE_NAME

# Delete all images
docker rmi $(docker images -q)

# Push an image or a repository to a registry
docker push IMAGE_NAME
```
**Docker Compose**
```
# Build and start all services from a docker-compose.yml file
docker-compose up

# Build and start all services in the background
docker-compose up -d

# Stop all services
docker-compose down

# Restart all services
docker-compose restart

# View the logs for a service
docker-compose logs SERVICE_NAME

# Run a command in a running container
docker-compose exec SERVICE_NAME COMMAND

# Build and start a single service
docker-compose up SERVICE_NAME

# Stop and remove all containers, networks, and images created by `up`
docker-compose down --rmi all

# Stop and remove all containers, networks, and volumes created by `up`
docker-compose down --volumes

# Generate a `docker-compose.yml` file from the current containers
docker-compose config
```
## References
Documentation https://docs.docker.com/
