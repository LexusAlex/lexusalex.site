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

## Утверждение

````typescript
const el = document.querySelector('#app')!;

el.innerHTML = 'str';
````

Мы говорим, что `null` быть не может.

Typescript не может быть связан с `html` разметкой

Typescript пытается интерпертировать тип максимально широко.





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

typescript старается загнать нас рамки, чтобы мы не могли совершить ошибку

## Сливание типов

Рассмотрим возможность `typescript` склеивать типы

````typescript
type One = {
    'type': number
}

type Two = {
  'test': string
}

const t: One & Two = {
    type: 123,
    test: "test"
}
````


? означает необязательный

ts
1
1.17

js
1
1.04
