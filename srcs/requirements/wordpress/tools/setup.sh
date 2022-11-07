#!/bin/bash

echo " __        __            _ ____
 \\ \\      / /__  _ __ __| |  _ \\ _ __ ___  ___ ___
  \ \ /\ / / _ \| '__/ _' | |_) | '__/ _ \/ __/ __|
   \ V  V / (_) | | | (_| |  __/| | |  __/\__ \__ \\
    \_/\_/ \___/|_|  \__,_|_|   |_|  \___||___/___/\

"

until mariadb -u$MYSQL_USER -p$MYSQL_PW &> /dev/null
do
	echo "waiting for MariaDB to be on..."
	sleep 1
done
# mariadb 로그인에 실패할 경우 sleep 1
# &> 은 오류 (stderr) 를 리디렉션한다
# until 은 while ! 와 같으며, 조건문 내의 조건을 만족하기 전까지 반복한다
