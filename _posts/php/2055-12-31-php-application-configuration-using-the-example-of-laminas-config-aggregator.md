---
title: Конфигурация php приложений на примере laminas-config-aggregator
description: >-
   Рассмотрим библиотеку laminas-config-aggregator, как способ собрать конфигурацию php приложения 
author: alex
date: 2055-12-31 18:00:00 +0300
categories: [Php]
tags: [php]
---

## Что такое конфигурация приложения

Конфигурация приложения - это код, который может меняться. 
Это такой большой массив с настройками базы данных, кешей, валидаторов, логгеров и других вещей.

Элементы которой нужно как-то соединять и использовать.

Если поискать на [https://packagist.org](https://packagist.org) найдем несколько вариантов.

Среди них будет библиотека [laminas-config-aggregator](https://github.com/laminas/laminas-config-aggregator)

## Что такое laminas-config-aggregator

Если зайти в документацию, то можно прочитать, что это библиотека для объединения конфигурации из разных источников.


https://12factor.net/ru/config
