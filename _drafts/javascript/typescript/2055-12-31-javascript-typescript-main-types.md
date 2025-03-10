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

Начнем с основных вариантов использования типов и там где это важно будем разбирать опции конфигурации `typescript`.

## boolean

````typescript
const bool1: boolean = true;
const bool2: boolean = false;
````

## number

````typescript
const decimal: number = 6;
const float: number = 3.14;
const binary: number = 0b1010;
````

## string

````typescript
const string1: string = 'Строка';
const string2: string = "Строка";
const string3: string = `Строка`;
const string4: string = `Строка из другой ${string3}`;
````

## array

````typescript
const arr1: number[] = [1,2,3];
const arr2: Array<number> = [1,2,3];
````

## tuple

Тип кортежа, представляющий массив с фиксированным количеством элементов, типы которых известны, но не обязательно одинаковы

````typescript
const test: [number,string,number] = [1,'123',5];
````

## enum

Перечисление элементов

````typescript
enum Color {
    Red,
    Green,
    Blue,
}

const c:Color = Color.Red;
````

## any

Вообще любой тип, его не рекомендуют использовать 

````typescript
let notSure1: any = 4;
let notSure2: any = "Строка";
````

## void

Это функция, которая не возвращает значение.

````typescript
function warnUser(): void {

}
````

## null и undefined

````typescript
let u: undefined = undefined;
let n: null = null;
````

## never

Тип `never` представляет значения, которые никогда не должны возникать. Например, функция, которая всегда выбрасывает исключение

````typescript
function error(message: string): never {
    throw new Error(message);
}
````

## object

````typescript
let obj: object = { name: "John", age: 30 };
````

## Класс как тип

Любой класс может быть как тип

````typescript
const a_1: Number = 2;
const a_2: Date = new Date();
const a_3: String = 'str';
````

## Функция

````typescript
const sum : (x : number,y : number) => number = function (x : number,y : number) : number {
    return  x + y;
}

// Но лучше тип объявить так

type Sum = (x : number,y : number) => number;

const sum2: Sum = function (x : number,y : number) : number {
  return  x + y;
}

sum(5,9);
sum2(5,9);
````

## Узкий тип

````typescript
const b_1: 45 = 45;
const b_2: 'Строка' = "Строка";
````

## Несколько типов

````typescript
const c_1: number|string = 'str';
const c_2: number|string = 5;
`````


Важно понимать что в js все типы будут удалены, js на них пофиг





## Опция noImplicitAny

После включения этой опции, `TypeScript` будет выдавать ошибку всякий раз, когда он не сможет вывести тип переменной и вместо этого будет использовать `any`, например

````typescript
function add (a, b) {
    return a + b;
}

add(1,2);
````

````shell
src/main.ts:29:15 - error TS7006: Parameter 'a' implicitly has an 'any' type.
src/main.ts:29:18 - error TS7006: Parameter 'b' implicitly has an 'any' type.
````

По умолчанию опция включена `noImplicitAny`. Так что нет смысла ее включать дополнительно



ts
1
52.50

js
1
1.04
