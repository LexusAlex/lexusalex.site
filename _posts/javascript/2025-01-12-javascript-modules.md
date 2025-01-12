---
title: Модульность в javascript
description: >-
  Разберем виды модулей в javascript
author: alex
date: 2025-01-12 18:30:00 +0300
categories: [Javascript,Modules]
tags: [js]
image:
  path: /assets/img/posts/main/modules.webp
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: Модульность в javascript
---

## Зачем нужны модули в javascript

Модули решают много проблем с компоновкой кода, среди них:

- Повторное использование одних и тех же кусков кода.
- Компоновка модулей в пакеты.
- Изоляция кода, можно разделить код на мелкие файлы с автономными функциями.
- Удобство в организации проекта.
- Удобство совместной разработки.

## Виды модулей

По историческим причинам модули в javascript появились не сразу, сначала были просто функции.

По сути модуль - это просто файл с функциональностью.

- Самовызывающиеся функции (`Immediately Invoked Function Expression`) `IIFE` - Это такие функции которые будут вызваны сразу после их определения.
  - Работают в браузере
- `Common js` - Первоначально были придуманы для `Node js`
  - В браузере, без дополнительных действий не работают
  - `Node js`
- `ES 6 Modules` - Современный способ модулей `javascript`
  - Работают в браузере
  - `Node js`

Рассмотрим по отдельности каждый из видов модулей.

## Immediately Invoked Function Expression

Это функция, которая будет вызвана сразу после определения. 

Например, объявим их 3 в одном файле.

````javascript
(function(){
    console.log("Функция 1");
}());

(function(){
    console.log("Функция 2");
}());

(function(){
    console.log("Функция 3");
}());
````

То есть, самозапускающийся, ее делает конструкция:

`````javascript
(function(){}());
`````

Так как это обычная функция, ее можно вызвать с параметрами, например

`````javascript
(function(y){
    console.log(y*2);
}(4)); // 8
`````

Внутри функции, можно например записывать что-то в глобальный объект или делать что-то еще.

В коде такое встречается, но все же рекомендуется использоваться современные способы.

## CommonJS

Первоначально думали, что именно этот тип модулей станет стандартом (возможно так и есть), так как `ES 6 Modules` еще не было.

Здесь под модулем воспринимается файл функционал которого можно экспортировать в другой модуль. 
А функционал другого модуля можно импортировать в этот модуль.

> Без дополнительных преобразований работает только в `Node js`, в браузере не работает.
{: .prompt-info }

> CommonJS понимает каждый файл отдельным модулем.
{: .prompt-info }

Экспортировать функционал из модуля можно конструкцией `module.exports`. А импортировать в другой файл можно с помощью `require`.

### Особенности

- Код загружается синхронно
- Из модуля загружается сразу все, нет возможности выбрать
- Require можно использовать в любом месте модуля

Модуль будет динамически синхронно загружен во время исполнения скрипта. 

Например, объявим три модуля и экспортируем функцию и переменную из каждого из них

`````js
const moduleFunction1 = () => {
    console.log('moduleFunction из module 1')
}

const moduleVariable1 = 'moduleVariable из module 1';

module.exports = {moduleFunction1, moduleVariable1}
`````
{: file='module1.js'}

`````js
const moduleFunction2 = () => {
    console.log('moduleFunction из module 2')
}

const moduleVariable2 = 'moduleVariable из module 2';

module.exports = {moduleFunction2, moduleVariable2}
`````
{: file='module2.js'}

````javascript
const moduleFunction3 = () => {
    console.log('moduleFunction из module 3')
}

const moduleVariable3 = 'moduleVariable из module 3';

module.exports = {moduleFunction3, moduleVariable3}
````
{: file='module3.js'}

Теперь подключим в еще один модуль, три модуля выше.

````javascript
const { moduleFunction1, moduleVariable1 } = require('./module1');
const { moduleFunction2, moduleVariable2 } = require('./module2');
const { moduleFunction3, moduleVariable3 } = require('./module3');

moduleFunction1();
moduleFunction2();
moduleFunction3();

console.log(moduleVariable1);
console.log(moduleVariable2);
console.log(moduleVariable3);
````
{: file='module4.js'}

Если запустить `module4`, то получаем логичный результат

````text
moduleFunction из module 1
moduleFunction из module 2
moduleFunction из module 3
moduleVariable из module 1
moduleVariable из module 2
moduleVariable из module 3
````

Так же с помощью `node.js` импортируются внутренние модули, например так `let fs = require('fs');`

Можно экспортировать отдельные функции, например

````javascript
exports.moduleFunction1 = () => {
    console.log('moduleFunction из module 1')
}

exports.moduleVariable1 = 'moduleVariable из module 1';
````
{: file='testModule.js'}

Это используется в экосистеме `Node.js`.

## ES 6 Modules

`ES 6 Modules` это самое значимое добавление в стандарте `ECMAScript 2015`, что привнесло нативную поддержку модулей в сам язык.

Самое главное, что модули можно использовать нативно без применения сборщиков и `node.js`. 

### Особенности

