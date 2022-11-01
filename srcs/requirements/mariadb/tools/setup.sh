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
    mysql -e "CREATE DATABASE IF NOT EXISTS $MYSQL_DB;";
    mysql -e "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PW';";
    mysql -e "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';";
    mysql -e "ALTER USER '$MYSQL_ROOT'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PW'; FLUSH PRIVILEGES;"
    mysql $MYSQL_DATABASE -u$MYSQL_ROOT -p$MYSQL_ROOT_PW;
    touch /var/lib/mysql/.setup
fi

exec mysqld --console
