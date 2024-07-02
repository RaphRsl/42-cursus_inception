# Inception by RaphRsl
![1633865144-docker-meme-deeper](https://github.com/RaphRsl/42-cursus_inception/assets/79993112/ce410a75-1b23-477e-ad09-255e5d969e70)

## Description

This project aimed to broaden my knowledge of system administration and containers by using **Docker**. I had to virtualize several Docker images using **docker-compose**, in a **virtual machine**. The **use of Docker Hub was forbidden**.

## Overview of the Project

- **What the Project Is:**
	Inception is a system administration exercise where I set up a small infrastructure composed of different services under specific rules using Docker in a virtual machine.
- **Main Technical Features or Functionalities:** 
  - Set up Docker containers for NGINX with TLSv1.2 or TLSv1.3, WordPress + php-fpm, and MariaDB.
  - Create volumes for the WordPress database and website files to ensure data persistence.
  - Establish a docker-network for container communication.
  - Ease management and creation of the containers using docker-compose.
  - Ensure containers restart in case of a crash and that any environment variable is secured.
- **Languages**:
	- Docker
	- Docker-compose
	- Shell	script
	- YAML
	- SQL
	- PHP
	- Makefile
- **Tools and technical notions Involved:**
	NGINX / WordPress (php-fpm) / MariaDB (MySQL) / Service orchestration (docker-compose) / TLS/SSL configuration (TLSv1.2 or TLSv1.3) / Database management / Web server setup and configuration / System administration (systemd) / Environment variable management / Virtual machine setup (VirtualBox) / Persistent volumes / Port mapping


## Table of Contents

1. [Installation and Usage](#installation-and-usage)
   - [Prerequisites](#prerequisites)
   - [Cloning and Running](#cloning-and-running)
   - [Other Useful Commands](#other-useful-commands)
2. [Key Features](#key-features)
3. [Key Parts from an Academic View](#key-parts-from-an-academic-view)
   - [Subject Summary](#subject-summary)
   - [Requirements](#requirements)
   - [Mandatory Part](#mandatory-part)
   - [Forbidden](#forbidden)
   - [Useful Commands](#useful-commands)
   - [Advice and Key Code Parts](#advice-and-key-code-parts)
4. [Author and Contributing](#author-and-contributing)
   - [How to Contribute](#how-to-contribute)


## Installation and usage

### Prerequisites

- A virtual machine (VM) - *optional but recommended*
	My VM setup on VirtualBox :
		- ISO: ubuntu-22.04.4-desktop-amd64.iso
		- Base memory: 8192 MB
		- Processors: 4 CPUs
		- Disk size: 60 GB
- Docker and Docker Compose installed

### Cloning and running

1. Clone my repository:
   ```bash
   git clone https://github.com/RaphRsl/42-cursus_inception.git
   ```

2. Run the project using my makefile:
   ```bash
   make			# run the project : create .env file if necessary + build volumes/networks/containers + start the containers in background and launch the scripts
   ```

### Other useful commands to use my project

```bash
make env_check		# check if there is an .env file, otherwise creating it
make env_clean		# delete .env file
make env_reset		# delete .env file and create a new one
make up				# all needed commands for docker-compose up in background
make down			# all needed commands for docker-compose down
make clean			# make down + cleaning orphans & all images & networks
make fclean			# make clean + deleting volumes + deleting .env file
```

## Key Features

- NGINX container with TLSv1.2 or TLSv1.3
- WordPress container with php-fpm
- MariaDB container
- Persistent volumes for database and website files even after shutting down the containers
- Docker network for a safe container communication
- Docker-compose for easy management and creation of the containers
- Containers restart in case of a crash
- Secured environment variables
- Scripts for
	- Creating the .env file
	- Automatically setting up WordPress using wp-cli
	- Automatically setting up the database using SQL


## Key Parts from an Academic View


#### Subject summary

##### Requirements
- must be done on a VM
- use docker-compose
- all the files are in a "srcs" folder
- Makefile at the root of the directory, and must setup the entire application (using *docker-compose.yml* to build he Docker images)
- each docker image must have the same name as its corresponding service
- Volumes will be available in the "/home/rroussel/data" folder of the host machine using Docker
- configure the domain name so it points to my local IP address. This domain name must be "rroussel.42.fr" (this will redirect to the IP address pointing to rroussel's website).

##### Mandatory part
- Set up a small infrastructure composed of different services under specific rules
- each service has to run in a dedicated contaner
	- containers must be build from the penultimate stable version of Alpine or Debian --> For me it will be debien:bullseye
	- write one Dockerfile per service (must be called in my docker-compose.yml by the Makefile)
	- it means we have to build the Docker images of the project by ourself (not allowed to used ready-made docker images, except for Alpine/Debian)
- We have to setup:
	- A Docker container that contains only NGINX (with TLSv1.2 or TLSv1.3)
	- A Docker container that contains only WordPress + php-fpg (must be installed and configured), without nginx
	- A Docker container that contains only MariaDB (without nginx)
	- A volume that contains my WordPress database
		- must be 2 users, one of them neing the administrator. the admin's username can't contain admin/Admin or administrator/Administrator
	- A volume that contains my WordPress website files
	- A docker-network that establishes the connection between my containers
- The containers have to restart in case of a crash
- I must use env variables (strongly recommended to use a ".env" file to store env variables. it should be located at the root of he srcs difrectory).
- The NGINX container must be the only entrypoint into my infrastructure via the port 443 only, using the TLSv1.2 or TLSv1.3 protocol.

##### FORBIDDEN
- docker-compose.yml: must contain the network line
- not allowed to used ready-made docker images, except for Alpine/Debian
- containers musn't be started with a command running an infinite loop (also applies at any command used as entrypoint or in entrypoint scripts)
- hacky patches: tail -f, bash, sleep infinity, while true, host or --link or links
- latest tag
- no password in my Dockerfiles
- For obvious security reasons, any credentials, API keys, env variables etc... must be saved locally in a .env file and ignored by git. Publicly stored credentials will lead you directly to a failure of the project.
- 
<img width="506" alt="Capture_dcran_2022-07-19__16 24 51" src="https://github.com/RaphRsl/42-cursus_inception/assets/79993112/e5d06d90-85ac-4310-a532-b3a46598ccb0">

#### Useful commands

##### Useful commands to work on the project


**======= DOCKER COMMANDS =======**

- DOCKER BUILD IMAGES
```bash
docker build srcs/requirements/nginx/  # Build nginx image
docker build .  # Build image in current directory
docker build -t nginx .  # Rename build to 'nginx'

```

- DOCKER MANAGE IMAGES (list & remove)
```bash
docker image ls  # List all images
docker images -a  # List all images with details
docker rmi $(docker images -a -q)  # Remove all images using their IDs (first stop all running containers using those images)
									# -a = list all images
									# -a -q = list all images IDs
docker rmi -f $(docker images -a -q)  # Force remove images still used by containers
```

- DOCKER RUN CONTAINERS
```bash
docker run <image name>  # Start container from image
docker run -it <image name>	# Access container terminal on start
							# -it = interactive terminal
							# to exit the terminal: "exit"

```

- DOCKER MANAGE CONTAINERS (list & remove)
```bash
docker ps  # List all running containers
docker stop <container name or id>  # Stop container
docker stop $(docker ps -q)  # Stop all running containers
docker kill <container name or id>  # Force stop container
docker rm <container name or id>  # Remove stopped container
docker rm $(docker ps -a -q)  # Remove all stopped containers
docker container prune  # Remove all stopped containers
```

- DOCKER COMPOSE (manage, build, start, stop, down)
```bash
docker-compose ps  # List: name / command / state / ports
docker compose ps  # List: name / image / command / service / created / status / port
docker-compose -f <path_docker_compose> up -d --build  # Build and start in background
docker-compose -f <path_docker_compose> stop  # Stop services
docker-compose -f <path_docker_compose> down  # Remove services
docker-compose -f <path_docker_compose> down -v  # Remove services and volumes
docker-compose -f <path_docker_compose> down -v --rmi all  # Remove services, volumes and all images
```
- DOCKER VOLUMES
```bash
docker volume ls  # List all volumes
docker volume inspect <volume name>  # Inspect volume
docker volume rm <volume name>  # Remove volume
docker volume rm $(docker volume ls -q)  # Remove all volumes
```

- DOCKER NETWORKS
```bash
docker network ls  # List all networks
docker network inspect <network name>  # Inspect network
docker network rm <network name>  # Remove network
docker network rm $(docker network ls -q)  # Remove all networks
```

- GENERAL
```bash
docker system prune -af  # Remove all images and containers
docker logs <container>  # Show logs of container ==> useful to debug
docker-compose down && docker-compose build <image that I changed> && docker-compose up  # Remove all, build updated image, restart
docker-compose down && docker-compose build <image that I changed> && docker-compose up -d  # Remove all, build updated image, restart in background
```

##### Other useful commands for 42 evaluation


**======= MARIADB =======**

- Access MariaDB database:
```bash
docker exec -it mariadb bash  # Access mariadb container
# Inside the container
mysql -u <USER MARIADB NAME> -p  # Connect to the database
<USER MARIADB PW> # Enter password
USE <database name>  # Switch to the correct database
```

- Useful SQL commands:
```sql
SELECT * FROM wp_comments ORDER BY comment_date DESC LIMIT 10;  # show 10 most recent comments (not easy to read)
SELECT comment_ID, comment_post_ID, comment_author, comment_date, comment_content FROM wp_comments ORDER BY comment_date DESC LIMIT 10;  # same but with better format output
SELECT comment_approved FROM wp_comments;  # check if comment is published (1) or not (0)
UPDATE wp_comments SET comment_approved = '1' WHERE comment_ID = <COMMENT ID>;  # approve comment
```

**======= WORDPRESS =======**

- Access WordPress container:
```bash
docker exec -it wordpress bash  # Access wordpress container
# Inside the container
wp comment list  # List all comments
wp comment list --status=approved  # List all approved comments
wp comment list --status=spam  # List all spam comments
wp comment list --status=trash  # List all trashed comments
wp comment list --status=unapproved  # List all unapproved comments
wp comment list --status=hold  # List all comments on hold
wp comment list --status=moderated  # List all comments awaiting moderation
wp comment list --status=0  # List all comments with status 0
wp comment list --status=1  # List all comments with status 1
wp comment list --status=spam  # List all comments with status spam
wp comment list --status=trash  # List all comments with status trash
wp comment list --status=unapproved  # List all comments with status unapproved
wp comment list --status=hold  # List all comments with status hold
wp comment list --status=moderated  # List all comments with status moderated
```

- Access WordPress website:
Website: https://rroussel.42.fr
	to login: https://rroussel.42.fr/wp-admin

> to pass chrome unsafe warning: type "thisisunsafe"


#### Advice and key code parts

**SPECIFIC ORDER TO BUILD THE CONTAINERS**

The order in which you will build your containers is important. For example, you need to build the MariaDB container before the WordPress container because the WordPress container needs the MariaDB container to be up and running to be able to connect to the database. Same goes for the NGINX container that needs the WordPress container to be up and running to be able to connect to the website.
So the final order will be:
1. MariaDB
2. WordPress
3. NGINX

Same when you will start working on the project: do the containers and their associated dockerfiles in the same order, it will be a lot easier to move on!

The order in which you write your Dockerfile is important. For example, if you need to copy a file to a specific location in your container, you need to do it after installing the packages that will allow you to do so. Otherwise, you will get an error.

---

**DOCKER-COMPOSE.YML**

In docker-compose.yml, careful to have all mandatory fields:
	- version
	- services
	- volumes
	- networks
For each service, be sure to have all needed information, for example:
```yaml
services:
    nginx:
        container_name: nginx
        image: nginx:42
        build: requirements/nginx
        depends_on:
            - wordpress
        ports:
            - '443:443'
        volumes:
            - wordpress:/var/www/html
        env_file:
            - .env
        restart : unless-stopped
        networks:
            - inception
```

---

**DOCKERFILE - APT UPDATE AND UPGRADE**

Be sure to always update and upgrade your packages before installing anything:

```bash
RUN apt update -y && apt upgrade -y && apt-get install -y ... # using -y to avoid any prompt asking for confirmation
```

---

**DOCKERFILE - CONF FILE & SCRIPT**

For each container, you need:
- of course to have a Dockerfile
- to install the needed packages

For most of them you will also nee:
- to copy the configuration files form your repository to the right place in the container
- to launch a script that will configure the service. To do so you first need to copy the script to the container and then launch it
Here is an example of a Dockerfile for a MariaDB container:

```Dockerfile
FROM debian:bullseye

# Update and install MariaDB server
RUN apt update -y && apt upgrade -y && apt-get install -y mariadb-server \
	curl

RUN apt-get install systemd -y

# Copy configuration file
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

# Copy script file / Ensure the script is executable
COPY tools/script_mariadb.sh /usr/local/bin/script_mariadb.sh
RUN chmod +x /usr/local/bin/script_mariadb.sh

EXPOSE 3306

# launch my bash script to configure the sql database
CMD ["/usr/local/bin/script_mariadb.sh"]
```

---

**FROM DEBIAN:BULLSEYE & OTHER TOOLS VERSIONS**

Be sure to use the right version of Debian. In this project, we have to use the penultimate stable version of Debian, which means not the latest stable version but the one before. For me, it was bullseye. Be sure to check the version you need to use because it can change a lot of things in your project.

Some other tools or packages may also need to be installed in a specific version, so be sure to check the version you need to use. Be especially careful for your versions of:
- WordPress (I used the version 6.4.3)
- php-fpm (I used the version 7.4)

---

**ENV VARIABLES**

For security reasons, any credentials, API keys, env variables etc... must be saved locally in a .env file and ignored by git. If you store them publicly, you will fail the project immediately.
To avoid this:
- be sure not to store any password in your Dockerfile
- use a .env file to store your env variables
- add the .env file to your .gitignore file AND MAKE SURE TO NOT PUSH IT!

I chosed to write a script that will create the .env file at the start of the project. This way, I am sure to have all the needed env variables and to not forget any. It is not mandatory but it can be a good way to avoid any mistake and to solve the issue in a much more stylish way than copying the .env file from your local machine to the VM. Style matters! :wink:

---

**VOLUMES**

For this project you need to have two volumes:
- one for the WordPress database
- one for the WordPress website files

They will ensure that your data is persistent even after shutting down the containers. Be sure to have them in your docker-compose.yml file and to create them in the right place in your Dockerfile (/home/rroussel/data and replace rroussel by your 42 username).

Be sure to have the right permissions on your volumes, you can use the following commands to check your volumes:
```bash
docker volume ls
docker volume inspect <volume name>
```
It is important (and interesting) to understand how volumes work and how to manage them. It is a key part of the project and it is a good way to learn more about mysql databases and how to manage them. You have to be able during the evaluation to access your MariaDB database and to check/modify the content of your WordPress database. Check the "Useful commands for 42 evaluation" section to know how to do so.

---

**NETWORKS**

You need to create a docker-network to establish the connection between your containers. Be sure to have it in your docker-compose.yml file and to create it in the right place in your Dockerfile. It need to be called "inception" for this project.

---

**Last but not least**

- Be sure to have a Makefile at the root of your directory. It must setup the entire application using docker-compose.yml to build the Docker images. It must contain all the useful commands to run the project and to clean it. You do not have to enter any other command than "make" manually at any moment during the evaluation.

- When opening your "website" on your browser:
	- make sure you cannot connect to it locally / using http
	- to pass the chrome unsafe warning simply type "thisisunsafe
	- use private navigation to avoid any cache issue

---

*Good luck!* Do not hesitate to contact me if you have any question or suggestion to improve this README file! Feel free to star the repository if you found it useful and want to support me! :star: (it will also be easier for you to find it back later on!) Share it with your friends that are struggling, become a hero! :wink:

## Author and Contributing

This project was created by RaphRsl as part of my curriculum at Ecole42 Paris (username rroussel). It is intended for academic purposes only.
If you found this project useful, please consider starring the repository to show your support! :star

### How to Contribute

1. Fork the repository.
2. Create a new branch:
   ```bash
   git checkout -b feature-name
   ```
3. Commit your changes:
   ```bash
   git commit -m 'Add new feature'
   ```
4. Push to the branch:
   ```bash
   git push origin feature-name
   ```
5. Open a pull request.
