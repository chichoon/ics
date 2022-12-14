# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    setup.sh                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jiychoi <jiychoi@student.42seoul.kr>       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/11/18 10:59:37 by jiychoi           #+#    #+#              #
#    Updated: 2022/11/22 03:27:00 by jiychoi          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/sh

echo "                       _       _____  ____
                      (_)     |  __ \|  _ \\
  _ __ ___   __ _ _ __ _  __ _| |  | | |_) |
 | '_ ' _ \ / _' | '__| |/ _' | |  | |  _ <
 | | | | | | (_| | |  | | (_| | |__| | |_) |
 |_| |_| |_|\__,_|_|  |_|\__,_|_____/|____/

"
chown -R mysql:mysql /var/lib/mysql; # /var/lib/mysql (mysql 설치 경로) 에 mysql 유저 (mysql 그룹) 에 대한 권한 부여

cat /var/lib/mysql/.setup 2> /dev/null;
# /var/lib/mysql 폴더 (볼륨) 에 .setup 파일이 있을 경우 에러 X
# .setup 파일이 존재하지 않을 경우 에러 발생 => 내용물은 쓰레기통으로
# 그와 함께 $? errno에 값이 설정됨

if [ $? -ne 0 ]; then # $?이 0이 아닐 경우 (not equal) => 에러가 났다는 뜻 => .setup이 존재하지 않으므로 새로 만들어야 함
    service mysql start; # MySQL 서비스 시작 (mariaDB는 MySQL의 포크판)
    mysql -hlocalhost -e "CREATE DATABASE IF NOT EXISTS $MYSQL_DB"; # 새로운 DB 생성 (기존에 존재하지 않을 경우)
    mysql -hlocalhost -e "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PW'"; # 유저 생성 (기존에 존재하지 않을 경우)
    mysql -hlocalhost -e "GRANT ALL PRIVILEGES ON $MYSQL_DB.* TO '$MYSQL_USER'@'%'"; # 생성된 유저에 DB (내의 모든 테이블) 의 모든 권한 부여 (원격 접속 권한 포함)
    mysql -hlocalhost -e "FLUSH PRIVILEGES"; # 그리고 권한 변경사항을 전부 즉시 적용
    mysql -hlocalhost -e "ALTER USER '$MYSQL_ROOT'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PW'"; # 루트 계정 비밀번호 초기화
    mysql -hlocalhost -e "FLUSH PRIVILEGES"; # 그리고 권한 변경사항을 전부 즉시 적용

    mysql -hlocalhost $MYSQL_DB -u$MYSQL_ROOT -p$MYSQL_ROOT_PW; #루트 계정으로 로그인
    mysqladmin -hlocalhost -u$MYSQL_ROOT -p$MYSQL_ROOT_PW shutdown;
    touch /var/lib/mysql/.setup;
fi

exec service mysql start | mysqld --console;
