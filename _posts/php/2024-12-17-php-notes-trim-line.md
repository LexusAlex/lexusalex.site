---
title: Обрезать строку в php
description: >-
  Способы как можно обрезать строку в php на заданное количество символов
author: alex
date: 2024-12-17 12:40:00 +0300
categories: [Php, Notes]
tags: [php]
image:
  path: /assets/img/posts/main/php-words.webp
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: Обрезать строку в php
---

Частая операция с которой сталкивается программист - это обрезание строки на определенное количество символов.

Например, исходная строка и строка до которой ее нужно обрезать.

Часто работаю именно с кирилицей, поэтому рассмотрю именно ее.

````text
Строка которую нужно обрезать
Строка кот
````

## Способ 1 - просто цикл

Решение в лоб, это перебрать строку по-символьно, например:

````php
$str = 'Строка которую нужно обрезать';
$i = 0;
$result = '';
while ($i < mb_strlen($str, 'UTF-8')) {
    if ($i < 10) {
        // Вытаскиваем один символ по указанному ключу в строке
        $result .= mb_substr($str, $i, 1, 'UTF-8');
    }
    $i++;
}

$result; // Строка кот
````

Получили нужный нам результат, но выглядит громоздко, попробуем улучшить решение.

## Способ 2 - mb_str_split

Воспользуемся функцией `mb_str_split`, которая преобразует строку в массив.

````php
$str = 'Строка которую нужно обрезать';
$result = '';
foreach (mb_str_split($str) as $key => $value) {
    if ($key < 10) {
        $result .= $value;
    }
}

$result; // Строка кот
````

Уже лучше, но тоже громоздко.

## Способ 3 - mb_substr

Теперь воспользуемся `mb_substr`, которая вернет нужную нам подстроку.

````php
$str = 'Строка которую нужно обрезать';
$result = mb_substr($str,0,10,'UTF-8'); // Строка кот
````

Вот, буквально в одну строчку получили нужный результат.

## Способ 4 - mb_strimwidth

Воспользуемся `mb_strimwidth`.

````php
$str = 'Строка которую нужно обрезать';
$result = mb_strimwidth($str, 0, 10); // Строка кот
````

Решение в одну строку.

## Способ 5 - preg_match

Так же очень много вещей можно сделать с помощью регулярных выражений.

````php
preg_match('/^[а-яА-Я ]{10}/u',$str,$matches);
$matches[0]; // 'Строка кот'
````

В нашем случае мы адаптировали регулярку под нашу задачу.
