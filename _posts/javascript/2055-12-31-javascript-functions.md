---
title: Погружение в функции в javascript
description: >-
   Подробно разбираемся с работой функций в javascript
author: alex
date: 2055-12-31 18:00:00 +0300
categories: [Javascript]
tags: [javascript]
---

## Что это такое

Функции в javascript - фундаментальная концепция языка. Блок кода, который можно вызвать.

Например, объявим функцию
````javascript
function test() {
  console.log(1);
}
````

И просто запустим этот javascript код. Ничего не произошло. Все правильно. Но обо всем по порядку.

## function declaration

### Из чего состоит объявление и вызов функции:

- Ключевое слово `function`
- Имя функции, например `getCall` или `checkAddress`
- Список необязательных параметров в скобках в формате `(p1=1,p='text')`
- `{}` - непосредственно тело, код функции который будет выполняться при вызове.

Объявим именованную функцию

````javascript
function test(){}
````

Вызовем ее, просто указав ее имя и `()`

````javascript
console.log(test()); // undefined
````

Мы объявили функцию `test` и сразу же ее вызвали в результате у нас в ответе `undefined`.

Смысла в таком вызове нет, так как мы не проделали никакой работы и ничего не вернули из функции.

### Возврат значения

Чтобы видеть результат, мы должны вернуть значение из функции 

https://doka.guide/js/return/

https://www.youtube.com/watch?v=IvBNfbNEvoY&t=1110s

> Такое объявление функции называется function declaration
{: .prompt-info }

--------------------------

#### Правила именования функций


## Что можно делать с функцией

- Создать отдельно в любом месте кода, это `function declaration`
- Сохранить в переменную, это `function expression`
- Передать аргументом в другую функцию
- Вернуть из другой функции

## Где поможет функция

- Выполнить многократно выполняющийся код


## Функция как тип данных

https://doka.guide/js/function/  и далее по разделу вниз
https://doka.guide/js/function-as-datatype/
https://learn.javascript.ru/function-basics
https://learn.javascript.ru/advanced-functions
https://developer.mozilla.org/ru/docs/Web/JavaScript/Guide/Functions
https://developer.mozilla.org/ru/docs/Web/JavaScript/Reference/Functions
https://ru.hexlet.io/blog/posts/javascript-what-the-heck-is-a-callback

