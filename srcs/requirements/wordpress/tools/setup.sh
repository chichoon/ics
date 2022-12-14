# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    setup.sh                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jiychoi <jiychoi@student.42seoul.kr>       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/11/18 10:59:29 by jiychoi           #+#    #+#              #
#    Updated: 2022/11/21 17:12:06 by jiychoi          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/sh

echo " __        __            _ ____
 \\ \\      / /__  _ __ __| |  _ \\ _ __ ___  ___ ___
  \ \ /\ / / _ \| '__/ _' | |_) | '__/ _ \/ __/ __|
   \ V  V / (_) | | | (_| |  __/| | |  __/\__ \__ \\
    \_/\_/ \___/|_|  \__,_|_|   |_|  \___||___/___/\

"

# until mariadb -h$MYSQL_HOST -u$MYSQL_USER -p$MYSQL_PW 2> /dev/null ; do
# 	echo "waiting for MariaDB to be on..."
# 	sleep 1
# done

sleep 3

# mariadb 로그인에 실패할 경우 sleep 1
# &> 은 오류 (stderr) 를 리디렉션한다
# until 은 while ! 와 같으며, 조건문 내의 조건을 만족하기 전까지 반복한다

chown -R www-data:www-data /var/www/
# nginx가 wordpress에 접근할 수 있도록 권한을 부여함 (chown 유저:그룹 권한부여할 폴더)
# -R 옵션은 하위 폴더까지 recursive하게 권한을 부여하는 옵션

if [ ! -f "/var/www/html/wordpress/index.php" ]; then # index.php가 존재하지 않을 때 => wp 설치 및 초기화가 안 되어 있을 때만 새로 설치
	sudo -u www-data sh -c " \
    wp core download --locale=en_US && \
    wp config create --dbname=$MYSQL_DB --dbhost=$MYSQL_HOST --dbuser=$MYSQL_USER --dbpass=$MYSQL_PW && \
    wp core install --url=$DOMAIN_NAME --title=$WP_TITLE --admin_user=$WP_ADMIN --admin_password=$WP_ADMIN_PW --admin_email=$WP_EMAIL && \
    wp user create $WP_USER $WP_EMAIL --role=author --user_pass=$WP_PASS
	"
fi
# 이상의 명령을 sh에서 www-data 유저로 수행 (sudo -u [유저명] sh -c)
# wp core download: 워드프레스 파일을 서버에서 다운로드 (내려받기만)
# wp config create: wp-config.php 파일 생성 (플래그를 통해 환경변수를 지정)
# wp core install: 다운로드한 워드프레스 파일과 위에서 설정한 config 파일을 바탕으로 워드프레스 설치 및 설정
# wp user create: 워드프레스 유저 생성

exec /usr/sbin/php-fpm7.3 -F # nodaemonize, Foreground에서 실행시키는 옵션
# nginx와 마찬가지로 포어그라운드에서 돌려야 한다 (백그라운드에서 돌리면 스크립트가 끝난 줄 알고 도커가 컨테이너를 off 시킴)
