---
title: Элемент body
description: >-
  Корневой элемент страницы html
author: alex
date: 2055-11-09 12:30:00 +0300
categories: [Html]
image:
  path: /assets/img/posts/main/html.png
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: Корневой элемент страницы html
---

## Основные понятия

`body` первый секционный элемент на странице.

`body` содержит весь видимый контент страницы, то есть содержимое документа.

В документе может быть только один элемент `body`.

````html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Title</title>
</head>
<body>

</body>
</html>
````

Элемент `body` должен идти сразу после элемента `head`.

Можно не писать тег `body` браузер его добавит сам, но лучше всегда его явно задавать, чтобы не было недоразумений.

`body` не принадлежит не одной из категорий контента, но является секционным элементом.

Некоторые операции с `DOM` работают только с элементом `body`.

`body` так же содержит специфичные события только для этого элемента.


## Доступ из javascript

const bodyElement = document.body;
console.log(bodyElement); // Выведет <body>...</body>

const bodyElement = document.getElementsByTagName('body')[0];

// Создание и добавление нового элемента
const newDiv = document.createElement('div');
newDiv.textContent = 'Новый блок!';
document.body.appendChild(newDiv);

// Удаление последнего дочернего элемента
if (document.body.lastChild) {
document.body.removeChild(document.body.lastChild);
}

// Событие при клике на body
document.body.addEventListener('click', () => {
alert('Вы кликнули на body!');
});

// Событие при загрузке страницы
window.addEventListener('load', () => {
console.log('Страница полностью загружена!');
});

// Установка кастомного атрибута
document.body.setAttribute('data-theme', 'light');

// Получение значения атрибута
console.log(document.body.getAttribute('data-theme')); // "light"

document.addEventListener('DOMContentLoaded', () => {
// Код с document.body здесь
});

window.addEventListener('load', () => {
console.log('Все ресурсы загружены!');
});

## Ссылки

- [Спецификация](https://html.spec.whatwg.org/multipage/sections.html#the-body-element)
