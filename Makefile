# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jiychoi <jiychoi@student.42seoul.kr>       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/10/31 01:23:19 by jiychoi           #+#    #+#              #
#    Updated: 2022/11/03 19:35:28 by jiychoi          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# 도커 컴포즈를 돌리는 Makefile

all: up

up:
	mkdir -p /home/jiychoi/data/wordpress
	mkdir -p /home/jiychoi/data/mariadb
	docker-compose -f ./srcs/docker-compose.yml up --build

down:
	docker-compose -f ./srcs/docker-compose.yml down

clean:
	docker stop $(shell docker ps -qa); docker rm $(shell docker ps -qa);
	docker rmi -f $(shell docker images -qa); docker volume rm $(shell docker volume ls -q);
	docker network rm $(shell docker network ls -q) 2>/dev/null

fclean:
	rm -rf /home/jiychoi/data/wordpress/*
	rm -rf /home/jiychoi/data/mysql/*



re: fclean build

.PHONY: kill build down
