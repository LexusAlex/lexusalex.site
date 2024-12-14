---
title: Про npm
description: >-
  Рассмотрим базовые возможности npm
author: alex
date: 2055-12-31 18:00:00 +0300
categories: [Javascript,Node.js]
tags: [npm]
---

`npm` - это менеджер пакетов `node.js`, то есть он управляет зависимостями javascript проекта.

`npm` нужен для вспомогательных вещей (зависимостей) для проекта, это могут быть css библиотеки, препроцессоры, сборщики и т.д.

## Установка

`npm` идет вместе с `node.js`.

Я не хочу захламлять компьютер вспомогательными вещами, поэтому запустим `npm` в `docker`. Это делается совсем не сложно.

Если `docker` еще не установлен, то по инструкции с официального сайта для `ununtu` [https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository](https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository) его можно поставить.

Далее в какой-нибудь папке создадим `Dockerfile` и `docker-compose.yml`, примерно с таким содержимым:

```dockerfile
FROM node:lts

RUN useradd -m alex && usermod -a -G node alex

RUN npm install -g npm@latest

WORKDIR /demo-applications/npm

USER node
```

````yaml
services:
  node-cli:
    build:
      context: docker
      dockerfile: node/Dockerfile
    volumes:
      - ./:/demo-applications/npm
````

Так же для удобства я создал `Makefile`, чтобы писать туда команды

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

Теперь если скачать образ `docker compose build --pull` и подождать пока он загрузиться, можно проверить версии `nodejs` и `npm`

````shell
docker compose run --rm node-cli npm -v # 10.9.2
docker compose run --rm node-cli node -v # v22.12.0
````

Также будем запускать и другие команды внутри контейнера.

## npm init инициализация проекта

`npm init` создает пустой `package.json`. По дефолту он выглядит так:

````json
{
  "name": "nmp",
  "version": "1.0.0",
  "main": "index.js",
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1"
  },
  "author": "",
  "license": "ISC",
  "description": ""
}

````

## npm install установка зависимостей

Зависимости в проект можно ставить по одной или несколько.

```shell
# установим библиотеку bootstrap и фреймворк next
npm install bootstrap next
```

Теперь в `package.json` появилась секция `dependencies`, в которой указаны эти зависимости:

````json
{
  "dependencies": {
    "bootstrap": "^5.3.3",
    "next": "^15.1.0"
  }
}
````

Так же создался файл `package-lock.json` - это технический файл `npm`.

В папке `node_modules` находятся сами библиотеки.

> Библиотеки можно найти на сайте [https://www.npmjs.com/](https://www.npmjs.com/)
{: .prompt-info }

Более подробно ключевые вещи мы рассмотрим ниже.

Если нужно просто скачать библиотеки, а `package.json` уже имеется, то достаточно выполнить

```shell
# просто установка всего что есть в `package.json`
npm install
```

> Важно никак не взаимодействовать с папкой `node_modules`, она генерируется автоматически
{: .prompt-info }

## npm uninstall - удаление зависимостей

Можно сразу несколько или одну зависимость проекта.

````shell
# Удалим фреймворк next
npm uninstall next
````

Эта команда удалит код зависимости из `node_modules` и запись о ней в `package.json`.

## Версионирование

Любая установленная библиотека имеет версию, они подчиняются [https://semver.org/lang/ru/](https://semver.org/lang/ru/), но эта тема отдельной статьи.

Упомянем тут, что `^`


https://doka.guide/tools/package-managers/


