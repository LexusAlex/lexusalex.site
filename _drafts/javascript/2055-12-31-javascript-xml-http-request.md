---
title: Сетевые запросы с XMLHttpRequest
description: >-
  Запросы к серверу с помощью объекта XMLHttpRequest
author: alex
date: 2055-12-31 22:40:00 +0300
categories: [Javascript,Network]
tags: [javascript,XMLHttpRequest,jquery,ajax]
image:
  path: /assets/img/posts/javascript.png
  alt: Запросы к серверу с помощью объекта XMLHttpRequest.
---

## Что это такое

XMLHttpRequest - это классический встроенный объект в браузер, который предоставляет функционал обмена данными между клиентом и сервером.

В других источниках можно встретить аббревиатуру `AJAX` (Asynchronous JavaScript and XML) по сути это то же самое.

> Существует более современный способ отправки запросов на сервер это fetch api, но как работает xhr тоже полезно
{: .prompt-info }

## Базовый запрос

Разберем базовый запрос

````javascript
let request = new XMLHttpRequest();
request.open('GET','https://dummyjson.com/posts');
request.responseType = 'json';
request.send();
request.onreadystatechange = (e) => {
    console.log(request.response);
}
````



## Плюсы и минусы XMLHttpRequest

### Плюсы 

- Асинхронность. Обмен данными с сервером происходит без перезагрузки страницы
- Экономия трафика
- Низкая нагрузка на сервер

### Минусы 

- Поисковые роботы не видят ajax контент.
- Рост сложности проекта. Нужно поддерживать, не только клиент, но и сервер.
- 


https://fruntend.com/posts/sposoby-otpravki-http-zaprosov-v-javascript
javascript-xml-http-request
