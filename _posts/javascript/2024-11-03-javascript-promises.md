---
title: Promises в javascript
description: >-
  Основы promises в javascript
author: alex
date: 2024-11-03 15:20:00 +0300
categories: [Javascript,Asynchronous]
tags: [js,promise]
image:
  path: /assets/img/posts/main/javascript-promises.jpeg
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: Основы promises в javascript
---

## Вместо введения

Код `javascript` выполняется в одном потоке, **синхронно** строчка за строчкой. Такой код выполняется сразу.
Пока выполняется текущая строка следующая ждет выполнения, то есть дальнейший код блокируется.

Чтобы это обойти нужно запустить код **асинхронно**, это все те операции для выполнения которых нужно некоторое время. Они всегда выполняются после синхронных операции.
Асинхронные задачи выполняются по очереди, которой управляет движок `javascript`.

Важно заметить, поток выполнения один, движок `javascript` сам управляет задачами в очереди на выполнение.

## Promise

`Promise` - Объект для работы с асинхронным кодом. Этот же объект возвращается в качестве результата.

Сегодня разберем основы `Promise`.

Сам объект может быть в одном из 3 состояний:

1. `pending` - ожидание, по умолчанию
2. `fulfilled` - выполнено успешно, результат получен
3. `rejected` - выполнено с ошибкой

Если просто создать `Promise` на ровном месте получим ошибку.

````javascript
let promise = new Promise(); // Uncaught TypeError: undefined is not a function
````

Так, как нужно передать в параметры функцию `executor`, хорошо.

> Задача функции `executor` перевести promise в состояние `fulfilled` или `rejected`.
{: .prompt-info }

````javascript
// Получаем состояние ожидания
let promise = new Promise(() => {}); // Promise { <state>: "pending" }
````

Причем функция выполниться, еще до создания объекта `Promise`. Что иллюстрирует пример.

````javascript
let promise = new Promise(() => {console.log(123)}); // 123
// Либо вынести в отдельную функцию
function executor() {
  console.log(123);
}
let promise = new Promise(executor); // 123
````

Но, если вернуть значения из функции `executor`, оно не будет возвращено.

````javascript
let promise = new Promise(() => {return 123;}); // ...
````

В параметры функции `executor` передаются еще две функции `resolve` и `reject`. Они как раз меняют состояние `Promise`.

Название функции может быть любым просто устоялось именно такое наименование. 

То есть синтаксис `Promise` такой `new Promise(function(resolve, reject) { ... });`

````javascript
// resolve, reject это функции которые предоставляет promise
// Напомню вся эта функция (resolve, reject) => {} вызвается сразу же.
let promise = new Promise((resolve, reject) => {});
````

Нам нужно самим решить, что успешно, а что нет. Разрешим `Promise`.

````javascript
let promise = new Promise((resolve, reject) => {
    resolve();
}); // Promise { <state>: "fulfilled", <value>: undefined }
````

Как видим состояние поменялось на `fulfilled`.

В `resolve` можно передать данные асинхронной операции, но это не обязательно.

````javascript
let promise = new Promise((resolve, reject) => {
    resolve( 'data'); // Promise { <state>: "fulfilled", <value>: "data" }
});
````

Можно сказать, что `Promise` завершен успешно.

Теперь представим произошла ошибка, переведем `Promise` в состояние `rejected`.

````javascript
let promise = new Promise((resolve, reject) => {
    reject();
}); // Promise { <state>: "rejected", <reason>: undefined } Как раз вот и есть ошибка Uncaught (in promise) undefined
````

Обработаем ошибку передав туда сообщение.

````javascript
let promise = new Promise((resolve, reject) => {
    reject(new Error('error'));
}); // Uncaught (in promise) Error: error
````

Теперь вызовем `resolve` несколько раз.

