---
title: Использование Promise
description: >-
  Promise базовый способ работать с отложенными вычислениями
author: alex
date: 2055-08-24 15:00:00 +0300
categories: [Html]
image:
  path: /assets/img/posts/main/html.png
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: Promise базовый способ работать с отложенными вычислениями
---

## Кратко

`Promise` - это специальный объект для выполнения отложенных асинхронных операций, результат которого возврщается в некоторый момент в будущем.

По умолчанию `Promise` находится в режиме ожидания, через некоторое время он будет разрешен либо отклонен.

Асинхронная операция, это любое действие которое не выполняется мгновенно, как раз `Promise` представляет будущий результат такой операции, он сам по себе будет возвращен, результат операции придет позже.

Многи `api используют `Promise`, поэтому он считается базой которую нужно знать. Он как контейнер для конечного результата.

В качестве сравнения, проведем аналогию между событиями и промисами. Обработчики событий выполненются несколько раз, в то время как `then` выполеняется только один раз, то есть можно сказать `Promise` - это одноразовая операция.
При вызове `then` результат будет получен, а при событии если обработчик не был навешен оно просто потеряется. В `Promise` уже встроен обработчик ошибок, в событиях их нужно обрабатывать отдельно.

## 


https://developer.mozilla.org/ru/docs/Web/JavaScript/Reference/Global_Objects/Promise
https://learn.javascript.ru/async
https://doka.guide/js/promise/
