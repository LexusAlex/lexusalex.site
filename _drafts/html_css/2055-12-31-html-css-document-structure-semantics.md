---
title: Структура документа. Семантика
description: >-
  Семантика в html
author: alex
date: 2055-10-19 17:00:00 +0300
categories: [Html]
image:
  path: /assets/img/posts/main/html.png
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: Семантика в html
---

## Что такое семантика

Начнем с базовых определений, сайт - это совокупность страниц, страница - это то что доступно пользователю (с применением js и `css`), документ - это то что получил клиент у которого не подгрузились стили.  

Семантика в документе - это некое отношение символов (тегов) и то что они обозначают, то есть некая совокупность смысловых отношений.

Чтобы создать семантически верный документ нужно правильно применять html элементы, именовать (классы и идентификаторы) и комбинировать их.

У каждого элемента есть свои общепринятые функции



Структурные роли элементов не наследуются, а компонуются, каждый отвечает за свою часть общей задачи. Элемент <a> никак не влияет на семантику содержимого <header> за исключением того, что делает его заодно еще и кликабельной ссылкой. А <div> не влияет на нее вообще никак и нужен чисто для оформительских или скриптовых задач, для чисто визуальной группировки никак иначе не связанных между собой элементов. В примере в обоих случаях группировка двух абзацев чисто визуальная, поэтому, если <a> с нужными стилями и так справляется с ней без посторонней помощи, добавлять <div> не нужно.

https://css-live.ru/articles/blok-sxema-sekcionirovaniya-elementov-html5.html
https://css-live.ru/articles/dolgovremennaya-veb-semantika.html
https://css-live.ru/articles/ponimanie-semantiki.html
https://css-live.ru/articles/pochemu-semanticheskij-html-vazhen-i-kak-typescript-pomogaet-eto-ponyat.html
https://htmlacademy.ru/blog/html/semantics
https://doka.guide/html/semantics/
https://habr.com/ru/articles/892516/
https://html.spec.whatwg.org/multipage/dom.html#semantics-2
