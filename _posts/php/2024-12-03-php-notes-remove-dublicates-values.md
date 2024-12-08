---
title: Удаление дублирующих значений из строки php
description: >-
  Удалить дубликаты значений из строки php
author: alex
date: 2024-12-03 13:10:00 +0300
categories: [Php, Notes]
tags: [php]
image:
  path: /assets/img/posts/main/box.webp
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: Удаление дублирующих значений из строки php
---

Иногда возникает задача удаления дублирующих значений из строки.


## Способ 1

Здесь напрашивается алгоритм:

- Разбить строки в массив по разделителю
- Выбрать уникальные значения массива
- Создать строку обратно

````php
implode(',',array_unique(explode(',', 'значение1,значение2,значение3,значение1')) 
// значение1,значение2,значение3
````

Еще разделить может быть другим, да еще с пробелами:

````php
implode(';',array_unique(explode(';',preg_replace('/\s+/','',' 79077777777; 34; 79077777777; 79077777777; 79077777777; 79077777777; 79077777777; 79077777777; 79077777777; 79077777777; 79077777777; 79077777777'))));
//79077777777;34
````

Здесь мы еще с помощью `preg_replace` почистили пробелы в строке.

## Способ 2

Еще можно воспользоваться особенностью массивов, а именно перемешать значения и ключи.

В итоге вытащить ключи и преобразовать в строку.

````php
implode(',', array_keys(array_flip(explode(',', 'значение1,значение2,значение3,значение1'))));
// значение1,значение2,значение3
````
