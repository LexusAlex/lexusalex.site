---
title: Чистый React
description: >-
  Запускаем новый проект на React без лишних зависимостей в docker
author: alex
date: 2024-10-13 21:30:00 +0300
categories: [Javascript,React]
tags: [js,react,docker]
image:
  path: /assets/img/posts/main/react.webp
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: Чистый React
---

Небольшая заметка как стартовать новый проект на React.

Задача на сегодня максимально быстро с нуля стартовать новый проект на react без использования лишних зависимостей.

## Makefile

Я работаю в `linux`, поэтому сначала создадим `Makefile` в какой-нибудь папке, например `react-simple`.

````text
react-simple
└── Makefile
````

````makefile
docker-build:
	docker compose build --pull
docker-up:
	docker compose up -d
docker-down:
	docker compose down --remove-orphans
npm-install:
	docker compose run --rm node-cli npm install
npm-be-updated-all:
	docker compose run --rm node-cli npm outdated --depth=9999
````

`Makefile` нужен нам для быстрого запуска команд.

## Docker

Подготовим папки для хранения файлов образов, у нас их будет две:

- `nginx` - для запуска веб сервера
- `node` - для запуска `nodejs`

Создадим папку `docker` и следующие файлы:

````text
docker
├── nginx
│ ├── conf.d
│ │ └── default.conf - Конфиг nginx
│ └── Dockerfile
└── node
    └── Dockerfile
````

### react-simple/docker/nginx/conf.d/default.conf

````text
server {
    listen 80;
    charset utf-8;
    root /demo-applications/react-simple;
    server_tokens off;

    resolver 127.0.0.11 ipv6=off;

    add_header X-Frame-Options "SAMEORIGIN";

    location /ws {
        set $upstream http://node:3000;
        proxy_set_header  Host $host;
        proxy_set_header  Upgrade $http_upgrade;
        proxy_set_header  Connection "Upgrade";
        proxy_pass        $upstream;
        proxy_redirect    off;
    }

    location / {
        set $upstream http://node:3000;
        proxy_set_header  Host $host;
        proxy_pass        $upstream;
        proxy_redirect    off;
    }
}
````

### react-simple/docker/nginx/Dockerfile

````dockerfile
FROM nginx:stable

COPY ./nginx/conf.d /etc/nginx/conf.d

WORKDIR /react-simple
````

### react-simple/docker/node/Dockerfile

````dockerfile
FROM node:lts

RUN useradd -m alex && usermod -a -G node alex

RUN npm install -g npm@latest

WORKDIR /react-simple

USER node
````

Так же за папкой `docker`, создаем файл `docker-compose.yml` который будет всем этим управлять.

Там у нас будет три сервиса:

- `node-cli` - запуск консольных команд
- `nginx` - сервер для разработки
- `node` - `nodejs`

````yaml
services:
  node-cli:
    build:
      context: docker
      dockerfile: node/Dockerfile
    volumes:
      - ./:/react-simple
  nginx:
    build:
      context: docker
      dockerfile: nginx/Dockerfile
    ports:
      - "80:80"
    depends_on:
      - node
  node:
    build:
      context: docker
      dockerfile: node/Dockerfile
    environment:
      WDS_SOCKET_PORT: 0
    volumes:
      - ./:/react-simple
    command: npm start
    tty: true
````

В итоге на данный момент у нас такая структура:

`````text
react-simple
├── docker
│ ├── nginx
│ │ ├── conf.d
│ │ │ └── default.conf
│ │ └── Dockerfile
│ └── node
│     └── Dockerfile
├── docker-compose.yml
└── Makefile
`````

Еще добавим в корень файл `.gitignore`.

````text
/node_modules
/coverage
/build
````

Уже можно попробовать собрать контейнеры командой, запустив из корня проекта, но это можно сделать и позже:

````shell
make docker-build
````

Смотрим версии `nodejs`, `npm`:

````shell
docker compose run --rm node-cli node -v # v20.18.0
docker compose run --rm node-cli npm -v # 10.9.0
````

## React

У нас все есть, чтобы наконец поставить основные пакеты `react` в проект:

````shell
docker compose run --rm node-cli npm i react react-dom
docker compose run --rm node-cli npm i -D react-scripts
````

> react-scripts устарел, его лучше заменить на vite.
{: .prompt-info }

Возможно `react-scripts` нужно заменить на более современный `vite`, пишите в комментариях, как это правильно сделать.

После успешной установки создаться файлы:

- `package.json`
- `package-lock.json`

Подредактируем `package.json`, он будет выглядеть примерно следующим образом:

````json
{
  "name": "react",
  "version": "1.0.0",
  "description": "React",
  "main": "index.js",
  "scripts": {
    "start": "react-scripts start",
    "build": "react-scripts build",
    "test": "react-scripts test",
    "eject": "react-scripts eject"
  },
  "browserslist": {
    "production": [
      ">0.2%",
      "not dead",
      "not op_mini all"
    ],
    "development": [
      "last 1 chrome version",
      "last 1 firefox version",
      "last 1 safari version"
    ]
  },
  "dependencies": {
    "react": "^18.3.1",
    "react-dom": "^18.3.1"
  },
  "devDependencies": {
    "react-scripts": "^5.0.1"
  }
}
````

Теперь добавим `react-simple/public/index.html`.

````html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <meta name="description" content="Page"/>
    <title>Simple React</title>
</head>
<body>
<div id="root"></div>
</body>
</html>
````

И основной скрипт запуска `react-simple/src/index.jsx`

````jsx
import React from 'react';
import ReactDOM from 'react-dom/client';

const root = ReactDOM.createRoot(document.getElementById('root'));

root.render(
    <React.StrictMode>
        <>Simple React</>
    </React.StrictMode>
);
````

Как выглядит полная структура директории и файлов:

````text
├── docker
│ ├── nginx
│ │ ├── conf.d
│ │ │ └── default.conf
│ │ └── Dockerfile
│ └── node
│     └── Dockerfile
├── docker-compose.yml
├── Makefile
├── node_modules
├── package.json
├── package-lock.json
├── public
│ └── index.html
└── src
    └── index.jsx
````

Теперь все готово.

## Работа с проектом

Теперь можно пробовать запускать и останавливать проект.

````shell
make docker-up # Запуск
make docker-down # Остановка
````

И если открыть в браузере `127.0.0.1`, то должны увидеть строку `Simple React`.

Цель достигнута.
