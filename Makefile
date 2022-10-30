# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jiychoi <jiychoi@student.42seoul.kr>       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/10/31 01:23:19 by jiychoi           #+#    #+#              #
#    Updated: 2022/10/31 01:27:08 by jiychoi          ###   ########.fr        #
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
	chmod 666 ./fclean.sh && ./fclean.sh

.PHONY: kill build down
