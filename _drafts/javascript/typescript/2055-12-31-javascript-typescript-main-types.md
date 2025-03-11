---
title: Typescript. Основное использование типов
description: >-
  Базовое использование типов в typescript
author: alex
date: 2055-12-31 18:00:00 +0300
categories: [Javascript,Typescript]
tags: [typescript]
image:
  path: /assets/img/posts/main/typescript.png
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: Typescript. Основное использование типов
---

В прошлой статье мы поставили `typescript` и научились запускать код.

Начнем с видов типов и вариантов их использования, далее будем углубляться и там где это важно будем разбирать опции конфигурации `typescript`.

> Важно понимать, что typescript автоматически умеет выводить тип на основе присвоенного значения
{: .prompt-info }

## boolean

Может принимать только два значения `true` или `false`

````typescript
const bool1: boolean = true;
const bool2: boolean = false;
````

Как это можно использовать.

Например, просто вернуть значение `true` просто двойным отрицанием

````typescript
let test: boolean = true;
console.log(!!test); // true
````

Логическое И/ИЛИ

````typescript
let test1: boolean = true && true && false;
console.log(test1); // false

let test2: boolean = false || true;
console.log(test2); // true
````

Либо у нас функция проверка, которая как раз возвращает  `boolean`

````typescript
function test(num:number): boolean {
    return num >= 1;
}

console.log(test(0)); // false
````


## number

Это числа. Могут быть с плавающей точкой, десятичные, шестнадцатеричными - это все тип `number`.

````typescript
const decimal: number = 6;
const float: number = 3.14;
const binary: number = 0b1010;
````

> В typeScript все числа представлены как числа с плавающей точкой.
{: .prompt-info }

## string

Это примитивный тип для текстовых значений

````typescript
const string1: string = 'Строка';
const string2: string = "Строка";
const string3: string = `Строка`;
const string4: string = `Строка из другой ${string3}`;
````

Можно объявить строковый литеральный тип где указать несколько вариантов которые могуть быть в строке, например так

````typescript
type Test = "one" | "two" | "three";

const str: Test = 'one';
````

Ну и конечно строки можно объединять с другими строками.

Строку можно использовать в качестве параметра функции и возврата значения из нее.

````typescript
function str(s:string): string {
    return s;
}

console.log(str('Строка')); // Строка
````

`typescript` можно явно указать что переменная имеет тип строка с помощью `as`.

````typescript
let str = 'Строка';

str as string;
````

## array

Это упорядоченные списки значений.

````typescript
// Массив чисел
const arr1: number[] = [1,2,3];
// Запись выше эквивалентна
const arr2: Array<number> = [1,2,3];
// Массив специальных значений + другой массив
let mixed: (string | number | Array<[] | object | Date>)[] = ["str", 1, "str", 2, [[],{}, new Date()]];
// Массив массивов массивов
let mixed2: number[][][] = [[[1]],[[1]]];
````

`typescript` идет по наихудшему варианту и помогает программисту в выявлении ошибок

## tuple

В `typeScript`, кортежи (`tuples`) - это типизированные массивы с фиксированной длиной и известными типами элементов в каждой позиции. 

В отличие от обычных массивов, где все элементы должны быть одного типа, кортежи позволяют хранить элементы разных типов.

````typescript
// Типы элементов строго определены
const test: [number,string,number] = [1,'123',5];
const tuple: [Date,number] = [new Date, 123];
const tuple2: [[string],[number]] = [['str'], [77]]; 
````

Что дают кортежи:

- Делают код более читаемым
- Позволяют представить структуру данных с фиксированным числом элементов, где еще типы у элементов разные.


## enum

Набор именованных констант, которые облегчают работу с набором различных вариантов.

> По умолчанию значениям присваиваются индексы с 0
{: .prompt-info }

````typescript
enum Color {
    Red, // 0
    Green, // 1
    Blue, // 2
}

const c:Color = Color.Red;
````

Есть возможность присвоить свои индексы, они будут идти по-порядку

````typescript
enum Color {
    Red = 5,
    Green,
    Blue,
}

const c:Color = Color.Blue;

console.log(c); // 7
````

Так же есть возможность использовать строки в `enum`

````typescript
enum Color {
    Red = 'red',
    Green = 'green',
    Blue = 'blue',
}

const c:Color = Color.Blue;

console.log(c); // blue
````

Использовать `enum` можно в  качестве набора возможных значений для параметров функции, например так

````typescript
enum Color {
    Red = 'red',
    Green = 'green',
    Blue = 'blue',
}

function c (color: Color) {
    return color;
}

console.log(c(Color.Green));
````

`enum` полезны, когда у вас есть переменная, которая может принимать только одно значение из небольшого, известного набора значений . Они улучшают читаемость кода, предоставляя понятные имена для констант, и помогают предотвратить ошибки, ограничивая возможные значения переменной.


## any

Вообще любой тип, его не рекомендуют использовать 

````typescript
let notSure1: any = 4;
let notSure2: any = "Строка";
````

## void

Это функция, которая не возвращает значение, к примеру

````typescript
function warnUser(): void {

}
````

Или переменная, где ничего нет.

````typescript
let nothing: void = undefined;
````

Когда это может быть полезно:

- Когда функция выполняет действия, но не возвращает никакого значения.
- Для явного указания, что функция не должна возвращать значение, что помогает избежать случайных ошибок.
- `void` в `typeScript` полезен для четкого определения функций, которые не возвращают значений, и для обеспечения типовой безопасности в вашем коде

## null и undefined

Специальные значения представляющие из себя отсутствие значения.

````typescript
let u: undefined = undefined;
let n: null = null;
````

## never

Тип `never` представляет значения, которые никогда не должны возникать. Например, функция, которая всегда выбрасывает исключение

````typescript
function throwError(message: string): never {
  throw new Error(message);
}

throwError("error");
````

## object

Представляет объект с как бы декларацией его типа

````typescript
let obj: object = { name: "John", age: 30 };
````

````typescript
interface Type {
    test: number;
}

type K = {
    prop: string;
}

const o1: Type = {test: 123};
const o2: K = {prop: "Строка"}
````

## Итог

Мы расмотрели основные типы в `typescript`, а в следующей статьи разберем непосредственно работу с типами.
