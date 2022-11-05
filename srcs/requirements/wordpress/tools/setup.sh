#!/bin/sh

echo " __        __            _ ____
 \\ \\      / /__  _ __ __| |  _ \\ _ __ ___  ___ ___
  \ \ /\ / / _ \| '__/ _' | |_) | '__/ _ \/ __/ __|
   \ V  V / (_) | | | (_| |  __/| | |  __/\__ \__ \\
    \_/\_/ \___/|_|  \__,_|_|   |_|  \___||___/___/\

"

while ! mariadb -u$MYSQL_USER -p$MYSQL_PW &> /dev/null; do
	echo "waiting for MariaDB to be on..."
	sleep 1
done
