---
title: typescript
author: alex
date: 2025-12-31 18:00:00 +0300
categories: [Typescript]
---

https://my-js.org/docs/guide/ts основы
https://my-js.org/docs/cheatsheet/ts/ шпаргалка
https://my-js.org/docs/cheatsheet/mastering-ts в деталях
https://www.dev-notes.ru/articles/typescript/typescript-basics-primitive-and-basic-types/#primitive_types_javascript_and_typescript приминивные типы
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

### Javascript
 
Вспомним какие примитивные типы есть в javascript

#### string

````javascript
let s1 = "Строка";
let s2 = 'Строка';
let s3 = `Строка`;
````

#### number

````javascript
let n1 = 1;
let n2 = -10;
let n3 = 3.5;
let n4 = Infinity;
let n5 = NaN;
let n6 = 10_000;
````

#### boolean

````javascript
let b = true;
let b2 = false;
````

#### null

````javascript
let n = null;
````

#### undefined

````javascript
let u = undefined;
````

#### symbol

````javascript
let s = Symbol("mySymbol");
````

#### bigint

````javascript
let b = 1234567890123456789012345n;
````

### Typescript

Typescript наследует все примитивные типы и добавляет несколько своих

#### any

`any` означает любой тип, что подразумевает, что модуль проверки типов в конкретном случае будет отключен.

Типы в typescript можно добавлять постепенно, каждый раз улучшая код.

Выражение, означает любой тип

````typescript
let age = 12 as any
````

any снижает безопасность кода, ide не будет подсказывать варианты использования

Типы any отключают реакцию модуля проверки TypeScript.
Они могут маскировать реальные проблемы, вредить разработчику и подрывать его уверенность в системе типов.

По возможности нужно избегать их применения.


#### enum

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


#### void
#### array

Типизированные массив

- `string[]`
- `number[]`
- `Array<string>`
#### tuple
#### never

## Функции

Typescript пытается автоматически определить тип возвращаемого значения функции на основе конструкции `return`

```typescript
function test(name: string): string {
    return name;
}

// Такой вызов вызовет ошибку
test(234);
```

Типы функции можно задать следующим образом

````typescript
// Обычный вариант
function t(text: string, text2: string): string {
  return 'string';
}
// Стрелочная функция
let h = (text: string, text2: string):string => {
  return 'string';
}
````

> Всегда лучше явно указывать типы в параметрах функции и в возвращаемых значениях
{: .prompt-info }

## Объект

Свойства объекта можно так же типизировать.




## Определение типа на основе контекста
 
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


## Опции ts-config

Сам файл это настройки компилятора `ts`.

На самом деле по настоящему важных опций `ts-config` не так уже и много

````json
{
  "compilerOptions": {}
}
````

Рассмотрим основные опции более подробно

### esModuleInterop

Помогает устранить противоречия между `CommonJs` и `ES`

### skipLibCheck

Пропускает проверку типов файлов .d.ts

### target

Версия js на которую вы ориентируетесь, например

- es2022
- ES2021
- es2016
 
### allowJs

Позволяет импортировать js файлы

### resolveJsonModule

Позволяет импортировать json файлы

### moduleDetection

Заставляет `typescript` рассматривать все файлы как модули.

### isolatedModules

---

### strict

Включаем строгую проверку типов

### noUncheckedIndexedAccess

Запрещает обращаться к массиву или к объекту не проверив определен ли он


https://www.dev-notes.ru/articles/typescript/tsconfig-cheat-sheet/

### Примеры ts-config

Как выглядит конфиг в nestjs

````json
{
  "compilerOptions": {
    "module": "commonjs",
    "declaration": true,
    "removeComments": true,
    "emitDecoratorMetadata": true,
    "experimentalDecorators": true,
    "allowSyntheticDefaultImports": true,
    "target": "ES2021",
    "sourceMap": true,
    "outDir": "./dist",
    "baseUrl": "./",
    "incremental": true,
    "strict": true,
    "skipLibCheck": true,
    "strictNullChecks": false,
    "noImplicitAny": false,
    "strictBindCallApply": false,
    "forceConsistentCasingInFileNames": false,
    "noFallthroughCasesInSwitch": false,
    "strictPropertyInitialization": false
  }
}
````

В next.js

````json
{
  "compilerOptions": {
    "lib": ["dom", "dom.iterable", "esnext"],
    "allowJs": true,
    "skipLibCheck": true,
    "strict": true,
    "noEmit": true,
    "esModuleInterop": true,
    "module": "esnext",
    "moduleResolution": "bundler",
    "resolveJsonModule": true,
    "isolatedModules": true,
    "jsx": "preserve",
    "incremental": true,
    "plugins": [
      {
        "name": "next"
      }
    ],
    "paths": {
      "@/*": ["./*"]
    }
  },
  "include": ["next-env.d.ts", "**/*.ts", "**/*.tsx", ".next/types/**/*.ts"],
  "exclude": ["node_modules"]
}

````



