all: env_check
	mkdir -p /home/$(USER)/data/mariadb
	mkdir -p /home/$(USER)/data/wordpress

	sudo chown -R $(whoami):$(whoami) /home/$(USER)/data/mariadb
	sudo chown -R $(whoami):$(whoami) /home/$(USER)/data/wordpress

	sudo chmod -R 755 /home/$(USER)/data/wordpress
	sudo chmod -R 755 /home/$(USER)/data/mariadb
	sudo sed -i 's/127.0.0.1	localhost/127.0.0.1	localhost $(USER).42.fr/' /etc/hosts

	sed -i "s/rroussel/${USER}/g" "srcs/docker-compose.yml"
	@$(MAKE) up

env_check:
	@if [ ! -f srcs/.env ]; then \
		echo "File srcs/.env not found..."; \
		$(MAKE) env_make; \
	else \
		echo "File srcs/.env already exists! (to change it: make env_reset)"; \
	fi

env_clean:
	@echo "Suppressing env file..."
	@sudo rm -rf srcs/.env

env_reset: env_clean
	@$(MAKE) env_make

env_make:
	@echo "Creating new env file..."
	@touch srcs/.env
	@echo "USER=$(USER)" >> ./srcs/.env
	@echo "DOMAIN_NAME=$(USER).42.fr" >> ./srcs/.env
	@echo "CERTS=/etc/nginx/ssl/nginx.crt" >> ./srcs/.env
	@echo "KEYS=/etc/nginx/ssl/nginx.key" >> ./srcs/.env
	@fill_env_var() { \
		read -p "$$1: " value; \
		if [ -z "$$value" ]; then \
			echo "ERROR: $$1 cannot be empty"; \
			rm -rf srcs/.env; \
			exit 1; \
		fi; \
		echo "$$2=$$value" >> ./srcs/.env; \
	}; \
	fill_env_var "DB name:" "DB_NAME"; \
	fill_env_var "DB root password:" "DB_ROOT_PASSWORD"; \
	fill_env_var "DB user name:" "DB_USER"; \
	fill_env_var "DB user password:" "DB_PASSWORD"; \
	fill_env_var "WP title:" "WP_TITLE"; \
	fill_env_var "WP admin name - should not contain admin:" "WP_ADMIN"; \
	fill_env_var "WP admin password:" "WP_ADMIN_PASSWORD"; \
	fill_env_var "Wp admin email:" "WP_ADMIN_EMAIL"; \
	fill_env_var "WP basic user name:" "WP_USER"; \
	fill_env_var "WP basic user password:" "WP_USER_PASSWORD"; \
	fill_env_var "WP basic user email" "WP_USER_EMAIL";
	@echo "File .env was created successfully!"
	@echo "\033[0;33mAre you sure that all env variables are correct?\033[0m"
	@read -p "I am sure / Delete env file [y/n]: " answer; \
	if [ "$$answer" != "y" ]; then \
		rm -rf srcs/.env; \
		exit 1; \
	fi

up:
	sudo docker-compose -f srcs/docker-compose.yml up --build -d

down:
	sudo docker-compose -f srcs/docker-compose.yml down

clean:
	sudo docker-compose -f srcs/docker-compose.yml down -v --remove-orphans --rmi all

fclean: clean
	sudo rm -rf /home/$(USER)/data/mariadb /home/$(USER)/data/wordpress
	@$(MAKE) env_clean