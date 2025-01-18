---
title: async/await в javascript
description: >-
  Управление зависимостями в экосистеме javascript
author: alex
date: 2055-06-08 22:40:00 +0300
categories: [Javascript,Collections]
tags: [js,set,map]
image:
  path: /assets/img/posts/main/javascript.png
  alt: Зависимости в экосистеме javascript
---

Продолжаем исследовать ассинхронный javascript.  

В статье про [`Promises`](https://lexusalex.site/posts/javascript-promises/) мы уже затрагивали синтаксис `async/await`, сегодня рассмотрим его подробнее.

Как можно было заметить использование `Promises` имеет сложный синтаксис. 

Чтобы облегчить работу с `Promises` появились асинхронные функции с синтаксисом `async/await`.

## Асинхронно/Синхронно

Напомним, что код может выполняться в двух режимах

- `синхронно` - мы ждем пока эта часть кода будет выполнена прежде чем перейти другой.
- `асинхронно` - мы напротив, не ждем выполнения весь код выполняется сразу же.

Например, у нас есть три вызова `fetch` и три `console.log`.

````javascript
console.log(1);
fetch('https://fakerapi.it/api/v2/texts?_quantity=100&_characters=500&_locale=ru_RU').then((r) => console.log(2));
fetch('https://fakerapi.it/api/v2/texts?_quantity=100&_characters=500&_locale=ru_RU').then((r) => console.log(3));
console.log(4);
console.log(5);
fetch('https://fakerapi.it/api/v2/texts?_quantity=100&_characters=500&_locale=ru_RU').then((r) => console.log(6));
````

В момент запуска скрипта все функции `fetch` начнут выполняться одновременно, то есть **асинхронно**. И какая их них когда закончит свое выполнение непонятно.

Синхронный код выполняется в обычном потоке. Результаты будут следующие.

````text
1 1 1
4 4 4
5 5 5
6 3 2
2 2 3
3 6 6
````

Последние три цифры в каждом прогоне, это результаты выполннения асинхронных `fetch`. Его мы не можем предсказать, так как ответ от сервера на запросы может прийти не одновременно. 

Иногда это может мешать. Чтобы как то этим управлять появился синтаксис `async/await`

## async

Для того чтобы сделать асинхронную функцию, нужно поставить перед функцией ключевое слово `async`. Такая функция будет всегда возвращать `Promise`.

````javascript
async function test() {}
console.log(test()); // Promise { <state>: "fulfilled", <value>: undefined }
````

Функция ничего не делает, но при этом возвращает разрешенный `Promise` с пустым значением. Любое возвращаемое значение будет обернуто в `Promise`.

Вот здесь мы вернем массив:

````javascript
async function test() {
    return [123];
}

// Это просто Promise
console.log(test()); // Promise { <state>: "fulfilled", <value>: (1) […] }
// А это уже результат
test().then((val) => console.log(val)); // Array [ 123 ]
````

https://frontend-stuff.com/blog/javascript-async-await/
https://www.dev-notes.ru/articles/javascript/async-await-guide/
https://learn.javascript.ru/async-await
https://ru.hexlet.io/courses/js-sync/lessons/async-await/theory_unit
