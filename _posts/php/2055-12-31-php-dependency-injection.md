---
title: Контейнер внедрения зависимостей в php
description: >-
   Изучаем что такое контейнер внедрения зависимостей в php. Библиотека php di
author: alex
date: 2055-12-31 20:30:00 +0300
categories: [Php, Libraries]
tags: [php]
image:
  path: /assets/img/posts/php1.png
  alt: Контейнер внедрения зависимостей в php
---

В статье [https://lexusalex.site/posts/php-application-configuration-using-the-example-of-laminas-config-aggregator/](https://lexusalex.site/posts/php-application-configuration-using-the-example-of-laminas-config-aggregator/) мы собрали конфигурацию

Теперь нам нужен удобный способ умно доставать данные из конфигурации. Но сначала к теории.

## Функция полностью зависящая от аргументов

Имеем функцию `sum`, которая полностью зависит от своих входящих параметров, она возвращает результат в виде суммы двух чисел.

````php
$sum = function ($num1, $num2) {
    return $num1 + $num2;
};

print_r($sum(1,2)); // 3
print_r($sum(1,2)); // 3
print_r($sum(8,2)); // 10
````

Вроде ничего необычного, обычная самодостаточная функция, которой не требуется внешних зависимостей. Но это не всегда так.

> Функция результат которой полностью зависит от своих аргументов, называется чистой функцией. 
{: .prompt-info }

## Зависимости

Функции, чтобы работать, иногда может потребоваться другая функция, класс или модуль, это и есть зависимость.

Перепишем нашу функцию `sum` добавим ей зависимость в виде другой функции.

````php
// Функция умножения числа на само себя
$multiply = function ($num) {
  return ($num * $num);
};

// Функция складывает умноженные друг на друга числа
$sumAndMultiply = function ($num1, $num2) use ($multiply) {
    return  $multiply($num1) + $multiply($num2);
};

print_r($sumAndMultiply(1,2)); // 5
print_r($sumAndMultiply(1,2)); // 5
print_r($sumAndMultiply(8,2)); // 68
````

В результате получилась функция `sumAndMultiply`, которая уже зависит от функции `multiply`.

Сделаем то же самое с классами.

````php
class Multiply
{
    public function m($num)
    {
        return ($num * $num);
    }
}

class sumAndMultiply
{
    public function sm ($num1, $num2): float|int
    {
        $multiply = new Multiply(); // Внедрение зависимости
        return ($multiply->m($num1) + $multiply->m($num2));
    }
}

$sm = new sumAndMultiply();
print_r($sm->sm(1,2)); // 5
print_r($sm->sm(1,2)); // 5
print_r($sm->sm(8,2)); // 8
````

По сути ничего не поменялось, результат такой же, но зависимость внедряется немного по-другому.

А именно вот здесь в методе `sm` строка `$multiply = new Multiply();`

````php
public function sm ($num1, $num2): float|int
  {
      $multiply = new Multiply(); // Внедрение зависимости
      return ($multiply->m($num1) + $multiply->m($num2));
  }
````

Какие проблемы тут могут быть:

Например, метод `m()` может иметь свои собственные зависимости, например подключение в базе данных, а само подключение к бд свои параметры, нужно от этого избавляться.

Получается жестко зашитые зависимости внутри метода или функции. Как это решить. Нужно передать зависимость снаружи, для этого перепишем код с классом.

````php
class Multiply
{
    public function m($num)
    {
        return ($num * $num);
    }
}

class sumAndMultiply
{
    // Передаем зависимость как параметр метода
    public function sm ($num1, $num2, Multiply $multiply): float|int
    {
        return ($multiply->m($num1) + $multiply->m($num2));
    }
}

$multiply = new multiply();
$sm = new sumAndMultiply();
print_r($sm->sm(1,2,$multiply)); // 5
print_r($sm->sm(1,2,$multiply)); // 5
print_r($sm->sm(8,2,$multiply)); // 8
````

Аналогично перепишем теперь код с функцией

````php
// Функция умножения числа на само себя
$multiply = function ($num) {
    return ($num * $num);
};

// Функция складывает умноженные друг на друга числа
$sumAndMultiply = function ($num1, $num2, $multiply) {
    return  $multiply($num1) + $multiply($num2);
};

print_r($sumAndMultiply(1,2, $multiply)); // 5
print_r($sumAndMultiply(1,2, $multiply)); // 5
print_r($sumAndMultiply(8,2, $multiply)); // 68
````

Из этих двух примеров видно, что мы все зависимости передаем снаружи функции, чем создавать их сразу внутри. И это хорошая практика.


https://elisdn.ru/blog/148/dependency-injection




Практическое использование контейнера внедрения зависимостей очень важно для гибкости и надежности кода.

https://habr.com/ru/articles/327746/
https://habr.com/ru/articles/655399/
https://github.com/codedokode/pasta/blob/master/arch/di.md
http://yugeon-dev.blogspot.com/2010/07/inversion-of-control-containers-and_21.html
