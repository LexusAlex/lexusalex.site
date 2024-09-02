---
title: Идентификаторы let, const, var в javascript
description: >-
   Разбираем базовый javascript.  Информация о let, const, var
author: alex
date: 2055-12-31 18:00:00 +0300
categories: [Javascript]
tags: [js]
---

Базовые идентификаторы в javascript - это переменные объявленные разными способами.

> Есть и другие идентификаторы, которые мы рассмотрим в других статьях.
{: .prompt-info }

## Именование переменных

Первое, что нужно понять как именовать переменные.

Для именования используем символы `a-zA-Z$_0-9`.

Главное, чтобы первый символ не был цифрой.

Например, вот валидные имена

````javascript
let one;
let _one;
let _one_;
let $one
let ONE;
````

Плохие имена

````text
Maximum
ERCODE
numbers
amt
g_r_p
VE
````

## let

С помощью `let` можно объявить переменную, и впоследствии поменять ее значение.

Создадим переменную без значения 

````javascript
let solution; // undefined
````

А теперь присвоим значение, которое может быть любого типа данных.

 ````javascript
let str = 'строка'; // строка
````

Теперь создадим две переменные `a` и `b` и сложим в одну переменную значение другой.

````javascript
let a = 5;
let b = 8;
a += b; // 13 или так a + b, результат будет идентичен
````

Переменные без значений можно перечислить через запятую, но так не рекомендуется делать из-за трудного чтения.

````javascript
let value1, value2, value3, value4, value5;
// или
let value1,
    value2,
    value3,
    value4,
    value5
````

С переменной можно делать что угодно, например сложить саму с собой.

```javascript
let myNumber = 1;
myNumber = myNumber + myNumber + myNumber; // 3
```

Или изменить тип на "ходу", но тоже не правильно

````javascript
let myNumber = '1'; // Здесь строка 1
+myNumber; // А теперь число 1
````

### Как не нужно делать

#### Многострочная конструкция

````javascript
let test = 1,
    m = 2, i,
    text = 'text';
````
 
В объявлении выше все смешано в одну кучу, мы не поняли, где началось объявление `let` 

Перепишем код выше

````javascript
let test = 1;
let m = 2;
let i;  // i счетчик цикла
let text = 'text';
````

Так и читается гораздо лучше. 

> Лучше избегать многострочных конструкций, пишем на отдельных строках.
{: .prompt-info }

#### Менять тип переменной 

````javascript
let test = 1; // 1
test = []; // []
````

Код является неправильным с точки зрения стиля.

Лучше так не делать, хотя код валидный.

Лучше объявить две переменные и использовать отдельно 

````javascript
let num = 1;
let repository = [];
````

## const

Константы - это переменные значения которых не меняется.

```javascript
// Глобальная константа, название которой пишется большими буквами
const GLOBAL_PRICE = 1; // 1
// Локальная константа
const price = 1000;
```

> Как писать константы большими или маленькими буквами - это чисто наше соглашение, сделанное просто для удобства
{: .prompt-info }


> Важно понимать, что если константе не задать значение, то будет ошибка, значение должно быть обязательно.
{: .prompt-info }


## Когда использовать let а когда const

Это можно понять по семантике и названию, если точно значение не будет меняться используем `const`.

Лучше это сделать сразу.

Очевидно, что к переменным нельзя обращаться до объявления их в коде.

````javascript
console.log(a);
let a = 1; // ReferenceError: Cannot access 'a' before initialization
````

## var

https://learn.javascript.ru/var
https://learn.javascript.ru/variables
https://habr.com/ru/companies/ruvds/articles/420359/
https://doka.guide/js/var-let/
https://doka.guide/js/const/
https://fruntend.com/posts/obyavlenie-peremennykh-v-javascript-var-let-const

https://stackdev.blog/blog/js-variables
Константы и переменные

````javascript
// Нельзя менять
const INTERVAL = 1;
// Можно менять
const test = 0;
````
    
Абстракция цикл, функция, переменные

Область видимимости области операторов
