# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jiychoi <jiychoi@student.42seoul.kr>       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/10/31 01:23:19 by jiychoi           #+#    #+#              #
#    Updated: 2022/11/21 16:03:38 by jiychoi          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# 도커 컴포즈를 돌리는 Makefile

all: up

up:
	mkdir -p /home/jiychoi/data/wordpress
	mkdir -p /home/jiychoi/data/mariadb
	sudo echo "127.0.0.1	jiychoi.42.fr" > /etc/hosts
	docker-compose -f ./srcs/docker-compose.yml up --build

down:
	docker-compose -f ./srcs/docker-compose.yml down

clean:
	docker-compose -f ./srcs/docker-compose.yml down --rmi all --volumes

fclean: clean
	rm -rf /home/jiychoi/data/wordpress/*
	rm -rf /home/jiychoi/data/mariadb/*

re: fclean all

.PHONY: all down clean fclean re
