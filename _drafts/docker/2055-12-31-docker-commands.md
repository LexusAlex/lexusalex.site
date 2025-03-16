---
title: Команды docker
description: >-
  Список основных команд для работы с docker и docker-compose
author: alex
date: 2055-03-31 18:00:00 +0300
categories: [Docker]
tags: [docker docker-compose]
---

https://desoft.ru/2024/12/04/spisok-osnovnyh-komand-dlya-raboty-s-docker/

Узнать ip контейнера

docker inspect \
-f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' 9f972bfffd0faaaa3694723302a7d75cab5b42e3487d1f4d8c393c44eb822996



