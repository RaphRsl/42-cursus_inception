PATH_YML = ./srcs/docker-compose.yml

ifneq (,$(wildcard srcs/requirements/tools/data_path.txt))
	path_file := srcs/requirements/tools/data_path.txt
	variable := $(shell cat ${path_file})
	wordpress_path := $(shell echo ${variable}/wordpress)
	mariadb_path := $(shell echo ${variable}/mariadb)
endif

# Main target
all:
ifeq (,$(wildcard ./srcs/requirements/tools/data_path.txt))
	@bash srcs/requirements/tools/path_config.sh
	@echo "Good!"
	@echo "Use make to launch"
else
ifeq (,$(wildcard $(mariadb_path)))
	@mkdir -p $(mariadb_path)
	@mkdir -p $(wordpress_path)
	@chmod 777 $(mariadb_path)
	@chmod 777 $(wordpress_path)
endif
	@echo "Starting Inception..."
	@sleep 1
	@docker-compose -f $(PATH_YML) up -d --build
endif

# Rebuild target
re: clean all

# Stop containers
stop:
	@docker-compose -f $(PATH_YML) stop

# Clean containers and volumes
clean: stop
	@docker-compose -f $(PATH_YML) down -v

# Full clean, including paths and system prune
fclean: clean
	@rm -rf $(wordpress_path)
	@rm -rf $(mariadb_path)
	@docker system prune -af

# Reset configuration
reset: clean
	@rm -f srcs/requirements/tools/data_path.txt
	@printf "\nPath is reset\n"

# Run configuration script
config:
	@bash srcs/requirements/tools/path_config.sh

.PHONY: all re stop clean fclean reset config