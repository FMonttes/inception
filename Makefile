name = inception

.DEFAULT_GOAL := all

env:
	./make_env.sh

all:
	@bash srcs/requirements/mariadb/tools/make_db_dirs.sh
	@docker compose -f ./srcs/docker-compose.yml up -d --build

build:
	@bash srcs/requirements/mariadb/tools/make_db_dirs.sh
	@docker compose -f ./srcs/docker-compose.yml build

down:
	@docker compose -f ./srcs/docker-compose.yml down

clean: down
	@printf "Cleaning  ${name}...\n"
	@docker compose -f ./srcs/docker-compose.yml down --volumes --rmi local
	@sudo rm -rf ~/data

fclean: down
	@printf "Clean of all docker configs\n"
	@docker system prune --all
	@sudo rm -rf ~/data
 
.PHONY : all build down clean fclean info env