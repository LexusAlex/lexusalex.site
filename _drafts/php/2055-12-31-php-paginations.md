---
title: Пагинация или постраничный вывод на php
description: >-
  Пишем простой класс для пагинации на php
author: alex
date: 2055-12-17 12:40:00 +0300
categories: [Php, Notes]
tags: [php]
image:
  path: /assets/img/posts/main/paginations.png
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: Пагинация на php
---

## Постраничный вывод

Напишем простой класс для пагинации страниц на `php`.

Напомню, что пагинация или постраничный вывод - это разделение контента на страницы, для показа.

Если контента очень много рано или поздно встает вопрос о постраничном выводе его.

Цель заметки показать механику пагинации.

## Составляющие постраничного вывода

Для того чтобы нам написать класс, нужно понять что включает в себя постраничный вывод, что нам нужно для этого.

- `total` - всего элементов в массиве
- `pages` - всего страниц
- `items` - элементов на странице
- `page` - текущая страница
- `url` - пусть в адресной строке

## Набор данных

Данные могут приходить откуда угодно, это не важно.

У нас к примеру будет следующий набор данных:

## Считаем сколько всего страниц

Первое, что казалось бы нужно посчитать сколько всего страниц у нас будет

## Собираем страницы

https://github.com/jasongrimes/php-paginator/blob/master/src/JasonGrimes/Paginator.php#L81



