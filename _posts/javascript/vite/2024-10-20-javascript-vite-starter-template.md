---
title: Проект под любые нужны с vite
description: >-
  Запускаем новый проект на чистом js с vite в docker за 10 минут
author: alex
date: 2024-10-20 17:40:00 +0300
categories: [Javascript,Vite]
tags: [js,docker,vite]
image:
  path: /assets/img/posts/main/vite.png
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: Проект под любые нужны с vite
---

## Вводная

Иногда нужно просто запустить какой-то javascript код, или проект написанный на чистом javascript. 
Или просто проверить свое решение.

Здесь нам поможет современный, быстрый сборщик [vite](https://vite.dev/).

Я намеренно не даю ссылку на готовый код на github, дабы это не будет универсальным подходящим решением для всех.

Когда ты разворачиваешь самостоятельно не копируя готовый код, приходит понимание как это работает.

В этой заметке, мы просто запустим скелет проекта с нуля. 

## Что нам нужно

Для запуска стартового проекта с нуля, нам нужен будет только `docker`.

С него и начнем.

## docker 

Сперва создадим папку `docker` и несколько файлов, где будут настройки наших контейнеров.

````text
docker
├── nginx
│    ├── conf.d
│    │   └── default.conf
│    └── Dockerfile
└── node
    └── Dockerfile
````

### vite-simple/docker/nginx/conf.d/default.conf

````text
server {
    listen 80;
    charset utf-8;
    root /vite-simple;
    server_tokens off;

    resolver 127.0.0.11 ipv6=off;

    add_header X-Frame-Options "SAMEORIGIN";

    location / {
        set $upstream http://node:5173;
        proxy_set_header  Host $host;
        proxy_set_header  Upgrade $http_upgrade;
        proxy_set_header  Connection "Upgrade";
        proxy_pass        $upstream;
        proxy_redirect    off;
    }
}
````

### vite-simple/docker/nginx/Dockerfile

````dockerfile
FROM nginx:stable

COPY ./nginx/conf.d /etc/nginx/conf.d

WORKDIR /vite-simple
````

### vite-simple/docker/node/Dockerfile

````dockerfile
FROM node:lts

RUN useradd -m alex && usermod -a -G node alex

RUN npm install -g npm@latest

WORKDIR /vite-simple

USER node

````

В корне создадим `docker-compose.yml`. Он будет запускать наши контейнеры

````yaml
services:
  node-cli:
    build:
      context: docker
      dockerfile: node/Dockerfile
    volumes:
      - ./:/vite-simple
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
      - ./:/vite-simple
    command: npm run dev
    tty: true
````

Мы создали настройки docker контейнеров.

## Файлы проекта

Так как проекта как такового у нас еще нет, у нас есть некий скелет файлов которые могут быть. Все лежит в корне, но структура может быть абсолютно любой.

В качестве примера создадим файлы:

````text
├── .gitignore
├── index.html
├── main.js
├── package.json
├── testFunction.js
└── vite.config.js
````

### vite-simple/.gitignore

````text
# Logs
logs
*.log
npm-debug.log*
yarn-debug.log*
yarn-error.log*
pnpm-debug.log*
lerna-debug.log*

node_modules
dist
dist-ssr
*.local

# Editor directories and files
.vscode/*
!.vscode/extensions.json
.idea
.DS_Store
*.suo
*.ntvs*
*.njsproj
*.sln
*.sw?
````

### vite-simple/index.html

Это входная точка в приложение.

````html
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Vite simple app</title>
</head>
<body>
<div id="app"></div>
<script type="module" src="/main.js"></script>
</body>
</html>

````

### vite-simple/main.js

Это главный фаил который подключается в html

````js
import {testFunction} from "./testFunction.js";

document.querySelector('#app').innerHTML = `
  <div>
    ${testFunction()}
  </div>
`;
````

### vite-simple/package.json

Стандартные зависимости `npm`.

````json
{
  "name": "vite-simple",
  "private": true,
  "version": "0.0.0",
  "type": "module",
  "scripts": {
    "dev": "vite",
    "build": "vite build",
    "preview": "vite preview --port 80"
  },
  "devDependencies": {
    "vite": "^5.4.9"
  }
}
````

Как можно видеть у нас одна зависимость, что не может не радовать.

### vite-simple/testFunction.js

Фаил функции, их может быть несколько.

````js
export function testFunction() {
    return 'testFunctionText5';
}
````

### vite-simple/vite.config.js

Конфигурация `vite`.

````js
import { defineConfig } from 'vite'

// https://vite.dev/config/
export default defineConfig({
    server: {
        watch: {
            usePolling: true
        },
        host: true,
        strictPort: true
    },
})
````

## Makefile

Отдельно добавим главный файл `Makefile`, команды которого мы будем запускать.

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

## Запуск

Перед запуском установим зависимости.

````shell
make npm-install
````

Запускам.

````shell
make docker-up
````

Останавливаем.

````shell
make docker-down
````

Пересобираем.

````shell
make docker-build
````

После запуска проект будет доступен по адресу `127.0.0.1`.

Что примечательно `vite` идет из коробки с `hot-reload`, что делает разработку комфортной.

Еще что можно отметить, помимо `dev` режима можно быстро и просто собрать production сборку командой `npm run vite build`.

## Итог

Не вдаваясь в подробности устройства сборщика `vite` у нас получилось подготовить полноценное окружение для разработки любого проекта.

Помимо этого сюда можно прикрутить:

- `sass`
- `react`
- `vue`
- `typescript`

Эти технологии рассмотрю отдельно в соответствующих статьях.

У кого есть что добавить пишите комментарии.

[Документация по vite](https://vite.dev/guide/)


