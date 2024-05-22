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

## Typescript

Typescript - Это язык очень похожий на javascript. Но браузеры его не могут выполнять, его нужно преобразовывать в javascript

Главное преимущество typescript в том, что он дает возможность добавлять аннотации типов к различным javascript сущностям.

Ошибки проверяются на этапе написания кода и видны в IDE или во время сборки проекта.

Строгая типизация позволяет нам держать код под контролем, а аннотации типов позволяют писать надежный код.

````typescript
let num = 1;
````

В таких аннотациях нет необходимости, так как typescript пытается автоматически определить ее тип исходя из ее значения.

Но TypeScript максимально эффективен, когда располагает информацией о типах.

````typescript
let num:number = 1;
````

На высоком уровне tsc (компилятор) делает две вещи:

- Конвертирует версию TypeScript / JavaScript в более старую версию JavaScript, способную работать в браузерах.
- Проверяет код на наличие ошибок типов.

Удивительно то, что эти действия не связаны и проверка типов не влияет на работу кода JavaScript.

## Строгий режим

https://doka.guide/tools/static-types/#igor-kamyshev-sovetuet

## Примитивные типы

- `string` - `"Строка"`
- `number` - `6` или `0.1`
- `boolean` - `true false`

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
 
Определение типа на основе контекста. Здесь мы не указывали типы, typescript пытается это определить сам,
в данном случае - это массив строк.

````typescript
const a = ["a","b","c"];

a.forEach(function (s) {
    console.log(s);
})

// Либо
a.forEach( (s) => {console.log(s)})

// Или же указать типы прямо в функции
a.forEach( (s:string):void => {console.log(s)})
````



## Enum

Enum должен быть в коде до того как мы его используем.
 
При компиляции все неиспользуемые значения `enum` будут удалены

````typescript
const enum UserRole {
    Admin,
    User
}

let role: UserRole;
role = UserRole.Admin;
````

`Enum` плохо использовать когда добавляется новые значения тогда он не подходит.
`Enum` хорошо использовать для физических явлений.
