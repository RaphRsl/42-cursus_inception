======= DOCKER COMMANDS =======

DOCKER BUILD
	- **docker build srcs/requirements/nginx/**  = build nginx
	- **docker build .**  = si on est deja dans le bon directory
	- **docker build -t nginx .**  = renommer le build nginx
- DOCKER IMAGE
	- **docker image ls**  = liste les images actuelles
	- **docker images -a** = liste des images actuelles
- DOCKER REMOVE IMAGES
	- **docker rmi $(docker images -a -q)** = remove all docker images using their IDs (first stop all running containers usign those images)
		- *-a = list all images*
		- *-a -q = list all images IDs*
	- **docker rmi -f $(docker images -a -q)** = force removal of images if they are still used by stopped containers
- DOCKER RUN
	- **docker run \< image name \>** = demarrer un container d'apres une image
	- **docker run -it \< image name \>** = acceder directement au terminal du container a son lancement
	* **Quitter le terminal d'un container** = exit
- DOCKER PS
	- **docker ps**  = connaitre les container actuellement lancés
- DOCKER STOP AND REMOVE CONTAINERS
	* **docker stop \< container name or id \>** = stoper un container
	* **docker stop $(docker ps -q)** = stop all running containers
	* **docker kill \< container name or id \>** = forcer arret container
	* **docker rm \< contaimer name or id \>** = remove a stopped container
	* **docker rm $(docker ps -a -q)** = remover all stopped containers
	* **docker container prune** = remove all stopped containers
- DOCKER COMPOSE YAML
	- **docker-compose -f  <path_docker_compose>  -d —build** = build yaml
	- **docker-compose -f  <path_docker_compose>  stop** = stop build
	- **docker-compose -f  <path_docker_compose>  down -v** = supprimer le build
- CLEAN VOLUMES / NETWORKS
	- **docker volume rm $(docker volume ls -q)** = remove all volumes
	- **docker network rm $(docker network ls -q)** = remove all networks
- GENERAL
	* **docker system prune -af** = supprime toutes les images / containers
	* **docker logs \< container \>** = logs du container
	* **docker-compose down && docker-compose build \< image that I changed \> && docker-compose up** = tout suppr, mettre a jouer l'image, relancer
	* **docker-compose down && docker-compose build \< image that I changed \> && docker-compose up -d** = pareil mais lance en background


<!-- ---------------------------------- -->
<!-- ---------------------------------- -->
<!-- ||          FOR 42 EVAL         || -->
<!-- ---------------------------------- -->
<!-- ---------------------------------- -->


======= DOCKER COMMANDS =======

docker image ls
docker ps
docker network ls
dokcer volume ls
  docker volume inspect \< volume name \>


docker-compose ps
  name / command / state / ports
docker compose ps
  name / image / command / service / created / status / port



======= MARIADB =======

docker exec -it mariadb bash ==> access mariadb container
	mysql -u \< USER MARIADB NAME \> -p  ==> connect to the database
	\< USER MARIADB PW \>
	USE \< database name \> ==> switch to the correct database
		- SELECT \* FROM wp_comments ORDER BY comment_date DESC LIMIT 10;   ==> 10 most recent comments
		- SELECT comment_ID, comment_post_ID, comment_author, comment_date, comment_content FROM wp_comments ORDER BY comment_date DESC LIMIT 10;  ==> same but with better format output
		- comment_approved ==> check if comment is published (1) or not (0)

	UPDATE wp_comments SET comment_approved = '1' WHERE comment_ID = \< COMMENT ID \>;



======= WORDPRESS =======

pass chrome unsafe warning: "thisisunsafe"
https://rroussel.42.fr
	to login: /wp-admin
