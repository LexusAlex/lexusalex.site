---
title: Mysql 8.4. Установка и настройка сервера.
description: >-
  
author: alex
date: 2055-06-02 09:00:00 +0300
categories: [Sql, Mysql]
tags: [mysql]
---

В июле 2024 (12.07.2024) года вышла mysql 8.4.2
Имеем свежеустановленный сервер ubuntu 24.04
Посмотрим, что нам предлагает штатный установщик `apt`
 
````shell
apt search mysql-server

mysql-server/noble-updates,noble-security 8.0.37-0ubuntu0.24.04.1 all
  MySQL database server (metapackage depending on the latest version)
````

Нам нужна более свежая версия, ее и будем ставить

## Установка 8.4 lts

Подключим репозитории mysql. Для этого перейдем на страничку [https://dev.mysql.com/downloads/repo/apt/](https://dev.mysql.com/downloads/repo/apt/) и скачаем установщик

```shell
# Скачаем пакет
wget https://dev.mysql.com/get/mysql-apt-config_0.8.32-1_all.deb
# Установим
sudo dpkg -i mysql-apt-config_0.8.32-1_all.deb
```

Далее будет предложено выбрать конфигурацию репозитория. Выбираем 2 варианта. То есть пункт 3.

Проверяем 

````shell
apt search mysql-server

mysql-server/unknown 8.4.2-1ubuntu24.04 amd64
  MySQL Server meta package depending on latest version
````
 
Вот теперь все верно можно устанавливать.

````shell
sudo apt-get install mysql-server
````

В процессе установки будет предложено ввести пароль пользователя mysql root

Теперь нужно ввести ряд команд

````shell
sudo systemctl is-enabled mysql
sudo systemctl status mysql
mysql -V  # mysql  Ver 8.4.2 for Linux on x86_64 (MySQL Community Server - GPL)
````

Пробуем заходить

````shell
sudo mysql -u root -p
````


Продолжить
https://geekandnix.com/ubuntu/mysql/


https://dev.mysql.com/downloads/repo/apt/
https://dev.mysql.com/doc/refman/8.4/en/linux-installation-apt-repo.html#repo-qg-apt-select-series
