---
title: Добавление обработчиков события с методом addEventListener()
description: >-
  Как добавить события на страницу с addEventListener()
author: alex
date: 2055-08-24 15:00:00 +0300
categories: [Html]
image:
  path: /assets/img/posts/main/html.png
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: Как добавить события на страницу с addEventListener()
---

Рассмотрим подробнее метод навешивания события `addEventListener()`

>В [обзорной статье](https://lexusalex.site/posts/html-css-events/#%D0%BE%D0%BF%D1%80%D0%B5%D0%B4%D0%B5%D0%BB%D0%B5%D0%BD%D0%B8%D0%B5-%D0%BE%D0%B1%D1%80%D0%B0%D0%B1%D0%BE%D1%82%D1%87%D0%B8%D0%BA%D0%B0-%D1%81-%D0%BF%D0%BE%D0%BC%D0%BE%D1%89%D1%8C%D1%8E-%D0%BC%D0%B5%D1%82%D0%BE%D0%B4%D0%B0-addeventlistener) я уже упоминал об `addEventListener()`, сегодня рассмотрим это подробнее.
{: .prompt-info }

## Основные понятия

`addEventListener()` метод который можно вызвать у элемента, документа или `Window`.

`addEventListener()` устанавливает функцию, которая будет вызываться каждый раз когда событие сработает.

Метод `addEventListener()` позволяет назначить обработчик события определенному событию на элементе `DOM`.

Метод `addEventListener()` является рекомендуемым способом регистрации обработчиков.

Что это нам дает: 

- Дает возможность регистрировать несколько обработчиков одного события на одном элементе.
- Дает более точный контроль над исполнением события, путем контроля фаз события.


https://habr.com/ru/companies/timeweb/articles/940722/

https://doka.guide/js/element-addeventlistener/

https://learn.javascript.ru/bubbling-and-capturing
