---
title: Использование Promise
description: >-
  Promise базовый способ работать с отложенными вычислениями
author: alex
date: 2055-08-24 15:00:00 +0300
categories: [Html]
image:
  path: /assets/img/posts/main/html.png
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: Promise базовый способ работать с отложенными вычислениями
---

## Кратко

`Promise` - это специальный объект для выполнения отложенных асинхронных операций, результат которого возврщается в некоторый момент в будущем.

По умолчанию `Promise` находится в режиме ожидания, через некоторое время он будет разрешен либо отклонен.

Асинхронная операция, это любое действие которое не выполняется мгновенно, как раз `Promise` представляет будущий результат такой операции, он сам по себе будет возвращен, результат операции придет позже.

Многие `api используют `Promise`, поэтому он считается базой которую нужно знать. Он как контейнер для конечного результата.

В качестве сравнения, проведем аналогию между событиями и промисами. Обработчики событий выполняются несколько раз, в то время как `then` выполеняется только один раз, то есть можно сказать `Promise` - это одноразовая операция.
При вызове `then` результат будет получен, а при событии если обработчик не был навешен оно просто потеряется. В `Promise` уже встроен обработчик ошибок, в событиях их нужно обрабатывать отдельно.

`Promise` полезен в первую очередь для обработки асинхронных операций.

## Объект без параметров

Если создать объект без параметров, получаем ошибка, так как внутрь нужно обязательно передать функцию `executor` - то есть исполнитель.

````javascript
let promise = new Promise(); // Uncaught TypeError: undefined is not a function
````

## Executor

Важным аспектом в понимании `Promise` является функция `executor`. Ее нужно передать в конструктор `new Promise();`, она как раз и будет производить всю работу.

Функция `executor` выполняется сразу же и синхронно при создании объекта.

````javascript
let promise = new Promise(() => {console.log(132)}); // 132
````

Но при этом сначала выполнится функция `executor`, а только потом создаться объект `Promise`.

Для удобства вынесем функцию `executor` в отдельную функцию, сделаем их 2

````javascript
let executor2 = () => {console.log('executor2');} // Вторая функция

let promise = new Promise(executor2); // executor2

function executor1() // Первая функция
{
  console.log('executor1');
}
````

Вроде поведение ожидаемо, функция в переменной нужно объявить до использования, а обычную функцию можно и после. 

> В любом случае функция `executor` будет всегда выполнена до создания объекта `Promise`.
{: .prompt-info }

Даже если создать несколько промисов, ситуация не поменяется

````javascript
let promise = new Promise(executor1);
let promise2 = new Promise(executor1);
let promise3 = new Promise(executor1);

function executor1()
{
  console.log('executor1'); // 3 раза 'executor1'
}
````

Если попробовать вернуть что-то из функции, то мы ничего не получим. То есть значение `123` мы никогда не увидим.

````javascript
let promise = new Promise(() => {
  return 123; // ...
});
````

В функцию `executor` передается 2 аргумента `resolve` и `reject`. Это функции которые будут менять состояние `Promise` внутри функции `executor`.

То есть результат возврата из функции `executor` устанавливается только путем вызова `resolve()` или `reject()`, обычный `return` игнорируется.

Задача разработчика внутри `executor` вызвать `resolve()` или `reject()`, тем самым перевести в `fulfilled` или `rejected`. Об этом чуть ниже.

`resolve()` вызовет успешное выполнение `Promise`, а `reject()` отклонит его.

## Состояния `Promise`.

Как мы поняли `executor` описывает выполнение асинхронной операции, по завершению которой, необходимо вызвать `resolve()` или `reject()`.

По умолчанию `Promise` у нас находится в состоянии `pending`, то есть в ожидании, не выполнен и не отклонён.

````javascript
let promise = new Promise((resolve, reject) => {});
console.log(promise); // Promise { <state>: "pending" }
````

Если в какой-то момент времени мы сами разрешить `Promise`, то вызывает `resolve()`.

````javascript
let promise = new Promise((resolve, reject) => {
  resolve();
});
console.log(promise); // Promise { <state>: "fulfilled", <value>: undefined }
````

Получаем состояние `fulfilled`, то есть успешное завершение операции.

Если нужно отклонить `Promise`, вызываем `reject()`.

````javascript
let promise = new Promise((resolve, reject) => {
  reject();
});
console.log(promise); // Promise { <state>: "rejected", <reason>: undefined } Uncaught (in promise) undefined
````

Состояние `rejected`, что говорит о том, что процедура завершилась с ошибкой.

В каждую из функции можно передать значение `resolve(value); reject(error);`

`Promise` можно перевести в одно из двух состояний получив при этом значение

````javascript
let promise = new Promise((resolve, reject) => {
  // Имитируем ассинхронную операцию
  setTimeout(() => {resolve("5 sec");console.log("first");console.log(promise);}, 5000);
  // first
  // Promise { <state>: "fulfilled", <value>: "5 sec" }
});
````

````javascript
let promise = new Promise((resolve, reject) => {
  // Имитируем ассинхронную операцию
  setTimeout(() => {reject("Error");console.log(promise);console.log("error");}, 5000);
  //error
  // Promise { <state>: "rejected", <reason>: "Error" }
  // Uncaught (in promise) Error
});
````

В примерах выше мы сначала успешно разрешаем `Promise` передавая значение, далее мы завершаем `Promise` с ошибкой которая выводится в консоль.

## resolve()

Теперь попробуем вызвать `resolve()` несколько раз

````javascript
let promise = new Promise((resolve, reject) => {
  resolve('1'); // Будет вызван только этот resolve, остальные игнорируются
  resolve('2');
  resolve('3');
});

console.log(promise); // Promise { <state>: "fulfilled", <value>: "1" }
````

В данном случае будет выполнен только первый `resolve`

Еще `resolve` можно сразу разрешить на месте. Кода меньше. 

````javascript
let s = Promise.resolve("Success");
console.log(s); // Promise { <state>: "fulfilled", <value>: "Success" }
````

Если параметр `reject` не требуется, его можно не передавать

````javascript
let promise = new Promise((resolve) => {
  resolve('1');
});
````

## reject()

Вызовем `reject` несколько раз

````javascript
let promise = new Promise((resolve, reject) => {
  reject('Error1'); // Сработает эта ошибка
  reject('Error2');
  reject('Error3');
});

console.log(promise); // Promise { <state>: "rejected", <reason>: "Error1" } Uncaught (in promise) Error1
````

Получаем тоже, самое только первый `reject` будет применен.

В `reject` лучше передавать объект ошибки `reject(new Error('Error'))` так результат будет информативнее.

````javascript
let promise = new Promise((resolve, reject) => {
  resolve('ok'); // Сработает эта строка, далее код проигнорируется
  reject(new Error('Error')); // игнор
  setTimeout(() => {reject(new Error('Error')); console.log(promise)}, 3000); // игнор
});
````

В таком сборном примере, как только `resolve` был сделан, остальной код будет проигнорирован. 

> Состояние `Promise` может быть изменено только один раз либо успешно, либо ошибка.
{: .prompt-info }

Так же `reject` можно вызвать сразу на месте не создавая объект `Promise.reject`. В этом случае будет создан отклоненный `Promise`.

````javascript
let error = Promise.reject(new Error("Error"))
console.log(error); // Promise { <state>: "rejected", <reason>: Error }
````

На текущий момент понятно, что первоначальное состояние `Promise` `pending`, потом идет выполнение асинхронной операции и состояние
с помощью `resolve` становится `fulfilled`, где указывается значение или с помощью `reject` `rejected`, куда передается ошибка.

Мы подошли к моменту когда нам нужно обработать полученный результат.

## then



## catch
## finally

https://developer.mozilla.org/ru/docs/Web/JavaScript/Reference/Global_Objects/Promise/resolve

https://doka.guide/js/promise-then/


`Promise` можно вернуть из обычной функции 

````javascript
function p(val)
{
  return new Promise(resolve => {console.log(val)});
}
````

## Итог



https://developer.mozilla.org/ru/docs/Web/JavaScript/Reference/Global_Objects/Promise
https://learn.javascript.ru/async
https://doka.guide/js/promise/
