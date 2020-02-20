#!/bin/sh

service nginx start
service php7.3-fpm start
service mysql start

mysql < user.sql

service mysql restart
nginx -g "daemon off;"
sleep infinity & wait;
