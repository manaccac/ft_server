# **************************************************************************** #
#                                                           LE - /             #
#                                                               /              #
#    start.sh                                         .::    .:/ .      .::    #
#                                                  +:+:+   +:    +:  +:+:+     #
#    By: manaccac <manaccac@student.le-101.fr>      +:+   +:    +:    +:+      #
#                                                  #+#   #+    #+    #+#       #
#    Created: 2020/01/16 14:49:27 by manaccac     #+#   ##    ##    #+#        #
#    Updated: 2020/01/18 13:40:30 by manaccac    ###    #+. /#+    ###.fr      #
#                                                          /                   #
#                                                         /                    #
# **************************************************************************** #

#!/bin/sh

docker build -t server .
docker run -itd -p 80:80 -p 3306:3306 -p 443:443 --name=server server:latest
docker exec -ti server bash
