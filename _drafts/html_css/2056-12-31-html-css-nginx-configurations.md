---
title: Nginx. Принципы работы
description: >-
  Разберем принципы работы веб-сервера nginx
author: alex
date: 2056-01-02 23:30:00 +0300
categories: [Html,nginx]
image:
  path: /assets/img/posts/main/html.png
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: Разберем принципы работы веб-сервера nginx
---

## Конфигурация

Конфигурация `nginx` состоит из директив. Они позволяют внутри себя указывать другие директивы.

Директивы могут быть простые и блочные. Простая директива - это просто имя и значение, а блочная директива - это название с набором инструкций в `{}`

Внутри блочной директивы можно задавать и другие директивы, это называется контекстом. Есть директивы в глобальной области видимости, они располагаются в контексте `main`. 

Виртуальный сервер - это технический кусочек конфигурации `nginx` директива `server` в контексте `http`.

Каким образом `nginx` понимает какой виртуальный хост нужен клиенту. По заголовку `Host`.


