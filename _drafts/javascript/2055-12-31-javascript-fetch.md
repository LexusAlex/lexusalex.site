---
title: Сетевые запросы с fetch в javascript
description: >-
  Отправляем запросы на сервер с помощью fetch
author: alex
date: 2055-11-03 15:20:00 +0300
categories: [Javascript,Asynchronous]
tags: [js,promise,fetch]
image:
  path: /assets/img/posts/main/javascript-promises.jpeg
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: Сетевые запросы с fetch в javascript
---

## fetch

В продолжении темы про [`Promises`](https://lexusalex.site/posts/javascript-promises/), теперь рассмотрим `fetch`.

`Fetch` - это современный способ послать и получить запрос с сервера.

`fetch` принимает два параметра url запроса и настройки запроса и возвращает `Promise` со специальным объектом `Response`.

Если сходу попробовать отправить запрос на несуществующий url, то ответ будет вполне ожидаемым. В ответе будет `Promise` и ошибка, что адреса нет.

````javascript
fetch('123123213'); // Promise { <state>: "pending" } 404 not found
fetch('https://jsonplaceholder.typicode.com/fake'); // Promise { <state>: "pending" } 404 not found
````

Теперь отправим корректный запрос, например на сервис `https://jsonplaceholder.typicode.com` или любой другой.

````javascript
let request = fetch('https://jsonplaceholder.typicode.com/posts');
console.log(request); //Promise { <state>: "fulfilled" }
request.then(response => {console.log(response)}); //Response { type: "cors", url: "https://jsonplaceholder.typicode.com/posts", redirected: false, status: 200, ok: true, statusText: "", headers: Headers(4), body: ReadableStream, bodyUsed: false }
````

Или на другой сервис, разницы нет.

````javascript
let request = fetch('https://fakerapi.it/api/v2/texts?_quantity=100&_characters=500&_locale=ru_RU');
request.then(response => {console.log(response.json())}); //Response { type: "cors", url: "https://fakerapi.it/api/v2/texts?_quantity=100&_characters=500&_locale=ru_RU", redirected: false, status: 200, ok: true, statusText: "", headers: Headers(4), body: ReadableStream, bodyUsed: false }
````

Получаем как ни странно, тоже `Promise` с `value` объект `Response`, после его обработки получаем объект `Response`, но просто так вытащить оттуда данные не получиться, так как ответ это тоже `Promise`.

Обрабатываем второй раз `Promise`. И вот тогда наконец, достучимся до результата.

````javascript
let request = fetch('https://fakerapi.it/api/v2/texts?_quantity=100&_characters=500&_locale=ru_RU');

request
    .then(response => {return response.json()})
    .then((json) => {
      // Получается, что тут мы должны добавлять что-то в DOM либо сохранять куда то, здесь у нас есть данные.
      console.log(json.data)}
    ); // [] - Массив результата
````

Следующий вопрос, как обротать ошибки, например вернуть результат если что-то не найдено.

`catch` для это не пойдет, так как `Promise` по умолчанию разрешен, то есть мы попадаем в `then`. Там и нужно обрабатывать ошибки. Но не все так очевидно `catch`, нам все-таки понадобиться.

````javascript
// Запрос на несущесвующий адрес
let request = fetch('https://fakerapi.it/api/v3/texts?_quantity=100&_characters=500&_locale=ru_RU');

request
    .then(response => {
        // Обрабобка если что-то пошло не так
        if (!response.ok) {
            // Выбрасываем исключение
            throw Error('что-то пошло не так');
        }
        console.log(response);
        return response.json()
    })
    .then((json) => {console.log(json.data)})
    // Здесь успешно его перехватываем
    .catch((error) => {
        console.error(error.message)})
````




https://www.youtube.com/watch?v=klVGCxWsN2A&t=344s


https://learn.javascript.ru/fetch
https://doka.guide/js/fetch/
https://developer.mozilla.org/ru/docs/Web/API/Window/fetch
