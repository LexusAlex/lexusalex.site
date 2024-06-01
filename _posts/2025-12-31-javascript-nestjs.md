---
title: Используем nestjs
author: alex
date: 2025-12-31 18:00:00 +0300
categories: [Nestjs]
---

Guards NestJS https://habr.com/ru/articles/753882/
Руководство по nest часть 1 https://habr.com/ru/companies/timeweb/articles/663234/
Руководство по nest часть 2 https://habr.com/ru/companies/timeweb/articles/666470/
Частично переведенная дока https://nestjs.ru/techniques/database
mongoose https://my-js.org/docs/guide/mongoose

Рассмотрим использование nest.js в практическом плане, без воды

## Установка

Я веду всю разработку в docker, так что ставлю не как по официальной доке.

У меня есть специальный контейнер для различных действий с кодом, дабы не захламлять систему

````dockerfile
FROM node:20

RUN useradd -m alex && usermod -a -G node alex

RUN npm install -g npm@10.8.*

WORKDIR /tasks-board/backend

USER node
````

````yaml
services:
  backend-node-cli:
    build:
      context: backend/docker/development
      dockerfile: backend-node/Dockerfile
    volumes:
      - ./:/tasks-board
````

Запускать прим этом очень просто любые команды внутри контейнера
 
````shell
docker compose run --rm backend-node-cli npm -v
````

Ставим утилиту для установки nest из коробки, она на нам потребуется только один раз, потом мы ее удалим

````shell
docker compose run --rm backend-node-cli npm i @nestjs/cli
````

Теперь установим стандартный проект

````shell
docker compose run --rm backend-node-cli ./node_modules/.bin/nest new my
````

Все файлы будут созданы в директории `new`, перекинем их на уровень выше и подчистим все лишнее
 
Какие основные файлы должны быть, здесь я заведомо не вывожу все файлы

````shell
backend/
├── nest-cli.json # Настройки для nest
├── package.json
├── package-lock.json
├── src # Исходный код
│   ├── app.controller.spec.ts
│   ├── app.controller.ts
│   ├── app.module.ts
│   ├── app.service.ts
│   └── main.ts
├── test # Тесты
│   ├── app.e2e-spec.ts
│   └── jest-e2e.json
├── tsconfig.build.json
├── tsconfig.json # Конфиг typescript
````

## Компоненты nest.js

- modules - все есть модуль, можно создавать любое кол-во модулей
- controllers - http rmq обработчик событий они относятся к модулю
- providers - Наборы доп сервисов(бизнес логика), репозиториев, они могут быть различных типов, они могут быть переиспользованы
- middleware - обратывает все входящие запросы
- guards - ограничитель
- pipes - тоже фильтр
- interceptors - тоже фильтр
- exception filters - могут вклиниваться до или после контроллера



## main.ts

Главный файл запуска приложения

````typescript
import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  await app.listen(3000);
}
bootstrap();
````

## Модуль

Все приложение состоит из модулей. У приложения должен быть хотя бы один модуль. Модули могут быть вложенными друг в друга

### Структура модуля

````typescript
@Module({
  imports: [], // Импорт других модулей
  controllers: [], // Котроллеры модуля
  providers: [], // Провайдеры, Сервисы, сущности
  exports: [] // Экспорт внешнего функционала
})
````

Мы можем создать все сущности вручную, но Cli инструмент nest дает возможность генерировать сущности. Для этого используется команда `nest generate`.
Чтобы нам было удобно это делать добавим в `package.json` в секцию `scripts` строку `"nest": "nest"`.

Теперь попробуем сгенерировать модуль. Утилита сама пропишет модуль в секции `import` модуля `app`

````shell
docker compose run --rm backend-node-cli npm run nest generate module test
````

````typescript
import { Module } from '@nestjs/common';

@Module({
  imports: []
})
export class TestModule {}
````

С таким же успехом сгенерируем еще 4 вложенных модуля.

Последняя команда у меня будет выглядеть так

````shell
docker compose run --rm backend-node-cli npm run nest generate module test/test2/test3/test4/test5
````
 
Получается такая вложенная структура

````shell
backend/src/test/
├── test2
│   ├── test2.module.ts
│   └── test3
│       ├── test3.module.ts
│       └── test4
│           ├── test4.module.ts
│           └── test5
│               └── test5.module.ts
└── test.module.ts
````

Таким образом можно создавать сколь угодно распределенную систему.

## Контроллер

Контроллер отвечает за обработку запросов и формирование ответов.

Базовая структура контроллера выглядит следующим образом

### Структура контроллера

````typescript
import { Controller, Get } from '@nestjs/common';

@Controller()
export class AppController {
  @Get("/")
  getMain():object {
    return {};
  }
}
````

Так же как со случаем с модулем, контроллер можно сгенерировать автоматически

````shell
docker compose run --rm backend-node-cli npm run nest generate controller test/test
````
 
Контроллер умеет работать с Request и Response через декораторы

Например, получим запрос и вернем текущий url

````typescript
import {Controller, Get, Req} from '@nestjs/common';

@Controller('test')
export class TestController {
  @Get("/")
  async main(@Req() req: Request) : Promise<{url:string}> {
    return {url: req.url};
  }
}
````

## Конфигурация
 
Нужно научить nest работать файлами `.env`, для этого поставим пакет.

Хотя мы работаем в docker, который очень удобно позволяет работать, полезно знать как это делать

```shell
docker compose run --rm node-cli npm i --save @nestjs/config
#  На май 2024 версия 3.2.2
```

### Подключение штатным образом

Подключим в глобальный модуль, тем самым укажем что нужно парсить файлы с переменными окружения

````typescript
@Module({
  imports: [
    ConfigModule.forRoot()
  ],
  controllers: [AppController],
  providers: [AppService],
})
````

Создадим в корне проекта фаил `.env` с переменными окружения

````
TEST=12345
````

Используем 

````typescript
@Controller()
export class AppController {
  constructor(private configService: ConfigService) {
  }

  @Get('/')
  async get() {
    return {result: this.configService.get<string>("TEST")}
  }
}
````

### Подключение через docker

Здесь все проще, в файле `docker-compose-prod.yml`, добавляем переменные окружения

````yaml
environment:
      NODE_ENV: development
      MY_TEST: 75765643456456456
````

Используем

````typescript
@Controller()
export class AppController {
  constructor(private configService: ConfigService) {
  }

  @Get('/')
  async get() {
    return {result: this.configService.get<string>("MY_TEST")}
  }
}
````

### production and development

Расписать что и как делать

### Декораторы

https://habr.com/ru/companies/docsvision/articles/310870/

### Fastify или express

https://www.unix-lab.org/posts/nestjs-start/
https://evogeek.ru/articles/93891/

````shell
docker compose run --rm node-cli npm i --save @nestjs/platform-fastify
````

### Коды ответов

## Интеграции

Nest не привязан не к какой базе данных, можно ставить любую

### MongoDb

Неплохо бы разобрать в кратце как работать с mongoose

````shell
npm i @nestjs/mongoose mongoose
# На май 2024 mongoose 8.3.4 @nestjs/mongoose 10.0.6
````
### TypeORM
### Prisma

## Авторизация

https://www.youtube.com/watch?v=W8ihgD7zvMA
