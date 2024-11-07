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

Мы объявили функцию `test` и сразу же ее вызвали в результате у нас в ответе `undefined`. То есть это функция с побочным эффект

Смысла в таком вызове нет, так как мы не проделали никакой работы и ничего не вернули из функции.

### Возврат значения

Чтобы видеть результат, мы должны вернуть значение из функции 

https://doka.guide/js/return/

https://www.youtube.com/watch?v=IvBNfbNEvoY&t=1110s


> Такое объявление функции называется function declaration . Если функция была объявлена таким спобобом, она становиться видна во всех частях файла.
{: .prompt-info }
 
## function expression

Функция будет доступна только после того, как мы присвоили ее в переменную.

````javascript
const test1 = function () {};
console.log(test1());
````

> В javascript нужно стараться предполагать, что в аргументах функции будут определенный типы данных и возврат будет всегда определенного типа
{: .prompt-info }

## Стрелочная функция (lambda expression)

````javascript
const test2 = () => (1); // Выражение которое должно посчитаться
````

## Стрелочная функция (lambda function)

````javascript
const test3 = () => {};
````

## Область видимости

Любой блок операторов создает контекст.
 
У нас есть идентификатор, можно рассматривать его откуда он виден.

Рассмотрим пример

````javascript
const num = 1;  // Первоначальное значение

function f1() { // Объявляем функцию
  const num = 2;
  console.log(num);

  { // Блок операторов
      const num = 3;
      console.log(num);
      {  // Вложенный блок операторов
          const num = 5;
          console.log(num);
      }
  }

  if (true) { // Условная конструкция
      const num = 4;
      console.log(num);
  }

    console.log(num);
}

f1();  //  Вызов функции
console.log(num) // Печать констранты на экран
/*
2 - Сначала вызвали функцию, там значение num = 2
3 - Потом в блоке опрераторов значение num уже 3
5 - Во вложенном блоке операторов значение уже 5
4 - Вышли из блока опраторов и объявили уловную конструкцию if, там значение уже 4
2 - Первонасальное значение объявленное вначале функции
1 - Печать значения num за пределами функции
 */
````

## Абстракции



````javascript
test2.name // Имя функции
test2.length // кол-во аргументов
(x => x).name
test2.toString() // Исходный код функции
````


https://www.youtube.com/watch?v=pn5myCmpV2U&t=1820s
https://github.com/HowProgrammingWorks/Dictionary

https://www.youtube.com/watch?v=hSyA7tcNaCE&list=PLHhi8ymDMrQZad6JDh6HRzY1Wz5WB34w0&index=5
--------------------------


 
## Чистые функции

При одинаковых входных параметрах, всегда дают одинаковый результат.

## Функции с побочными эффектами

Откуда появляется побочные эффекты
Функции лежат в контекстах, они видят переменные которые определены в файле или в контексте.
Если функция меняет, что-то в своем контексте, меняет что-то кроме аргументов, то функция имеет побочными эффектами.

Такая функция усложняет состояние приложения. 
Без них нельзя обойтись, все равно нам нужно состояние.

> Функция не должна держать свое состояние в глобальном контексте
{: .prompt-info }

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
