#!/bin/sh

echo "                       _       _____  ____
                      (_)     |  __ \|  _ \\
  _ __ ___   __ _ _ __ _  __ _| |  | | |_) |
 | '_ ' _ \ / _' | '__| |/ _' | |  | |  _ <
 | | | | | | (_| | |  | | (_| | |__| | |_) |
 |_| |_| |_|\__,_|_|  |_|\__,_|_____/|____/

"

service mysql start;
# MySQL 서비스 시작 (mariaDB는 MySQL의 포크판)

cat /var/lib/mysql/.setup 2> /dev/null;
# /var/lib/mysql 폴더 (볼륨) 에 .setup 파일이 있을 경우 에러 X
# .setup 파일이 존재하지 않을 경우 에러 발생 => 내용물은 쓰레기통으로
# 그와 함께 $? errno에 값이 설정됨

if [ $? -ne 0 ]; then
    mysql -e "CREATE DATABASE IF NOT EXISTS $MYSQL_DB"; # 새로운 DB 생성 (기존에 존재하지 않을 경우)
    mysql -e "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PW'"; # 유저 생성 (기존에 존재하지 않을 경우)
    mysql -e "GRANT ALL PRIVILEGES ON $MYSQL_DB.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PW'";
    mysql -e "FLUSH PRIVILEGES"; # 생성된 유저에 DB의 모든 권한 부여
    echo "privilege done"
    mysql -e "ALTER USER '$MYSQL_ROOT'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PW'"; # 루트 계정 비밀번호 초기화
    echo "alter user done?"
    mysql $MYSQL_DB -u$MYSQL_USER -p$MYSQL_PW; #루트 계정으로 로그인
    touch /var/lib/mysql/.setup;
fi

exec mysqld --console
