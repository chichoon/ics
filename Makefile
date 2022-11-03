# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jiychoi <jiychoi@student.42seoul.kr>       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/10/31 01:23:19 by jiychoi           #+#    #+#              #
#    Updated: 2022/11/03 19:22:36 by jiychoi          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# 도커 컴포즈를 돌리는 Makefile

kill:
	cd srcs && docker-compose kill

build:
	cd srcs && docker-compose up

down:
	cd srcs && docker-compose down

fclean:
	docker stop $(docker ps -qa); docker rm $(docker ps -qa);
	docker rmi -f $(docker images -qa); docker volume rm $(docker volume ls -q);
	docker network rm $(docker network ls -q) 2>/dev/null;


re: fclean build

.PHONY: kill build down
