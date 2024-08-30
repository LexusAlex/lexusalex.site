---
title: Контейнер внедрения зависимостей в php
description: >-
   Изучаем что такое контейнер внедрения зависимостей в php. Библиотека php di.
author: alex
date: 2055-12-31 20:30:00 +0300
categories: [Php, Libraries]
tags: [php]
image:
  path: /assets/img/posts/php1.png
  alt: Контейнер внедрения зависимостей в php
---

В статье [https://lexusalex.site/posts/php-application-configuration-using-the-example-of-laminas-config-aggregator/](https://lexusalex.site/posts/php-application-configuration-using-the-example-of-laminas-config-aggregator/) мы собрали конфигурацию

Теперь нам нужен удобный способ умно доставать данные из конфигурации.

## Функция зависящая от своих параметров

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

// Функция складывает умноженны е друг на друга числа
$sumAndMultiply = function ($num1, $num2, $multiply) {
    return  $multiply($num1) + $multiply($num2);
};

print_r($sumAndMultiply(1,2, $multiply)); // 5
print_r($sumAndMultiply(1,2, $multiply)); // 5
print_r($sumAndMultiply(8,2, $multiply)); // 68
````

Из этих двух примеров видно, что мы все зависимости передаем снаружи функции, чем создавать их сразу внутри. 

И это хорошая практика.

Мы передаем все зависимости снаружи, и теперь мы можем создать классы поочередно передав их друг в друга.

Но вручную может быть сложно создавать и следить за всеми зависимостями.

Итак, внедрение зависимостей - это передача зависимостей в класс из вне.

Хороший метод или функция получает значение через аргументы или конструктор.

## Контейнер

Контейнер - это отдельный сервис в который можно положить зависимости и достать их оттуда не парясь о зависимостях.
Это такой класс который отвечает за создание нужных нам сервисов, например:

````php
$container = new Container();
// Положить в контейнер
$container->set(Multiply::class, function (){ return (new Multiply)});
// Достать из контейнера
$container->get(Multiply::class)
````

Но в ручную мы редко когда достаем зависимость, обычно это делает фреймворк.

Преимуществом контейнера является, то, он не будет дублировать уже созданные объекты. А хранить их в одном экземпляре и возвращать их тогда, когда они понадобятся.

Большинство современных контейнеров поддерживают `autowiring` - это автоматический парсинг параметров, когда вручную не нужно создавать все объекты, они будут созданы автоматически.

### Как это работает

Рассмотрим пример. Здесь у нас функция `sum` с тремя параметрами, второй параметр функция, которую мы объявили ниже, как `$function`

````php
$sum = function ($num1, $function, $num2) {
    return $function($num1) + $num2;
};

$function = function ($num) {
  return ($num + $num);
};

print_r($sum(2, $function, 2)); // 6
print_r($sum(3, $function, 3)); // 9
````

То же самое с классами 

````php
class Sum
{
    public function s($num1, Func $function, $num2)
    {
        return ($function->f($num1) + $num2);
    }
}

class Func
{
    public function f($num)
    {
        return ($num + $num);
    }
}

print_r((new Sum())->s(2, (new Func()), 2)); // 6
print_r((new Sum())->s(3, (new Func()), 3)); // 9
````

Здесь мы напрямую все зависимости передаем в метод, вместе с обычными данными, можно работать и так, но их тогда придется передавать каждый раз заново.

Перепишем примеры выше

````php
function createSum($func): Closure
{
    return function ($num1, $num2) use ($func) {
        return $func($num1) + $num2;
    };
}

$function = function ($num) {
    return ($num + $num);
};

$sum = createSum($function);

echo $sum(2,2); // 6
echo $sum(3,3); // 9

// И классы
class Sum
{
    private Func $func;

    public function __construct(Func $func) {
        $this->func = $func;
    }

    public function s ($num1, $num2) {
        return $this->func->f($num1) + $num2;
    }
}

class Func
{
    public function f($num)
    {
        return ($num + $num);
    }
}

echo (new Sum(new Func()))->s(2,2); // 6
echo (new Sum(new Func()))->s(3,3); // 9
````

Чтобы каждый раз не передавать зависимость, мы передали ее один раз. В класс мы передали параметр в конструктор.

Таким образом, чтобы передавать только параметры. 

Зависимости достаточно определить один раз, и использовать для всех объектов.

````php
// Объект Func передаем в конструктор Sum(), как зависимость, а функция s работает с чистыми параметрами. 
(new Sum(new Func()))->s(2,2);)
````

## Как нам работать с этим в коде

https://elisdn.ru/blog/150/entity-dependencies

## Библиотека php-di


Практическое использование контейнера внедрения зависимостей очень важно для гибкости и надежности кода.

https://habr.com/ru/articles/327746/
https://habr.com/ru/articles/655399/
https://github.com/codedokode/pasta/blob/master/arch/di.md
http://yugeon-dev.blogspot.com/2010/07/inversion-of-control-containers-and_21.html
