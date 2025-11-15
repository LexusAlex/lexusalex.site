---
title: Глобальные атрибуты. id
description: >-
  Атрибут id в html
author: alex
date: 2025-11-15 19:30:00 +0300
categories: [Html]
image:
  path: /assets/img/posts/main/html.png
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: Атрибут id в html
---

## Определения

Фундаментальный атрибут `id` определяет уникальный идентификатор элемента (`ID`).

Значение атрибута `id` у элементов должно быть уникальным в пределах документа. То есть на странице не может быть 
два элемента с одинаковыми `id`. 

Атрибут `id` должен содержать хотя бы один символ и в нем не должно быть пробелов, то есть атрибут `my section` не допустим.

Атрибут `id` может содержать символы `-_:.`, и не может содержать символы `!@#$`, например `id` `my@id` не допустим.

Значения атрибута `id` регистрозависимы, то есть `Main` и `main` разные идентификаторы.

Старайтесь придерживаться единого стиля именования идентификаторов на странице.

Если нужно, чтобы идентификаторы повторялись, используйте атрибут [`class`](https://lexusalex.site/posts/html-css-attribute-class/).

> `id` является глобальным атрибутом и может быть указан во всех html элементах
{: .prompt-info }

````html
<body id="body">
123
</body>
````

## Примеры названий идентификаторов

- `main_section`
- `block`
- `contenteditable`
- `main-content`
- `login-form`
- `modal-window`
- `background-audio`
- `comments-block`
- `related-posts`
- `error-container`
- `collapsed-menu`
- `product-card`
- `menu__item--active`
- `card__title`

## Для чего используется id

1. Для стилизации элемента. Из `css` доступ получаем по идентификатору элемента `#body {}`.
2. Для получения доступа к элементу из `javascript` `document.getElementById("main-content");`
3. Позволяет создать якорь ведущий к определенному разделу на странице `<a href="#section2">Перейти к разделу 2</a> <div id="section2">...</div>`
4. Позволяет создать связь с тегом `label` через атрибут `for` `<label for="email">Email:</label> <input type="email" id="email">`

## Доступ из javascript

С помощью метода `getElementById` можно получить доступ к атрибуту `id`, и далее работать с элементом.

````javascript
const button = document.getElementById('button');

button.addEventListener('click', function () {
  alert('Click!');
});
````

> Метод getElementById есть только у объекта document, он ищет id по всему документу.
{: .prompt-info }

Можно получить доступ и так, это считается плохой практикой, и в основном используется для краткости кода.

````javascript
window.b.textContent // b - это идентификатор указанных на одном из элементах страницы
````

Прочитать атрибут можно так

`````javascript
document.body.id // b
`````

Проверить что существует элемент

``````javascript
if (element) {}
``````

Удалить атрибут 

````javascript
document.body.removeAttribute('id') 
````

Например, поменяем текст элемента

````javascript
const header = document.getElementById('header');
if (header) {
  header.textContent = 'Новый заголовок';
}

// Или стразу напрямую
//document.body.textContent = '234234324' 
````

## Ссылки

- [Спецификация](https://html.spec.whatwg.org/multipage/dom.html#the-id-attribute)