````javascript
let promise = new Promise((resolve, reject) => {
    resolve('1'); // Будет вызван только этот resolve, остальные игнорируются
    resolve('2');
    resolve('3');
}); // Promise { <state>: "fulfilled", <value>: "1" }
````

Или тоже, самое с `reject`.

````javascript
let promise = new Promise((resolve, reject) => {
    reject('error'); // Выполнение только тут
    resolve('resolve');
    reject('error2');
    resolve('resolve2');
}); // Promise { <state>: "rejected", <reason>: "error" } Uncaught (in promise) error
````

Это говорит о том, что состояние `Promise` можно менять только один раз.

> `Promise` может изменить свое состояние только один раз.
{: .prompt-info }

Еще есть возможность сразу же разрешить или нет `Promise` "на месте" с использованием статических методов.

````javascript
let resolve = Promise.resolve('resolve'); // Promise { <state>: "fulfilled", <value>: "resolve" }
let reject = Promise.reject('reject'); // Promise { <state>: "rejected", <reason>: "reject" }
````

Эмулируем разное поведение с рандомным результатом.

````javascript
let promise = new Promise((resolve, reject) => {
    setTimeout(() => {
        if (Math.random() > 0.5) {
            resolve('ок');
        } else {
            reject('error');
        }
    },2000)
});

// Обработка результата, но об этом подробнее ниже.
promise
  .then((success) => {console.log(success)})
  .catch((error) => {console.log(error)});
````

Если обновлять страницу результат будет случайным каждый раз.

## Обработка результатов

Когда состояние `Promise` меняется, его можно обработать с помощью методов:

- `then()` - вызван тогда когда будет вызван `resolve()`, но с оговорками.
- `catch()` - вызван тогда когда будет вызван `reject()`.
- `finally()` - будет вызван когда состояние поменялось на `"fulfilled"` или `"rejected"`

> `Promise` позволяет получить результат в будущем.
{: .prompt-info }

Рассмотрим ситуацию когда результат попадет в `finally`, когда `Promise` будет разрешен или отклонен, говорят еще это состояние `settled`.


````javascript
let promise = new Promise((resolve, reject) => {
  resolve();
});

let promise2 = new Promise((resolve, reject) => {
  reject();
});

promise.finally(() => {console.log('final - resolve')}); // final - resolve
promise2.finally(() => {console.log('final - reject')}); // final - reject
````

Теперь разрешим `Promise` успешно и получим закономерный результат с помощью `then`.

````javascript
let promise = new Promise((resolve, reject) => {
  resolve('success');
});

promise
  .then((data) => {console.log(data)}) //success
````

Метод `then` возвращает `Promise` с двумя `callbacks`

- `onFulfilled` - значение с которым `Promise` был выполнен.
- `onRejected` - значение с которым `Promise` был отклонен.

````javascript
let promise = new Promise((resolve, reject) => {
    reject('error'); // Выполнен этот callback
    resolve('success');
});

promise
  .then(
    (data) => {console.log(data)},
    (data) => {console.log(data)} // Попадем сюда, error
  )
````

Но такой, код менее очевиден, гораздо нагляднее обработать это с помощью `catch()`. Думаю делать лучше так.

````javascript
let promise = new Promise((resolve, reject) => {
    reject('error');
});

promise.catch((data) => {console.log(data)}) // error
````

`catch()` ловит все ошибки. 

Но ошибки могут возникнуть в самом `then`, но только если она возникает во втором параметре `onRejected`.

````javascript
let promise = new Promise((resolve, reject) => {
    reject('error');
});
promise
  .then((data) => {
  },() => {
    // Допустим здесь произошла ошибка
    throw new Error('error');
  })
  .catch((error) => {console.log(error.message)}) // error
````

Получается каждый `then, catch`, возвращает новый `Promise` всегда. Что показывает пример.

> Новый `Promise` будет всегда возращен.
{: .prompt-info }

````javascript
let promise = new Promise((resolve, reject) => {
    resolve('success');
});

