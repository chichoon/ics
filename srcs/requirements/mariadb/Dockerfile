# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jiychoi <jiychoi@student.42seoul.kr>       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/11/18 11:00:00 by jiychoi           #+#    #+#              #
#    Updated: 2022/11/21 16:00:50 by jiychoi          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:buster

RUN apt-get update -y && apt-get upgrade -y && \
	apt-get install -y mariadb-server mariadb-client

COPY ./tools/setup.sh ./
COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/

EXPOSE 3306

RUN chmod +x ./setup.sh

ENTRYPOINT ["bash", "-c", "./setup.sh"]
