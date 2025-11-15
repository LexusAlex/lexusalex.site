---
title: Глобальные атрибуты. class
description: >-
  Атрибут class в html
author: alex
date: 2025-11-04 22:00:00 +0300
categories: [Html]
image:
  path: /assets/img/posts/main/html.png
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: Атрибут class в html
---

## Определения

`class` является фундаментальным атрибутом используемых в `html` элементах.

> `class` является глобальным атрибутом и может быть указан во всех html элементах
{: .prompt-info }

Если `class` присутствует, он должен иметь значение представляющий набор маркеров разделенных пробелом.

Нет никаких дополнительных ограничений на имена классов, имя может быть произвольным, но все же рекомендуется использовать осмысленные имена.

Используя `class` мы имеем доступ к элементу через [`css`](https://lexusalex.site/posts/html-css-selectors/#%D1%81%D0%B5%D0%BB%D0%B5%D0%BA%D1%82%D0%BE%D1%80-%D0%BA%D0%BB%D0%B0%D1%81%D1%81%D0%B0-) и управление элементами через `javascript`.

Точка `.` в `css` является признаком класса.

````html
<header class="card-header"></header>
````

## Особенности имен классов

- Имя класс может быть любым, но рекомендуется использовать латинские слова и писать их в нижнем регистре.
- Если слов несколько, разделять их с помощью тире или знака подчеркивания.
- В названии класса лучше не использовать больше трех слов.
- В названии так же не рекомендуют использовать цифры (`text1`).
- В имени класс не должна быть отсылка на контекст или внешний вид элемента, так как он может измениться, не привязывайтесь к тегу или контексту использования

## Примеры названий классов

- `btn btn-primary`
- `btn--primary`
- `nav__link--active`
- `container`
- `main-text`
- `sub-text`
- `button__text`
- `cards__container-item`
- `error-message`
- `form-group`
- `is-open`
- `col-6`
- `mt-4`
- `icon--search`
- `alert alert--error`

## Доступ через javascript

Стандартный способ получить список и как то им управлять потом - это `querySelectorAll`;

````html
<div class="a b">1</div>
<div class="a b">2</div>
<div class="a c">3</div>
<div class="d">4</div>
````

Получаем список элементов

````javascript
document.querySelectorAll('.a') // NodeList(3) [ div.a.b, div.a.b, div.a.c ]
document.querySelectorAll('.b') // NodeList [ div.a.b, div.a.b ]
document.querySelectorAll('.d') // NodeList [ div.d ]
document.querySelectorAll('.z') // NodeList []
document.querySelectorAll('.a.b') // NodeList [ div.a.b, div.a.b ]
````

Еще можно использовать `getElementsByClassName` тогда уже вернется коллекция элементов

Здесь можно точку не писать метод и так понимает, что работает с классами.

````javascript
document.getElementsByClassName('a') // HTMLCollection { 0: div.a.b, 1: div.a.b, 2: div.a.c, length: 3 }
document.getElementsByClassName('b') // HTMLCollection { 0: div.a.b, 1: div.a.b, length: 2 }
document.getElementsByClassName('d') // HTMLCollection { 0: div.d, length: 1 }
document.getElementsByClassName('z') // HTMLCollection { length: 0 }
document.getElementsByClassName('a b') // HTMLCollection { 0: div.a.b, 1: div.a.b, length: 2 }
````

Изменение класса является одной из самой распространенной операцией на странице.

Например, у элемента `body` сейчас два класса `main main-index`.

````javascript
// Получить имя класс у элемента body
document.body.className // "main main-index"
// Присвоить новое имя
document.body.className = "test" // "test"
````

Для манипуляции с классами используют специальный объект `classList`. Это более удобный способ работы с классами, нежели просто со строкой

Получаем коллекцию токенов элемента

````javascript
// Текущая коллекция токенов
document.body.classList // DOMTokenList [ "main", "main-index" ]
// Если нет классов у элемента
document.body.classList //DOMTokenList []
// Добавить класс
document.body.classList.add('main2') // main main-index main2
// Удалить класс
document.body.classList.remove('main2') // main main-index
// Добавить/удалить если он есть или его нет.
document.body.classList.toggle('main2') // true
document.body.classList.toggle('main2') // false
// Проверка наличния класса
document.body.classList.contains('main') // true
// Добавить сразу несколько классов
document.body.classList.add("c1","c2","c3")
// Удалить сразу несколько классов
document.body.classList.remove("c1","c2","c3") 
// Замена класса другим
document.body.classList.replace("main","main4") // true
// Заменить класс в зависимости от условия
document.body.classList.toggle("main", window.innerWidth < 1000) // true
````

## Полезные ссылки

- [https://html.spec.whatwg.org/multipage/dom.html#classes](https://html.spec.whatwg.org/multipage/dom.html#classes)
