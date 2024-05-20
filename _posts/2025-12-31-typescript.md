---
title: typescript
author: alex
date: 2025-12-31 18:00:00 +0300
categories: [Typescript]
---

https://my-js.org/docs/guide/ts основы
https://my-js.org/docs/cheatsheet/ts/ шпаргалка
https://my-js.org/docs/cheatsheet/mastering-ts в деталях

https://my-js.org/docs/guide/ts#%D1%82%D0%B8%D0%BF%D1%8B-%D0%BD%D0%B0-%D0%BA%D0%B0%D0%B6%D0%B4%D1%8B%D0%B9-%D0%B4%D0%B5%D0%BD%D1%8C

## Примитивные типы

- `string` - `"Строка"`
- `number` - `6` или `0.1`
- `boolean` - `true false`

В таких аннотациях нет необходимости, так как typescript пытается автоматически определить ее тип исходя из ее значения.
 
````typescript
let num:number = 1;
let num2:number = -1;
let num3:number = 54654.67;
let num4:number = NaN;
let num5:number = Infinity;
let str:string = "Строка";
let str2:string = "Строка";
let str3:string = `Строка`;
let bool:boolean = true;
let bool2:boolean = false;
const a:number = 1 + 123;

````

## Массив

- `string[]`
- `number[]`
- `Array<string>`

## Any

Представляет любой тип

## Функция

Typescript пытается автоматически определить тип возвращаемого значения функции на основе конструкции `return`

```typescript
function test(name: string): string {
    return name;
}

// Вот такой вызов даст ошибку
test(234);
```
 
Определение типа на основе контекста. Здесь мы не указывали типы, typescript пытается это определить сам

````typescript
const a = ["a","b","c"];

a.forEach(function (s) {
    console.log(s);
})
````