promise
  .then((data) => {console.log(data); return data}) // success
  .then((data) => {console.log(data); return data}) // success
  .then((data) => {console.log(data); return data}) // success
  .then((data) => {console.log(data); return data}) // success
  .then((data) => {console.log(data); return data}) // success
  .then((data) => {console.log(data); return data}) // success
  .then((data) => {console.log(data); return data}) // success
````

К примеру результат можно видоизменять на каждой итерации.

````javascript
let promise = new Promise((resolve, reject) => {
    resolve(1);
});

promise
  .then((data) => {console.log(data); return data + 1}) // 1
  .then((data) => {console.log(data); return data + 1}) // 2
  .then((data) => {console.log(data); return data + 1}) // 3
  .then((data) => {console.log(data); return data + 1}) // 4
  .then((data) => {console.log(data); return data + 1}) // 5
  .then((data) => {console.log(data); return data + 1}) // 6
  .then((data) => {console.log(data); return data + 1}) // 7
````

Или даже так, так как код выполняется асинхронно, все результаты будут выведены сразу же, спустя 3 секунды.

````javascript
let promise = new Promise((resolve, reject) => {
    resolve(1);
});

promise
  .then((data) => {setTimeout(() => {console.log(data) },3000); return data + 1;}) // 1
  .then((data) => {setTimeout(() => {console.log(data) },3000); return data + 1;}) // 2
  .then((data) => {setTimeout(() => {console.log(data) },3000); return data + 1;}) // 3
````

Чтобы эмулировать таймер, увеличим время на 3 сек, в каждом `then`.

````javascript
let promise = new Promise((resolve, reject) => {
    resolve(1);
});

promise
  .then((data) => {setTimeout(() => {console.log(data) },3000); return data + 1;}) // 1
  .then((data) => {setTimeout(() => {console.log(data) },6000); return data + 1;}) // 2
  .then((data) => {setTimeout(() => {console.log(data) },9000); return data + 1;}) // 3
````

## async / await

`Promise` можно вернуть из любой функции. `Javascript` автоматически обернет ответ из функции в `Promise`.

Добавляем ключевое слово **async**.

`async` - говорит функции, что она будет возвращать `Promise`.

````javascript
async function test(){
    return 'value';
}
test() // Promise { <state>: "fulfilled", <value>: "value" }

// или так

const test2 = async () => {
  return 'value';
}

test2() // Promise { <state>: "fulfilled", <value>: "value" }
````

> Данные из функции при наличии async будут обернуты в `Promise` в любом случае.
{: .prompt-info }

Далее естественно нужно обработать результат с помощью `then` и `catch`.

````javascript
async function test() {
    return new Promise(resolve => {
        setTimeout(() => {
            resolve(1);
        },2000)
    });
}

test().then((data) => console.log(data)); // через 2 сек результат 1
````

Как бы сделать, чтобы не писать `then` каждый раз для обработки `Promise`, для этого есть ключевое слово `await`.

`await` работает только в модулях и в асинхронных функциях.

То есть `await` ждет выполнения асинхронной функции.

Перепишем пример.

````javascript
async function test() {
    let p = new Promise(resolve => {
        setTimeout(() => {
            resolve(1);
        },2000)
    });

    let result  = await p;
    console.log(result);
}

test() // вот так получили результат 1
````

## Что в итоге 

В итоге у нас получится пример такая схема работы `Promise`:

````text
Promise - состояние pending
    fulfilled - успешно разрешен
        .then - вызов метода then
            return new Promise - возврат Promise со статусом pending
                .then - снова обрабатываем и так много раз пока не придем к результату
    rejected - отклонен
        .catch
            error - ошибка
        .then - если есть второй параметр
````

`Promise` является основой для понимания современного асинхронного программирование на `javascript`.

Использование `Promise` делает код чище. 

`Promise` возвращает метод `fetch`, который мы разберем в одной из будущих заметок.
