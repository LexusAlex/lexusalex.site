---
title: Модули в javascript
description: >-
  import и export в javascript
author: alex
date: 2055-12-31 18:00:00 +0300
categories: [Javascript,Modules]
tags: [js]
---

Я не эксперт в модулях `javascript`, скорее исследователь. 
Так что статья чисто мое виденье модулей в `javascript`.

Сегодня проясним как вообще мы пришли к современным модулям в `javascript`.

## Свалка файлов

Со временем количество кода и файлов в проекте только растет. 

Когда тысячи `javascript` файлов загружаются в браузер в глобальную область видимости начинается ад.

Чтобы было удобнее всем этим управлять появилась потребность в модульности в `javascript`, ведь первоначально ее не было вообще никакой.

Как же раньше эмулировали модульность в `javascript`.

## Пространство имен

Есть глобальный объект, к нему привязываются, функции, переменные, классы и т.д.

````javascript
var module = {};

module.test = 1;

module.func = function () {
    return 1+1;
}
````

Такой подход решает проблему коллизий имен, но только частично, так что возможны одинаковые имена переменных в глобальном контексте.

## Модуль

Еще был подход с самовызывающийся функцией, как это работает в jquery плагинах, например

````javascript
module.test = (function (){
    // Код приложения
    console.log(123);
})(module.test);
````

По сути это самодостаточный модуль, который будет вызван сразу же после запуска.







https://habr.com/ru/companies/otus/articles/798455/
https://www.dev-notes.ru/articles/javascript-complete-guide-to-modules/
https://doka.guide/js/modules/
https://learn.javascript.ru/modules

https://zhurov.me/blog/modular-javascript.html

https://www.youtube.com/watch?v=vA5iT8rN5HU
