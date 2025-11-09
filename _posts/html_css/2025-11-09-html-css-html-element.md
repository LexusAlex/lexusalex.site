---
title: Элемент html
description: >-
  Корневой элемент страницы html
author: alex
date: 2025-11-09 12:30:00 +0300
categories: [Html]
image:
  path: /assets/img/posts/main/html.png
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: Корневой элемент страницы html
---

## Основные понятия

Элемент `<html>` представляет собой контейнер (элемент верхнего уровня, корневой элемент) для всех остальных элементов которые могут быть на странице.

Элемент определяет начало и конец документа, он должен идти сразу после декларации [Doctype](https://lexusalex.site/posts/html-css-doctype/)

В каждом `html` документе может быть только один элемент `<html>`.

`<html>` поддерживает все глобальные атрибуты.

Браузеры используют `<html>` для определения корневого контекста. `CSS` свойства, примененные к `<html>`, влияют на размеры всей страницы.

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

Обычно атрибуты для элемента `<html>` указывают для служебной информации.

Если написать текст и открыть его в браузере, то браузер сам добавит тег `<html>`.

Внутри тега `<html>` должны быть элементы `<head>` и `<body>`.

Открывающие и закрывающие теги `<html>` могут быть опущены если первое что находится внутри не является комментарием.

Рекомендуется указывать атрибут `lang`, это помогает электронным читалкам правильно определять язык документа.
Так же это влияет на отображение текста и работу браузерных функций (перевод, проверка орфографии).

## Стили по умолчанию

`<html>` элемент имеет стили по умолчанию которые заданы в браузерах.

````css
html {
  unicode-bidi: isolate; /*Контроль над смешанным направлением текста*/
  display: block; /*Элемент является блочного контекста*/
  outline-style: none; /* Полное удаление контура элемента*/
}
````

## Доступ из javascript

Получить `<html>` элемент можно так

````javascript
document.documentElement //<html lang="en">
````

Можно сказать что выше `<html>` элемента (кроме `doctype`), ничего нет

````javascript
document.parentElement // null
````

С точки зрения `DOM` `<html>` представляет собой интерфейс `HTMLHtmlElement`.

И наследуется от элементов, сверху вниз.

- `HTMLHtmlElement`
- `HTMLElement`
- `Element`
- `Node`
- `EventTarget` 

Свойства и методы будут наследоваться по цепочке от этих объектов.

Например, сделаем так, чтобы размер шрифта элемента `<html>` менялся динамически при изменении размера экрана.

````javascript
// Динамическое изменение размера шрифта
function adjustFontSize() {
  const width = window.innerWidth;
  document.documentElement.style.fontSize = width < 768 ? '14px' : '16px';
}
window.addEventListener('resize', adjustFontSize);
````

Установка `height: 100%` часто требуется для корректного отображения дочерних элементов.

## Ссылки

- [Спецификация](https://html.spec.whatwg.org/multipage/semantics.html#the-html-element)
