---
title: Typescript в примерах
description: >-
  Рассмотрим основы типизации или как начать использовать typescript уже сегодня.
author: alex
date: 2055-12-31 18:00:00 +0300
categories: [Javascript,Typescript]
tags: [typescript]
image:
  path: /assets/img/posts/main/typescript.png
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: Typescript в примерах
---

## Что это такое

По сути `typescript` - это расширение `javascript` с проверкой типов на соответствие.

## Как запускать примеры

Запускать примеры можно в `docker`, как самый простой способ.

Для этого как ни странно нужен только `docker`.

Создадим где-нибудь в папке `Dockerfile`.

````dockerfile
FROM node:lts

RUN useradd -m alex && usermod -a -G node alex

RUN npm install -g npm@latest

WORKDIR demo-applications/ts-5

USER node
````

и `docker-compose.yml` файл.

````yaml
services:
  cli:
    build:
      context: docker
      dockerfile: node/Dockerfile
    volumes:
      - ./:/demo-applications/ts-5
````

Собираем:

````shell
docker compose build --pull
````

Устанавливаем `typescript`:

````shell
docker compose run --rm cli npm install typescript
````

Прописываем вызов компилятора `ts` и другие в секции `scripts` в `package.json`:

````json
{
  "name": "ts",
  "version": "1.0.0",
  "description": "",
  "main": "index.js",
  "type": "module",
  "scripts": {
    "init": "tsc --init",
    "version": "tsc --version",
    "compile": "tsc"
  },
  "dependencies": {
    "typescript": "^5.7.2"
  }
}
````

Генерируем конфигурационный файл:

````shell
docker compose run --rm cli npm run init
````

После этого уже можно работать, например так.

Создаем файл с расширением `.ts`, и запускаем его в консоли 

````shell
docker compose run --rm cli npm run compile src/examples/check.ts
````

## Базовый пример

Посмотрим на пример, и запустим его

````typescript
let one = 1000;
one = "1234";
````

После запуска получим ошибку ` error TS2322: Type 'string' is not assignable to type 'number'.`, это говорит о том что `ts` понял, что мы в переменную с числом подставили строку, о чем и говорит ошибка.

`Typescript` пытается сам определить тип без его аннотации.

## Аннотация типа

Аннотация типа позволяет явно указать какие типы следует ожидать. Как это сделано, например в `php` 

````php
private Id $id;
````

Мой редактор подсказывает, а `typescript` сам определяет типы за нас.

![img-description](/assets/img/posts/javascript/typescript/ts-1.png){: .shadow }
_Как мой редактор подсвечивает примерный тип_

Аннотации позволяют указывать места где необходимо проверять тип, но не стоит это делать бездумно.

Например, в объекте типы определяют так:

````typescript
type T = {
    name: string,
    age: number
}

let Test: T = {
    name: 'Вася',
    age: 123
}
````

И любое несоответствие типов, либо отсутствие значения в типе, будет вызывать ошибку.

Добавляйте аннотации там, где **нужна** проверка типов.

## Тип any

`any` используется там, где нужно отключить проверку типа.

````typescript
let array: any = [];
let str: any = '';
````

`any` снижает безопасность кода, ide не будет подсказывать варианты использования

Типы `any` отключают реакцию модуля проверки TypeScript.

Они могут маскировать реальные проблемы, вредить разработчику и подрывать его уверенность в системе типов.

По возможности нужно избегать их применения.

Но есть моменты, когда `any` может быть полезен

- Если ошибок и неявной информации очень много, что поможет перейти постепенно на более строгий код.
- Сторонние зависимости без `ts`, тут нужно не бороться с типами, а использовать `any`.
- Есть код который в `javascript` работает иначе чем в `typescript`, также можно на время отключить проверку типа.

## Тип unknown

Тип `unknown` не позволяет делать ничего.

Такой код выдает ошибку, так как в `number` нельзя присвоить `unknown`

````typescript
let i: unknown = 1;
let t: number = i;
//Type 'unknown' is not assignable to type 'number'.
````

Делаем вывод, что это происходит на этапе проверки типа.

Если приложение работает с большим кол-вом типов, `unknown` помогает убедися, что можно переносить значение по коду, в отличие от `any`.

## Структура типов ts

Типы делятся на примитивные и составные.

Примерно эта иерархия выглядит так

- any/unknown
  - Примитивные типы
      - number
        - number enum
      - string
        - string enum
      - boolean
        - symbol
        - unique symbol
        - bigint
    - Составные
      - object
        - array
          - tuple
        - class
        - regexp
        - function
    - null
    - void
    - never






