---
title: Про типы и структуры данных в javascript
description: >-
  Погружение в типы данных в javascript
author: alex
date: 2055-12-31 22:40:00 +0300
categories: [Javascript,Types]
tags: [javascript,types]
image:
  path: /assets/img/posts/javascript.png
  alt: Про типы данных в javascript
---

## Примитивные типы данных

Это неизменяемые значения хранимые в памяти и представленные в javascript на низком уровне.

### number
 
Number - это 64 битное число двойной точности с плавающей запятой.

> В других языках программирования числовые типы могут быть представлены как `integer`, `float`, `double`, `bignum`
{: .prompt-info }

### null
### undefined
### boolean
### string
### bigint
### symbol

## Ссылочные типы данных

Это области памяти неопределенного размера доступные по ссылке на эту область памяти.

### Object

Object - изменяемый тип данных. Это значит, что в переменной хранится не само значение объекта, а только ссылка-идентификатор.
Если мы работаем с объектом, мы меняем его содержимое в области памяти, но ссылка на эту область остается прежней.

Объект будет в памяти если есть активная ссылка на него.

### Function
### Array


https://developer.mozilla.org/ru/docs/Web/JavaScript/Data_structures
https://blog.frontend-almanac.ru/5688-ygxnVD

Про преобразование типов https://fruntend.com/manuals/preobrazovanie-tipov-dannykh


