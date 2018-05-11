#!/bin/bash

/usr/bin/mysqld_safe &

sleep 10s

mysql -v < /opt/setupdb.sql

sleep 5s

kill -9 $(pgrep mysql)

sleep 5s