- Код модуля по умолчанию работает в строгом режиме, без `use strict`.
- Внутри модуля все скрыто по умолчанию, и у них своя область видимости.
- Импорт только на верхнем уровне.
- Можно выбрать что загружать из модуля, дабы не грузить все.
- Загрузка модули работает асинхронно.
- Переменные теперь ограничены модулем, если это скрипт, то переменные глобальные.
- Глобального объект здесь нет, `this` будет равен `undefined`.
- Чтобы подключить модуль в браузере нужно использовать `type=module` - `<script src="modules/es-module3.js" type="module"></script>`
- Все модули сначала будут загружены, а только потом будут исполнены.
- `Node js` тоже поддерживает `ES 6 Modules`.
- `ES 6 Modules` на верхнем уровне поддерживают `await`.
- `ES 6 Modules` локально не работают, их нужно запускать на сервере.

Рассмотрим общий базовый пример, потом более подробно его разложим. 

Сделаем 2 модуля и экспортируем функцию и константу из каждого.

````javascript
export function esModule(){
    console.log('esModule1');
}

function esModuleNotExport(){
    console.log('not export');
}

export const EsConst = 'esModule1';
````
{: file='es-module1.js'}


````javascript
export function esModule(){
    console.log('esModule2');
}

function esModuleNotExport(){
    console.log('not export');
}

export const EsConst = 'esModule2';
````
{: file='es-module2.js'}

Теперь импортируем все это в другом файле

````javascript
import {EsConst as EsConst1, esModule as esModule1} from "./es-module1.js";
import {EsConst as EsConst2, esModule as esModule2} from "./es-module2.js";

esModule1();
esModule2();

console.log(EsConst1);
console.log(EsConst2);
````
{: file='es-module3.js'}

Запустим в браузере предварительно подключив файл `es-module3.js`, и посмотрим в консоль

````text
esModule1
esModule2
esModule1
esModule2
````

Все успешно работает.

Теперь разберем, как это работает.

В каждом из файлов - мы объявили и экспортировали две переменные причем названия у них в обоих файлах одинаковые.

Так же мы объявили, но не экспортировали функцию `esModuleNotExport`.

Далее в файле `es-module3.js` мы импортировали `import {EsConst as EsConst1, esModule as esModule1} from "./es-module1.js";` переменные из обоих файлов, но под другими названиями, чтобы потом ниже использовать.

Мы получили результат. 

Важно еще понимать, что импортировать не экспортируемую функцию (у нас это `esModuleNotExport`), не получится.

### Экспорт отдельных функций

Для экспорта из файла используется ключевое слово `export`.

````javascript
export function esModule(){
    console.log('esModule');
}
export const EsConst = 'esModule';
````

После этого переменные станут доступны, там где они будут импортированы.

Можно экспортировать любое объявление, например

````javascript
// Массив
export let arr = [];
// Константа
export const AAA = 123;
// Класс
export class U{}
````

### Экспорт списка элементов

Экспортировать можно сразу несколько переменных и функций из файла.

````javascript
function esModule(){
    console.log('esModule');
}

const EsConst = 'esModule';

export {esModule,EsConst};
````

> Если экспортируется функция или класс, точку с запятой в конце не ставят.
{: .prompt-info }

При экспорте списка можно задать имя через `as`, как псевдоним экспортируемой переменной.

### Экспорт по умолчанию

Так же может быть экспорт по умолчанию, если нужно экспортировать только одну функцию.

````javascript
export default function esModule(){
    console.log('esModule');
}
````

Что при этом нужно учитывать:

- Стараться не смешивать экспорт по умолчанию и экспорт по имени, это делает код запутаннее.
- Если в файле стоит экспорт по умолчанию, то имя можно не задавать.
- В файле экспорт по умолчанию может быть только один.

### Импорт 

Импорт осуществляется с помощью конструкции `import`, где нужно указать из какого файла они будут импортированы.

````javascript
import {EsConst, esModule} from "./es-module1.js";
````

> Если код будет работать в браузере, важно, чтобы у импортируемого файла было расширение `js`.
{: .prompt-info }

Процесс импорта браузером, последовательно происходит примерно так:

- Парсинг подключаемого файла
- Асинхронная загрузка импортируемых файлов
- Подключение кода к исполняемому файлу
- Исполнение кода

#### Особенности импорта

- Импорт файла происходит по его `URL` адресу с использованием абсолютной, относительной или полной записи, если импортировать так `import {EsConst} from "es-module1.js"` будет ошибка.
- Можно импортировать определенные элементы из экспортируемого файла.
- Для разрешения конфликтов можно давать псевдонимы импортируемым функциям, например

````javascript
import {EsConst as EsConst1, esModule as esModule1} from "./es-module1.js";
import {EsConst as EsConst2, esModule as esModule2} from "./es-module2.js";
````

- Можно импортировать все доступные методы в виде объекта, например

````javascript
import * as test from './test.js';
// доступ test.one test.two
````

- Модуль может быть экспортирован по умолчанию, если из файла экспортируется он один, к примеру

````javascript
// Экспорт
export default function esModule(){
    console.log('esModule1');
}
// Импорт
import esModule from "./es-module1.js";
````
