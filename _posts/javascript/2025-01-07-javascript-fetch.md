---
title: Запросы и ответы с fetch в javascript
description: >-
  Работаем с запросами и ответами с сервера с помощью fetch api
author: alex
date: 2025-01-07 18:30:00 +0300
categories: [Javascript,Asynchronous]
tags: [js,promise,fetch]
image:
  path: /assets/img/posts/main/javascript-fetch.png
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: Сетевые запросы с fetch в javascript
---

## fetch

В продолжении темы про [`Promises`](https://lexusalex.site/posts/javascript-promises/), теперь рассмотрим `fetch`.

`Fetch` - это современный способ послать и получить запрос с сервера.

`fetch` принимает два параметра `url` запроса и настройки запроса и возвращает `Promise` со специальным объектом `Response`. 

Ранее для этой цели использовался объет `XMLHttpRequest`.

Если сходу попробовать отправить запрос на несуществующий `url`, то ответ будет вполне ожидаемым. 

В ответе будет `Promise` и ошибка, что адреса нет.

````javascript
fetch('123123213'); // Promise { <state>: "pending" } 404 not found
fetch('https://jsonplaceholder.typicode.com/fake'); // Promise { <state>: "pending" } 404 not found
````

Теперь отправим корректный запрос, на любой сервис или сервер, который может дать ответ

Я буду использовать сервисы:

- [https://jsonplaceholder.typicode.com/](https://jsonplaceholder.typicode.com/)
- [https://fakerapi.it](https://fakerapi.it)
- [https://dummyjson.com/](https://dummyjson.com/)


> Если ничего не указать запрос по умолчанию будет методом GET
{: .prompt-info }

````javascript
let request = fetch('https://jsonplaceholder.typicode.com/posts');
console.log(request); //Promise { <state>: "fulfilled" }
// Объект Response
request.then(response => {console.log(response)}); //Response { type: "cors", url: "https://jsonplaceholder.typicode.com/posts", redirected: false, status: 200, ok: true, statusText: "", headers: Headers(4), body: ReadableStream, bodyUsed: false }
````

Отправим запрос и сразу же его обработаем.

> В качестве ответа fetch возвращает объект Response
{: .prompt-info }

````javascript
let request = fetch('https://fakerapi.it/api/v2/texts?_quantity=100&_characters=500&_locale=RU_ru');
request.then(response => {console.log(response.json())});
// Response { type: "cors", url: "https://fakerapi.it/api/v2/texts?_quantity=100&_characters=500&_locale=ru_RU", redirected: false, status: 200, ok: true, statusText: "", headers: Headers(4), body: ReadableStream, bodyUsed: false }
````

Получаем как ни странно, тоже `Promise` с `value` с объектом `Response`, после его обработки получаем объект `Response`.
 
Но просто так вытащить оттуда данные не получиться, так как ответ это тоже `Promise`.

Обрабатываем второй раз `Promise`. И вот тогда наконец, достучимся до результата.

````javascript
let request = fetch('https://fakerapi.it/api/v2/texts?_quantity=100&_characters=500&_locale=ru_RU');

request
  .then(response => {
    // Объект Response предоставляет метод json
    // Здесь response.json() promise;
    return response.json()
  })
  // Дообрабатываем его 
  .then(json => {
    // Наконец получаем массив результата
    // Здесь мы можем работать с DOM, куками, обрабатывать результат
    console.log(json.data); // []
  })
````

## Эксперименты с несколькими запросами

Теперь когда мы научились отправлять запросы и получать ответ, поэкспериментируем с несколькими запросами.

Сделаем 5 функций, которые будут отправлять запрос, и обработаем его.

````javascript
function request(){
    console.log('request')
    return fetch('https://fakerapi.it/api/v2/texts?_quantity=100&_characters=500&_locale=ru_RU');
}
function request2(){
    console.log('request2')
    return fetch('https://fakerapi.it/api/v2/texts?_quantity=100&_characters=500&_locale=ru_RU');
}
function request3(){
    console.log('request3')
    return fetch('https://fakerapi.it/api/v2/texts?_quantity=100&_characters=500&_locale=ru_RU');
}
function request4(){
    console.log('request4')
    return fetch('https://fakerapi.it/api/v2/texts?_quantity=100&_characters=500&_locale=ru_RU');
}
function request5(){
    console.log('request5')
    return fetch('https://fakerapi.it/api/v2/texts?_quantity=100&_characters=500&_locale=ru_RU');
}

request()
  .then(response => { return response.json()})
  .then(json => { console.log('request');console.log(json.data);})
request2()
  .then(response => { return response.json()})
  .then(json => { console.log('request2');console.log(json.data);})
request3()
  .then(response => { return response.json()})
  .then(json => { console.log('request3');console.log(json.data);})
request4()
  .then(response => { return response.json()})
  .then(json => { console.log('request4');console.log(json.data);})
request5()
  .then(response => { return response.json()})
  .then(json => { console.log('request5');console.log(json.data);})
````

Казалось бы, запросы идут друг за другом, что и выводится в консоль в начале

````text
request
request2
request3
request4
request5
````

Но при обработке, `console.log` показывает каждый раз разный результат.

Я запустил несколько раз и результаты получились такие:

````text
request2
request4
request3
request5
request

request
request5
request4
request2
request3

request
request3
request2
request5
request4
````

Так получается, потому что запросы на сервер поступают ассинхронно все сразу, и им для выполнения нужно разное время. Как только запрос выполнился ответ, пришел.

Можно загнать все в одну функцию:

````javascript
function requests() {
  console.log('request');
  fetch('https://fakerapi.it/api/v2/texts?_quantity=100&_characters=500&_locale=ru_RU')
    .then(response => {
      return response.json()
    })
    .then(json => {
      console.log('request')
    });
  console.log('request2');
  fetch('https://fakerapi.it/api/v2/texts?_quantity=100&_characters=500&_locale=ru_RU')
    .then(response => {
      return response.json()
    })
    .then(json => {
      console.log('request2')
    });
  console.log('request3');
  fetch('https://fakerapi.it/api/v2/texts?_quantity=100&_characters=500&_locale=ru_RU')
    .then(response => {
      return response.json()
    })
    .then(json => {
      console.log('request3')
    });
  console.log('request4');
  fetch('https://fakerapi.it/api/v2/texts?_quantity=100&_characters=500&_locale=ru_RU')
    .then(response => {
      return response.json()
    })
    .then(json => {
      console.log('request4')
    });
  console.log('request5');
  fetch('https://fakerapi.it/api/v2/texts?_quantity=100&_characters=500&_locale=ru_RU')
    .then(response => {
      return response.json()
    })
    .then(json => {
      console.log('request5')
    });
}    
requests();
````

Но результат от этого не поменяется.

````text
request
request2
request3
request4
request5
request
request3
request5
request2
request4
````

Как же нам обработать эти запросы последовательно.

Воспользуемся синтаксисом `async/await`, в отдельной функции

````javascript
async function requests(){
    console.log('request');
    const response1 = await fetch('https://fakerapi.it/api/v2/texts?_quantity=100&_characters=500&_locale=ru_RU');
    const data1 = await response1.json();
    console.log('request');

    console.log('request2');
    const response2 = await fetch('https://fakerapi.it/api/v2/texts?_quantity=100&_characters=500&_locale=ru_RU');
    const data2 = await response2.json();
    console.log('request2');

    console.log('request3');
    const response3 = await fetch('https://fakerapi.it/api/v2/texts?_quantity=100&_characters=500&_locale=ru_RU');
    const data3 = await response3.json();
    console.log('request3');

    console.log('request4');
    const response4 = await fetch('https://fakerapi.it/api/v2/texts?_quantity=100&_characters=500&_locale=ru_RU');
    const data4 = await response4.json();
    console.log('request4');

    console.log('request5');
    const response5 = await fetch('https://fakerapi.it/api/v2/texts?_quantity=100&_characters=500&_locale=ru_RU');
    const data5 = await response5.json();
    console.log('request5');
}

requests();
````

В результате в ответе получаем последовательное выполнение каждого запроса, так как нам и нужно.

````text
request
request
request2
request2
request3
request3
request4
request4
request5 
request5
````

Еще неплохой способ создания нескольких запросов сразу использование `Promise.all`.

Результат будет возвращен в виде массива.

````javascript
async function requests2()
{
    // Готовим запросы
    let url = 'https://fakerapi.it/api/v2/texts?_quantity=99&_characters=500&_locale=ru_RU';
    let url2 = 'https://fakerapi.it/api/v2/texts?_quantity=100&_characters=500&_locale=ru_RU';
    let url3 = 'https://fakerapi.it/api/v2/texts?_quantity=101&_characters=500&_locale=ru_RU';
    let url4 = 'https://fakerapi.it/api/v2/texts?_quantity=102&_characters=500&_locale=ru_RU';
    let url5 = 'https://fakerapi.it/api/v2/texts?_quantity=103&_characters=500&_locale=ru_RU';

    const responses = await Promise.all([fetch(url), fetch(url2),fetch(url3),fetch(url4),fetch(url5)]);

    // Выводим результат
    const data1 = await responses[0].json();
    console.log(data1.total);
    const data2 = await responses[1].json();
    console.log(data2.total);
    const data3 = await responses[2].json();
    console.log(data3.total);
    const data4 = await responses[3].json();
    console.log(data4.total);
    const data5 = await responses[4].json();
    console.log(data5.total);
}

requests2();
````

Здесь в ответах, чтобы их отличать, я поменял `GET` параметр, где его буду получать в ответе.

При этом порядок передачи `Promise` тут важен, в этом же порядке будет ответ.

Про дополнительные методы `Promise`, будет отдельная статья.

````text
99
100
101
102
103
````

Можно делать зависимые запросы, здесь думаю, проблем не должно быть.

> Важно на что нужно обращать внимание!
> 
> Результат из функции которая возвращает Promise нельзя получить по определению, такова природа асинхронных функций.
> Его нужно обязательно обработать с помощью then или await
{: .prompt-info }

## Обработка ошибок запроса

Все хорошо, но результат не всегда положительный, бывают ошибки.

Следующий вопрос, как обротать ошибки, например вернуть результат если что-то не найдено.

`catch` для это не пойдет, так как `Promise` по умолчанию разрешен, то есть мы попадаем в `then`. Там и нужно обрабатывать ошибки. 

Но не все так очевидно.

Делаем запрос на несуществующий адрес

````javascript
fetch('https://fakerapi.it/api/v2/ertretretretrtret')
    .then(response => {
        console.log(response);
})

// Попадаем сразу в then, получаем ошибку 404 что адреса нет и объект response со статусом 404
````

Но как то непонятно почему мы попали в `then`, попробуем разобраться.

Здесь важно понимать два понятия:

- Запрос успешно достиг сервера
- Ответ от сервера успешно пришел

### Запрос успешно достиг сервера

Если запрос был отправлен и успешно достиг сервера, с точки зрения `fetch` задача выполнена.

````javascript
fetch('https://fakerapi.it/api/v2/ertretretre')
    .then(response => {
       // Запрос успешно достиг сервера, но в ответе 404
      // И тут у нас такое сообщение Response.json: Body has already been consumed.
        return response.json()
    })
    .catch((error) => {
      // До сюда мы так и не дошли, проверки нужно делать в then
        console.log(error.message)
    })
````

Но если адрес будет не валидный в `catch` мы все-такие попадаем

````javascript
fetch('апрпарппара')
    .then(response => {
        console.log(response); // Response есть всегда
        return response.json()
    })
    .catch((error) => {
        // Не можем распарсить json
        console.log(error.message) // JSON.parse: unexpected character at line 1 column 1 of the JSON data
    })
````

### Ответ от сервера успешно пришел

Сервер может вернуть ответ со статусами `200,404,500,403` и другими, при этом в `catch` это все не попадает, так как запрос успешно достиг сервера.

Вот почему нужно проверять ответ в `then`.

Выполним успешный и неуспешный запрос к серверу

````javascript
fetch('https://dummyjson.com/http/200')
    .then(response => {
        console.log(response.ok);
        console.log(response.status);
        console.log(response.statusText);
        /*
        true
        200
        OK
         */
        return response.json()
    })
    // До сюда мы по прежнему не дойдем
    .catch((error) => {
        console.log(error.message)
    })

fetch('https://dummyjson.com/http/500')
  .then(response => {
    console.log(response.ok);
    console.log(response.status);
    console.log(response.statusText);
    return response.json()
    /*
    false
    500
    Internal Server Error
     */
  })
  // До сюда мы по прежнему не дойдем
  .catch((error) => {
    console.log(error.message)
  })
````

Все дело в том, что в `catch` попадут только исключения, а статус `404`, и `500` это просто статус.

Как тут правильно поступить, нужно выбросить исключение в `then`. Примерно так:

````javascript
fetch('https://dummyjson.com/http/404')
    .then(response => {
        if(!response.ok) {
            throw new Error(`Произошла ошибка: ${response.statusText} - ${response.status}`)
        }
        return response.json()
    })
    .catch((error) => {
        // Произошла ошибка: Not Found - 404
        console.log(error.message) // Перехват произойдет здесь
    })
````

Вот теперь лучше, мы обрабатываем ошибки сервера.

> catch обрабатывает только исключения, ответы сервера такие как 404,500 нужно обработать вручную и выбросить исключение в then
{: .prompt-info }

> Значение response.ok == true только для статусов ответа сервера в диапазоне 200-299, для остальных оно равно false
{: .prompt-info }

Полный пример, пока у нас выглядит так

````javascript
fetch('https://fakerapi.it/api/v2/texts?_quantity=100&_characters=500&_locale=ru_RU')
    .then(response => {
        if(!response.ok) {
            throw new Error(`Произошла ошибка: ${response.statusText} - ${response.status}`)
        }
        return response.json()
    })
    .then(json => {
        // Какая-то работа с ответом
        console.log(json.data)
    })
    .catch((error) => {
        // Произошла ошибка: Not Found - 404
        console.log(error.message)
    })
````

Усложним наши примеры. Например, вернем последние коммиты из репозитория `php`.

````javascript
fetch('https://api.github.com/repos/php/php-src/commits')
    .then(response => {
        if(!response.ok) {
            throw new Error(`Произошла ошибка: ${response.statusText} - ${response.status}`)
        }
        return response.json()
    })
    .then(json => {
        // Какая-то работа с ответом
        console.log(json) // Ответ
    })
    .catch((error) => {
        // Произошла ошибка: Not Found - 404
        console.log(error.message)
    })
````

Подсократим запись на синтаксис `async/await`

````javascript
async function test(){
    let response = await fetch('https://api.github.com/repos/php/php-src/commits');
    if(!response.ok) {
        throw new Error(`Произошла ошибка: ${response.statusText} - ${response.status}`)
    }
    console.log(await response.json());
}

test();
````

Далее рассмотрим нюансы использования.

## Строка в качестве ответа

Чаще всего ответ нужен в `json`, но его можно вернуть как текст в виде строки, для этого воспользуемся `response.text()`.

````javascript
async function test(){
    let response = await fetch('https://api.github.com/repos/php/php-src/commits');
    if(!response.ok) {
        throw new Error(`Произошла ошибка: ${response.statusText} - ${response.status}`)
    }
    console.log(await response.text());
}

test();
````

> Можно выбрать только один метод чтения ответа.
{: .prompt-info }

## Файл в качестве ответа

Так же с помощью `fetch` можно сохранить фаил с сервера. Все зависит от задачи, но представим, что нужно сохранить файл на компьютер.

Чтобы эмулировать сохранение файла, напишем вспомогательную функцию, которая будет сохранять файл на компьютер, некая эмуляция ссылки и клика по ней.

````javascript
function saveFile(url, filename) {
    const a = document.createElement("a");
    a.href = url;
    a.download = filename || "file-name";
    document.body.appendChild(a);
    a.click();
    document.body.removeChild(a);
}
````

Для работы с бинарными файлами есть метод `response.blob()`, он нам и пригодится.

````javascript
fetch('https://dummyjson.com/image/1000x1000/008080/ffffff?text=Lexusalex!&fontSize=55')
    .then(response => response.blob()) 
    .then(blob => {
        // уникальный url для бинарного объекта
        let url = URL.createObjectURL(blob);
        // сохранение файла
        saveFile(url, "image");
        // удаление ссылки на бинарный объект
        window.URL.revokeObjectURL(url);
        //console.log('Fetched image blob:', blob);
    })
````

То есть где, то на сервере есть изображение, мы его берем как бинарный фаил преобразуем в изображение и сохраняем на компьютер.

## Заголовки

### Ответ

Можно получить доступ к заголовкам ответа через `response.headers` - это объект с заголовками ответа

````javascript
fetch('https://api.github.com/repos/php/php-src/commits')
    .then(response => {
        if(!response.ok) {
            throw new Error(`Произошла ошибка: ${response.statusText} - ${response.status}`)
        }
        console.log(response.headers); // Заголовки
        return response.json()
    })
    .then(json => {
        // Какая-то работа с ответом
        console.log(json)
    })
    .catch((error) => {
        console.log(error.message)
    })
````

Объект заголовков ответа будет выглядеть примерно так.

````text
Headers(12) { "cache-control" → "public, max-age=60, s-maxage=60", "content-type" → "application/json; charset=utf-8", etag → 'W/"ad760697e9057cb61ad4e964f8726f33d7a490c4c565cc2a6ba98f3e1e522450"', "last-modified" → "Tue, 07 Jan 2025 09:20:36 GMT", link → '<https://api.github.com/repositories/1903522/commits?page=2>; rel="next", <https://api.github.com/repositories/1903522/commits?page=4666>; rel="last"', "x-github-media-type" → "github.v3; format=json", "x-github-request-id" → "26C2:3E0C3E:2909D61:29F16C9:677D3575", "x-ratelimit-limit" → "60", "x-ratelimit-remaining" → "58", "x-ratelimit-reset" → "1736262472", … }
````

### Запрос

Так же есть возможность установить заголовки запроса, например

````javascript
fetch('https://api.github.com/repos/php/php-src/commits',{
   // Здесь можно установить заголовки запроса
    headers: {
        'Content-Type': 'application/xml'
    }
})
    .then(response => {
        if(!response.ok) {
            throw new Error(`Произошла ошибка: ${response.statusText} - ${response.status}`)
        }
        return response.json()
    })
    .then(json => {
        // Какая-то работа с ответом
        console.log(json)
    })
    .catch((error) => {
        console.log(error.message)
    })
````

## Добавление данных методом POST

До этого момента мы отправляли данные методом `GET`, `fetch` так же умеет отправлять данные и другими методами, посмотрим на метод `POST`.

````javascript
fetch('https://dummyjson.com/products/add', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({
        title: 'Новая запись',
    })
})
    .then(res => res.json())
    .then(console.log);
````

Ответ в данном пример будет возвращен со статусом `201` - ресурс создан.

## Обновить данные методом PUT или PATCH

Теперь обновим ресурс используя метод `PUT`.

````javascript
fetch('https://dummyjson.com/products/77', {
    method: 'PUT',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({
        title: 'Новое название'
    })
})
    .then(res => res.json())
    .then(console.log);
````

или `PATCH`

````javascript
fetch('https://dummyjson.com/products/77', {
    method: 'PATCH',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({
        title: 'Новое название'
    })
})
    .then(res => res.json())
    .then(console.log);
````

На сервере с фейковыми данными оба метода возвращают одно и тоже, это так настроено.

## Удалить объект методом DELETE

Ну и попробуем удалить ресурс методом `DELETE`.

````javascript
fetch('https://dummyjson.com/products/1', {
    method: 'DELETE',
})
    .then(res => res.json())
    .then(console.log);
````

## Что в итоге

`fetch` сейчас это мощный инструмент для отправки и получения запросов по сети, он предоставляет простой и гибкий способ работы с запросами ответами.

Мы рассмотрели основные варианты использование `fetch`. 

Некоторые темы мы не затронули, они будут рассмотрены позднее.

Есть вопрос или дополнение к статье, пишите [https://t.me/lexus7alex](https://t.me/lexus7alex)
