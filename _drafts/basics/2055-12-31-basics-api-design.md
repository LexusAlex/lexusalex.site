---
title: Запросы и ответы api
description: >-
  Как писать запросы и ответы api
author: alex
date: 2055-12-31 18:00:00 +0300
categories: [Basics]
tags: [api]
---

## REST API

По сути `REST API` - это набор правил и соглашений для создания веб-сервисов и доступов к ним.

> Это не означает, что REST API, что-то великое и истина в последней инстанции, а всего лишь набор лучших практик
{: .prompt-info }

## Методы


## GET

Получение данных с сервера без их изменения.

### Особенности

Указывается точка, ресурс к которому мы хотим получить доступ, например

- `/users` - пользователи
- `/animals` - животные
- `/books` - книги

Параметры, это значения которые мы передаем в адресной строке после `?`. 
Они позволяют фильтровать, сортировать, формировать данные, которые мы в итоге получим.

К примеру

- `/users?sort=date_created&max=today`
- `/books?sort=date_created,year&text_search=sdfdgert`

Должна быть заложена определенная логика работы по ресурсу, например по ресурсу `/books`, методом `GET` мы должны возвращать список книг в формате `JSON` с определенными фильтрами.

В итоге будет ответ, который отдаст сервер в определенном формате, сейчас это преимущественно `JSON`.

В большинстве случаев у нас есть основная сущность и уровень зависимости, чаще всего это идентификатор чего-либо.

### Заявки и клиенты

Рассмотрим вариант как можно сформировать url, получающий все заявки клиента.

- `/applications/1/clients` - имеет место, но не удобен
- `/clients?applications=1` - уже лучше, более предпочитаемый вариант

> Важно понимать, что связь между родительским и дочерним не фильтр, а именно зависимость. Если это фильтр тогда имеет место вынести в GET параметры.
{: .prompt-info } 

### Про Get параметры

Для передачи параметров запросу используются `GET` параметры. (Есть `GET body`, но об этом я не знаю ничего).

Что можно про них сказать это строка в формате `param1=value1&param2=value2`, но эта строка не бесконечна, не рекомендуют использовать строку более 2048 символов.

Сложные параметры можно просто передавать в виде строки. Ну и так, как тут нет состояния они могут храниться в истории браузера. 

### Сортировка ответа

Здесь два параметра

- поле по которому сортировать, например `NUMBER`, `YEAR`, `PRICE`
- порядок, например `ASC`, `DESC`

Поле сортировки: 

- `sort`
- `sortBy`

Порядок:

- `order`
- `sortDirection`

Получаем примерно такой запрос. Книги автора отсортированные по году в обратном порядке.

`/books?sort=YEAR&order=DESC&author_id=1234`

> Обратим внимание технические значения пишем в верхнем регистре, хоть это и не обязательно.
{: .prompt-info }

Какая может быть ошибка, когда пишут в названии параметра-фильтра само название, а не его идентификатор:

`/client?id=Иванов Петр`, а нужно `/client?id=1234`

Так делать не правильно.

### Множественный выбор

Но у нас может быть задача выбора нескольких значений

`/clients?applications=1,5,6,890`.

Главная, чтобы серверная часть приложения умела так обрабатывать запросы.

Тогда доработаем пример с книгами

`/books?sort=YEAR&order=DESC&statuses=5,8,9,0&authors_id=1234,556,789,3452`

Книги авторов, определенных статусов, отсортированных по году в обратном порядке.

### Что вернем

Вернем мы ответ в виде `JSON`.

Здесь лучше всего сформировать удобную правильную структуру, и разбить данные на группы

````json5
[
  {
    "id": "123",
    "type": "RTYU",
    "status": {
      "type": 1
    },
    "authors": [
      {
        "name": "Вася",
        "login": "123"
      },
      {
        "name": "Петя",
        "login": "76678"
      },
    ]
  }
]
````

> Главное в именовании придерживаться единому стилю и структурировать информацию.
{: .prompt-info }


## Коды ответов


https://habr.com/ru/articles/739808/
https://habr.com/ru/articles/770226/
Проектирование api rest GET

https://habr.com/ru/companies/X5Tech/articles/798681/

https://wiki.merionet.ru/articles/15-vazhnejshih-rekomendacij-po-proektirovaniyu-rest-api
