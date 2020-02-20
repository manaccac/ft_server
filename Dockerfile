# **************************************************************************** #
#                                                           LE - /             #
#                                                               /              #
#    Dockerfile                                       .::    .:/ .      .::    #
#                                                  +:+:+   +:    +:  +:+:+     #
#    By: manaccac <manaccac@student.le-101.fr>      +:+   +:    +:    +:+      #
#                                                  #+#   #+    #+    #+#       #
#    Created: 2020/01/16 11:40:54 by manaccac     #+#   ##    ##    #+#        #
#    Updated: 2020/01/18 15:35:57 by manaccac    ###    #+. /#+    ###.fr      #
#                                                          /                   #
#                                                         /                    #
# **************************************************************************** #

FROM debian:buster

LABEL maintainer="Naccache Maxime <manaccac@student.le-101.fr>"

RUN apt-get update \
&& apt-get -y upgrade \
&& apt-get install -y \
		--no-install-recommends --no-install-suggests -y ca-certificates libssl1.1 \
		nginx \
		default-mysql-server \
		default-mysql-client \
		php \
		php-fpm	\
		php-mysql \
		php-common \
		php-cli \
		php-mbstring \
		php-gd \
		php-curl \
		vim \
		wget\
&& apt-get clean -y \
&& apt-get update \
&& apt-get -y upgrade

RUN apt-get clean \
		&& cd /var/www/html \
		&& wget https://files.phpmyadmin.net/phpMyAdmin/4.9.4/phpMyAdmin-4.9.4-all-languages.tar.gz \
		&& wget https://fr.wordpress.org/latest-fr_FR.tar.gz \
		&& tar -zxvf phpMyAdmin-4.9.4-all-languages.tar.gz \
		&& tar -zxvf latest-fr_FR.tar.gz \
		&& mv phpMyAdmin-4.9.4-all-languages phpmyadmin \
		&& rm phpMyAdmin-4.9.4-all-languages.tar.gz \
		&& rm latest-fr_FR.tar.gz \
		&& chmod 777 -R phpmyadmin \
		&& chmod 777 -R wordpress \
		&& rm /var/www/html/phpmyadmin/config.sample.inc.php

#ADD Ajouter des fichiers dans le container
ADD srcs/default /etc/nginx/sites-available/default
ADD ./srcs/nginx-selfsigned.key /etc/ssl/private/nginx-selfsigned.key
ADD ./srcs/nginx-selfsigned.crt /etc/ssl/certs/nginx-selfsigned.crt
ADD ./srcs/dhparam.pem /etc/nginx/dhparam.pem
ADD ./srcs/self-signed.conf /etc/nginx/snippets/self-signed.conf
ADD ./srcs/ssl-params.conf /etc/nginx/snippets/ssl-params.conf
ADD ./srcs/config.inc.php /var/www/html/phpmyadmin/config.inc.php
ADD ./srcs/user.sql /
ADD ./srcs/service_start.sh /
#ADD ["srcs/nginx/docu1", "srcs/nginx/docu2", "srcs/nginx/docu3", "."]
#COPY C'est la meme chose

RUN	chmod 744 service_start.sh
#VOLUME /app/logs

EXPOSE 80 443 3306

#CMD est a appeler une seul fois a la fin
CMD ["/bin/sh", "service_start.sh"]

