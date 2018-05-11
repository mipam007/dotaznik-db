#!/bin/bash

/usr/bin/mysqld_safe &

sleep 10s

mysql -v < /opt/setupdb.sql

sleep 5s

kill -9 $(pgrep mysql)

rm /var/run/mariadb/mariadb.pid

sleep 5s
