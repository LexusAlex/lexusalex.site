---
title: Декларация DOCTYPE
description: >-
  подробнее о декларации DOCTYPE в html
author: alex
date: 2025-10-26 22:00:00 +0300
categories: [Html]
image:
  path: /assets/img/posts/main/html.png
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: подробнее о декларации DOCTYPE в html
---

## Режимы отображения

Сейчас существуют три режима отображения веб-страницы

- `quirks mode` - режим совместимости.
- `almost standards mode` - частично стандартный режим.
- `full standards mode` - стандартный режим.

Режим совместимости `quirks mode` нужен для эмуляции работы старых браузеров например `Navigator 4` и `Internet Explorer 5`.
В стандартном режиме `full standards mode` браузер ведет себя в соответствии со спецификациями `W3C`. `almost standards mode` - это нечто
между `quirks mode` и `full standards mode`, он был введён для решения проблем совместимости со старыми веб-стандартами.

## DOCTYPE

Браузеры используют специальную декларацию `<!DOCTYPE html>`, чтобы определить в каком режиме обрабатывать документ. Тогда документ будет отображаться в стандартном режиме (`full standards mode`).
Использование этой декларации рекомендовано стандартом `html 5`.

Необходимо размещать декларацию `<!DOCTYPE html>` в самом начале документа, это было сделано для упрощения и унификации режимов рендеринга в `html 5`.

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

## Для чего нужен DOCTYPE

1. Активирует `full standards mode` режим отображения страниц по стандартам `W3C`.
2. Совместимость со всеми современными браузерами. Без этой декларации браузеры могут отобразить элементы страницы некорректно. 
3. [Валидартор](https://validator.w3.org) от `W3C` определяет по `DOCTYPE` режим по которому валидировать документ.
4. Без `DOCTYPE` браузеры могут некорректно обрабатывать `css`, игнорировать новые теги, искажать верстку.

`DOCTYPE` можно писать в любом регистре, но принято писать так <!DOCTYPE html>

## Доступ из javascript

Браузер создает `DOM` модель документа при загрузке страницы и `DOCTYPE` является ее частью.

````javascript
document.doctype // Это объект DocumentType
document.doctype.name // "html" Имя корневого элемента 
document.doctype.systemId  // "" Системный идентификатор
document.doctype.publicId  // "" Публичный идентификатор
````

Если декларации в документе нет, вернется `null`.

Для `html5` свойства `publicId` и `systemId` всегда пустые.

Если рассматривать иерархию элементов страницы `DocumentType` является первым дочерним узлом страницы, но не является элементом. То есть тип элемента `nodeType=10`.

Может быть полезно при проверке на валидность документа.
