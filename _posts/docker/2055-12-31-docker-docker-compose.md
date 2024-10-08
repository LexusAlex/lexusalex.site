---
title: Исследуем docker и docker compose
description: >-
  Разберем возможности docker и docker compose
author: alex
date: 2055-03-31 18:00:00 +0300
categories: [Docker]
tags: [docker docker-compose]
---

https://doka.guide/tools/docker/
https://yandex.cloud/ru/blog/posts/2022/03/docker-containers
https://guides.hexlet.io/ru/docker/
https://hightemp.github.io/doc_notes/%D0%97%D0%B0%D0%BC%D0%B5%D1%82%D0%BA%D0%B8/%D0%A0%D0%B0%D0%B7%D0%B0%D1%80%D0%B1%D0%BE%D1%82%D0%BA%D0%B0/docker/FAQ.html


## Основная мысль docker
 
При использовании контейнеров docker, приложение теперь отделено от инфраструктуры, что дает:

- Изолированное окружение для запуска
- Простое управление приложением
- Легкое масштабирование

Контейнеры можно перезапустить, удалить, остановить, при этом данные внутри тоже будут уничтожены, поэтому важные данные в контейнере не хранят.
Такая архитектура называется `Stateless`. 

Про `Stateless` и `Stateful` подходы можно почитать в статье [https://lexusalex.site/posts/basics-stateful-and-stateless/](https://lexusalex.site/posts/basics-stateful-and-stateless/)

Внутри контейнеров, как правило, упаковывают только те зависимости которые нужные для выполнения кода.

В идеологии `docker` один контейнер соответствует одному процессу ОС.

Приложения запущенные внутри контейнера, не имеют доступа к основной ОС.

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
service docker status
docker -v # Docker version 27.2.0, build 3ab4256
docker compose version # Docker Compose version v2.29.2
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

Если нужно обновить docker compose:

````shell
DOCKER_CONFIG=${DOCKER_CONFIG:-$HOME/.docker} # Папка до плагинов docker
mkdir -p $DOCKER_CONFIG/cli-plugins # Сама папка
# Верхние 2 команды можно сделать один раз
curl -SL https://github.com/docker/compose/releases/download/v2.29.2/docker-compose-linux-x86_64 -o $DOCKER_CONFIG/cli-plugins/docker-compose # Скачиваем новую версию
chmod +x $DOCKER_CONFIG/cli-plugins/docker-compose # Делаем файл исполняемым
sudo chmod +x /usr/local/lib/docker/cli-plugins/docker-compose
docker compose version # Проверяем версию
````

Возможно есть способ легче, кто знает, пишите в комментариях.

## Основные понятия

- `Daemon` - Служба `dockerd`, которая обрабатывает запросы от `api`. Служба работает в фоне и управляет контейнерами, образами, сетями и томами.
- `Client` - Непосредственно утилита `docker`. Основной способ коммуникации с `Daemon`, например при выполнении команды `docker run`.
- `Registry` - Хранилище образов. Можно как скачать образ, так и загрузить образ в реестр.
- `Image` - Образ. Файл с инструкциями, из которого можно много раз развернуть контейнер. Часто образ представляет собой модификацию другого образа.
- `Dockerfile` - Текстовый файл с инструкциями для создания образа, по принципу "строка - команда"
- `Container` - Приложение развернутое из образа.
- `Volume` - Тома для хранения данных на хост машине.

## Как работает docker

Мы имеем три составляющие:

- `Client` - это просто внешняя утилита
- `Docker HOST` - это компьютер где стоит docker
- `Regisry` - хранилище образов

`Client` обращается к `Docker HOST` к `Daemon` который и управляет контейнерами и образами. `Client` и `Daemon` могут быть запущены на одной машине или на разных.

При выполнении таких команд как `docker pull` или `docker run` образы будут загружаться из `Registry`.

> Важно понимать, что docker использует ядро linux хостовой ОС
{: .prompt-info }



## Образ

Образ состоит из базового образа и доступных для чтения слоев. В итоговый образ входит объединение всех слоев в один.

## Контейнер

Это образ со слоем записи.

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



