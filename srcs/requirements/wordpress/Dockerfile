# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jiychoi <jiychoi@student.42seoul.kr>       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/11/18 10:59:53 by jiychoi           #+#    #+#              #
#    Updated: 2022/11/18 10:59:54 by jiychoi          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# wordpress cli 를 쓰세요
FROM debian:buster

RUN apt-get update -y && apt-get upgrade -y && \
	apt-get -y install wget tar php7.3-fpm php7.3-mysql mariadb-client

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	mv wp-cli.phar /usr/bin/ && \
	chmod +x /usr/bin/wp-cli.phar

# https://www.lesstif.com/system-admin/wordpress-command-line-wp-cli-128122908.html
# wordpress cli 설치 후 폴더이동 및 권한설정

COPY ./tools/setup.sh ./
COPY ./conf/www.conf /etc/php/7.3/fpm/pool.d/www.conf

EXPOSE 9000

RUN mkdir -p /run/php && \
	chmod 777 ./setup.sh

# 필요한 경우 상위 경로까지 생성

CMD ["bash", "-c", "./setup.sh"]

# php: wordpress를 실질적으로 구동시키는 언어
#	데이터베이스에서 정보를 가져오고, HTML 페이지로 구성하는 등의 행동을 함
# wget: 웹에서 wordpress 내려받기용 web get 프로그램
# tar: tar 압축 해제 프로그램
# php7.3-fpm:
#	CGI는 클라이언트 요청을 서버에 전달해주는 (웹서버 - 외부 프로토콜 연결) 프로토콜
#	CGI는 요청이 들어올 때마다 프로세스를 생성하고 삭제하는 것을 반복하므로, 느려진다
#	FastCGI는 CGI의 느린 단점을 개선하기 위한 새로운 인터페이스
#	php-fpm은 php가 FastCGI 모드로 동작할 수 있게 해주며, php도 같이 설치된다
#	https://phsun102.tistory.com/46
# php7.3-mysql: php와 DB를 연동해주는 패키지
