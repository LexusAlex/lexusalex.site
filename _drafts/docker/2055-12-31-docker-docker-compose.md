---
title: Исследуем docker и docker compose
description: >-
  Разберем возможности docker и docker compose
author: alex
date: 2055-03-31 18:00:00 +0300
categories: [Docker]
tags: [docker docker-compose]
---

## Основная мысль docker

В теорию не будем уходить, здесь будет больше практических примеров использования `docker` и `docker-compose`.
 
При использовании контейнеров `docker`, приложение теперь отделено от инфраструктуры, что дает:

- Изолированное окружение для запуска
- Простое управление приложением
- Легкое масштабирование

Контейнеры можно перезапустить, удалить, остановить, при этом данные внутри тоже будут уничтожены, поэтому важные данные в контейнере не хранят.
Такая архитектура называется `Stateless`. 

Про `Stateless` и `Stateful` сделал небольшую заметку [https://lexusalex.site/posts/basics-stateful-and-stateless/](https://lexusalex.site/posts/basics-stateful-and-stateless/)

Внутри контейнеров, как правило, упаковывают только те зависимости которые нужные для выполнения кода.

В идеологии `docker` один контейнер соответствует одному процессу ОС.

Приложения запущенные внутри контейнера, не имеют доступа к основной ОС.

Получается в одном контейнере у нас запущено приложение с его зависимостями.

## Установка

Актуальная инструкция установки на `ubuntu` на официальном сайте [https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository](https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository)
 
Поддерживаются все актуальные версии `ubuntu` с 20 по 24.

В данном случае я ставлю на ubuntu 24.04 LTS.

Разберем каждую строчку установки:

````shell
# Add Docker's official GPG key:
sudo apt-get update # Обновляем пакеты
sudo apt-get install ca-certificates curl # Установка пакета для сертификатов и curl
sudo install -m 0755 -d /etc/apt/keyrings # Права на директорию для ключей
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc # Скачиваем ключ
sudo chmod a+r /etc/apt/keyrings/docker.asc # Всем для чтения

# Add the repository to Apt sources:
echo \ # Добавим репозитории
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update # Обновляем пакеты
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin # Ставим пакеты docker
````

Проверяем, что все установились:

````shell
# Версии на ноябрь 2024
service docker status
docker -v # Docker version 27.3.1, build ce12230
docker compose version # Docker Compose version v2.29.7
````

Дальнейшие шаги, добавляем текущего пользователя в группу docker:

````shell
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker
````

В ubuntu docker будет запущен автоматически при старте системы.

Иногда нужно выполнить команду `sudo chmod 666 /var/run/docker.sock`

На моей другой системе ubuntu 22.04 я не могу обновить docker compose до последней версии, нашел инструкцию на официальном сайте 
[https://docs.docker.com/compose/install/linux/#install-the-plugin-manually](https://docs.docker.com/compose/install/linux/#install-the-plugin-manually)

Если нужно обновить docker compose до последней версии:

````shell
DOCKER_CONFIG=${DOCKER_CONFIG:-$HOME/.docker} # Папка до плагинов docker
mkdir -p $DOCKER_CONFIG/cli-plugins # Делаем папку для плагинов docker
# Верхние 2 команды можно сделать один раз
curl -SL https://github.com/docker/compose/releases/download/v2.30.3/docker-compose-linux-x86_64 -o $DOCKER_CONFIG/cli-plugins/docker-compose # Скачиваем новую версию
chmod +x $DOCKER_CONFIG/cli-plugins/docker-compose # Делаем файл исполняемым если это нужно сделать для всех пользователей то так sudo chmod +x /usr/local/lib/docker/cli-plugins/docker-compose
docker compose version # Проверяем версию
# Docker Compose version v2.30.3
````

Пока docker-compose нужно обновлять вручную, не нашел как это делать атоматически.

Возможно есть способ легче, кто знает, пишите в комментариях.

## Основные понятия

- `Daemon` - Служба `dockerd`, которая обрабатывает запросы от `api`. Служба работает в фоне и управляет контейнерами, образами, сетями и томами.
- `Client` - Непосредственно утилита `docker`. Основной способ коммуникации с `Daemon`, например при выполнении команды `docker run`.
- `Registry` - Хранилище образов. Можно как скачать образ, так и загрузить образ в реестр.
- `Image` - Образ. Файл с инструкциями, из которого можно много раз развернуть контейнер. Часто образ представляет собой модификацию другого образа.
- `Dockerfile` - Текстовый файл с инструкциями для создания образа, по принципу "строка - команда"
- `Container` - Приложение развернутое из образа.
- `Volume` - Тома для хранения данных на хост машине.

## Как и где работает docker

Мы имеем три составляющие:

- `Client` - это просто внешняя утилита
- `Docker HOST` - это компьютер где стоит docker
- `Regisry` - хранилище образов, публичный или приватный.

`Client` обращается к `Docker HOST` к `Daemon` который и управляет контейнерами и образами. `Client` и `Daemon` могут быть запущены на одной машине или на разных.

При выполнении таких команд как `docker pull` или `docker run` образы будут загружаться из `Registry` в `local registry` на `Docker HOST`.

> Важно понимать, что docker использует ядро linux хостовой ОС.
{: .prompt-info }

В текущих реалиях `docker` может работать следующим образом. Напишем в виде такой иерархии.

1. Физическое железо
   1. `Hypervisor`
      1. Виртуальная машина 1
         1. `docker`
            1. Контейнер 1
               1. Приложение, например веб сервер
               2. Библиотеки и зависимости приложения
            2. Контейнер 2
               1. Приложение, например база данных
               2. Библиотеки и зависимости приложения
      2. Виртуальная машина 2
         1. `docker`
            1. Контейнер 1
               1. Приложение
               2. Библиотеки и зависимости приложения
            2. Контейнер 2
               1. Приложение
               2. Библиотеки и зависимости приложения

Это просто отдельный процесс, как все остальные процессы на сервере.

## Команды управления docker

Проверка работы процесса docker:

````shell
service docker status
### ... вывод что docker работает или не работает
````

Версия `docker`:

````shell
docker -v
# Docker version 27.3.1, build ce12230
````

## Образ

Образ состоит из базового образа и доступных для чтения слоев. 
В итоговый образ входит объединение всех слоев в один.

Для наглядности скачаем образ `ubuntu`.

### docker pull

````shell
docker pull ubuntu

Using default tag: latest
latest: Pulling from library/ubuntu
afad30e59d72: Pull complete 
Digest: sha256:278628f08d4979fb9af9ead44277dbc9c92c2465922310916ad0c46ec9999295
Status: Downloaded newer image for ubuntu:latest
docker.io/library/ubuntu:latest
````

Он будет скачан с тегом по умолчанию `latest`. То есть последняя версия.

Наглядно увидеть все слои образа можно посмотреть [здесь](https://hub.docker.com/layers/library/ubuntu/latest/images/sha256-f470988096c4d77efac9740a1b6700823681af518a17fad30111430b95dfbffa?context=explore)

Так же образ можно скачать по его идентификатору, например

````shell
docker pull ubuntu@sha256:278628f08d4979fb9af9ead44277dbc9c92c2465922310916ad0c46ec9999295
````

> По умолчанию образы качаются с docker hub, но это может быть и любое другое хранилище
{: .prompt-info }

### docker images 

`docker image ls` ил `docker image list`, команды являются алиасами.

Команда выводит список всех созданных образов в системе в таблице

````shell
docker images
REPOSITORY  TAG       IMAGE ID       CREATED        SIZE
ubuntu      latest    fec8bfd95b54   4 weeks ago    78.1MB
````

Где:

- `REPOSITORY` - Репозиторий, как называется образ
- `TAG` - Тег образа или его версия
- `IMAGE ID` - Идентификатор образа
- `CREATED` - Когда образ был создан
- `SIZE` - Размер всех слоев образа

## Контейнер

Это экземпляр образа со слоем записи.

Его можно запустить и остановить.

### docker run

Основная команда, просто создадим и запустим контейнер

````shell
docker run ubuntu ls
# ... список директорий внутри контейнера
````

````shell
docker run -d ubuntu /bin/bash
````

### docker ps

Список контейнеров.

По умолчанию отображаются только запущенные контейнеры, мы отобразим все

````shell
docker ps -a
CONTAINER ID   IMAGE   COMMAND  CREATED         STATUS                     PORTS     NAMES
34b861b46fbf   ubuntu  "ls"     3 minutes ago   Exited (0) 3 minutes ago             mystifying_ganguly
````

Где:

- `CONTAINER ID` - Идентификатор контейнера
- `IMAGE` - Образ на основании которого был собран контейнер
- `COMMAND` - Команда контейнера
- `CREATED` - Когда создан контейнер
- `STATUS` - Статус контейнера
- `PORTS` - Проброшенные порты
- `NAMES` - Имена контейнера




Состояния контейнера

https://my-js.org/docs/guide/docker/#%D0%BA%D0%BE%D0%BC%D0%B0%D0%BD%D0%B4%D1%8B-%D0%B8-%D1%84%D0%BB%D0%B0%D0%B3%D0%B8

docker run
docker restart
docker pause
docker kill
docker stop
docker start
docker unpause
docker create
docker rm

- running
- stopped
- paused

## Плюсы docker

https://yandex.cloud/ru/blog/posts/2022/03/docker-containers#preimushestva-ispolzovaniya-docker


https://my-js.org/docs/guide/docker/#docker-compose


https://devops.org.ru/docker-summary

https://doka.guide/tools/docker/
https://yandex.cloud/ru/blog/posts/2022/03/docker-containers
https://guides.hexlet.io/ru/docker/
https://hightemp.github.io/doc_notes/%D0%97%D0%B0%D0%BC%D0%B5%D1%82%D0%BA%D0%B8/%D0%A0%D0%B0%D0%B7%D0%B0%D1%80%D0%B1%D0%BE%D1%82%D0%BA%D0%B0/docker/FAQ.html



