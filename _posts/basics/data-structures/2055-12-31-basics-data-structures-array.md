---
title: Структуры данных. Массив
description: >-
  Посмотрим на операции работы с массивом.
author: alex
date: 2055-08-01 18:00:00 +0300
categories: [Basics,Data-structures]
tags: [array,data-structure,javascript]
image:
  path: /assets/img/posts/array.webp
  alt: Структуры данных. Массив
---

## Что такое массив

Массив - это структура данных которая хранит список элементов (коллекцию), строки, числа объекты и прочее.
Массив очень полезен во многих ситуациях, и практически во всех языках программирования, он присутствует.

Пример массива:

````javascript
let array1 = [1,2,3,4,5];
let array2 = ['значение 1', 'значение 2'];
````
> Язык примеров не имеет значения, он может быть любым. Я показываю примеры на javascript, например.
{: .prompt-info }
 
## Особенности

- Под **размером** массива понимается количество элементов в нем.
- **Индекс** - это позиция элемента в массиве. В большинстве языков программирования индекс массива начинается с `0`

## Операции над массивом

> Важно понимать, что при выполнении операций над массивом мы учитываем не количество времени, а число шагов, которое требуется на выполнение операции.
{: .prompt-info }

### Чтение

Чтение массива - это получение определенного элемента по его индексу.

При объявлении массива выделяется непрерывный блок памяти из пустых ячеек. У каждой ячейки памяти есть определенный адрес.

Например:

````javascript
let array =           [1,   2,   3,   4,   5];
// индекс               0    1    2    3    4
// адрес ячейки памяти  1000 1001 1002 1003 1004
````

При считывании значения по индексу компьютеру легко обратится к определенному адресу памяти за **один шаг**. 
В этом случае поиск не будет произведен. 

При выделении блока памяти под массив, отмечается его начало, то есть с какой ячейки памяти он начинается. 

В примере выше допустим нужен элемент с индексом `2`, тогда получим к ней доступ `array[2]`.
Так, как индекс начинается с `0` и с ячейки `1000` а нам нужен второй, тогда `1000 + 2 = 1002`, что соответствует значению `3`.

В итоге операция чтения массива, самая быстрая операция в массиве.

### Поиск

Поиск элемента с конкретным значением в массиве.

По сути эта операция обратна чтению, то есть мы просим по значению вернуть индекс элемента.

На поиск требуется больше времени, чем на чтение.

> Компьютер понятия не имеет какие значения содержатся в ячейках памяти. Ему известны лишь ячейки и индексы.
{: .prompt-info }

Компьютер, чтобы найти нужный элемент, перебирает все элементы с помощью **линейного поиска**.

То есть в примере, нужно найти значение `4`. Для этого нужно перебрать все элементы `0` до `3` и только когда, мы достигнем нужного значения это `4` поиск остановится и вернется индекс `3`

````javascript
let array = [1,   2,   3,   4,   5];
````

Если в массиве нет искомого элемента, нам все равно нужно просмотреть все элементы, что менее эффективно по сравнении с чтением.

### Вставка

Добавление нового значения в массив.

При вставке важно, куда мы хотим вставить новый элемент.

#### Вставка в конец

При вставке **в конец** массива, компьютер руководствуется следующим, если размер массива `5` элементов, а адрес ячейчки откуда начинается массив `1000`, тогда его последние элемент находится в ячейке `1004`.

Следовательно, адрес следующей ячейки `1005`, куда и будет вставлен новый элемент буквально за один шаг.

Первоначально компьютер выделил под массив только 5 ячеек памяти, при добавлении шестого нужно найти еще одну ячейку. Обычно это делается автоматически, каждый язык программирования делает это по своему.

#### Вставка в начало или в середину

Чтобы добавить элемент в **начало или середину** нужно сдвигать все элементы, чтобы освободить место для нового элемента.

Допустим в массив в позицию с индексом `2` мы хотим добавить новый элемент `2.1`.

Рассмотрим процесс последовательно:

````javascript
// Исходный массив, нужно вставить новый элемент на место элемента 3
let array = [1,   2,   3,   4,   5];
// Сдвигаем вправо элемент 5
[1,   2,   3,   4, '' , 5]
// Сдвигаем вправо элемент 4
[1,   2,   3, '' ,4  , 5]
// Сдвигаем вправо элемент 3
[1,   2, '' ,3,   4  , 5]
// Вставляем элемент на позицию с индексом 2
[1,   2,  2.1,  3,   4  , 5]
````

В итоге у нас на перемещение элементов у нас ушло 3 операции, и один шаг вставка.

> Самый неэффективный вариант вставки, это вставка в начало массива, так как нужно сдвинуть все элементы.
{: .prompt-info }

### Удаление

Удалить элемент из массива.

Удалим элемент с индексом 2 из массива

````javascript
let array = [1,   2,   3,   4,   5];
// Удалялем элемент
[1,   2, '' ,   4,   5];
// Сдвигаем элемент 4 влево
[1,   2,   4, '' ,   5];
// Сдвигаем элемент 5 влево
[1,   2,   4,   5];
````

Как видим выше на удаление элемента уходит несколько шагов, самый трудозатратный вариант, удаление первого элемента, так как придется сдвигать все элементы влево.

## Упорядоченный массив

Элементы в массиве должны быть отсортированы по порядку.

````javascript
let array = [8,17,56,85];
````

Допустим нужно вставить значение `34`. Каким образом компьютер поймет, что нужно вставить значение в определенное место.

Перед вставкой проверяем каждое значение с текущим вставляемым.

````javascript
// Шаг сравнение
// 34 > 8 , да идем дальше
// 34 > 17 , да идем дальше
// 34 > 56 , нет, значение нужно вставить слева от числа 
// Шаг сдвиг
[8,17,56,'',85]
[8,17,'',56,85]
// Вставляем элемент  
[8,17,34,56,85]
````

### Бинарный поиск

Когда мы рассматривали линейный поиск, мы проходили по каждому элементу массива прежде чем найти подходящий.

В случае с упорядоченным массивом, мы остановим поиск тогда, когда пересечем границу, когда дальше искать смысла точно нет.

Преимущество упорядоченного массива в том, что он позволяет использовать алгоритм **бинарного поиска**, который работает гораздо быстрее линейного.

Допустим у нас есть упорядоченный массив.

````javascript
[3,7,8,11,23,45,46,87,91,100]
// Как видит компьютер
['','','','','','','','','','']
// Мы хотим найти число 7
// Делим массив на 2 части то есть (длина массив / 2) = 5 ячейка
['','','','',23,'','','','',''] // Сравниваем, число находится слева от нашего числа, сразу можем исключить вторую половину чисел, там нашего числа нет + число 23
['','','','','!','!','!','!','!','!'] // Из оставшихся выбираем любую, пусть это будет правая
['','',8,'','!','!','!','!','!','!'] // Отсекаем правую часть, где точно нет нашего числа
['','','!','!','!','!','!','!','!','!'] // Выбираем левую часть оставшихсяч чисел
[3,'','!','!','!','!','!','!','!','!'] // Идем вправо и проверяем последнюю ячейку 
['!',7,'!','!','!','!','!','!','!','!'] // Число найдено, если мы его бы не нашли, значит числа вовсе нет
````

Если сравнить линейный поиск и бинарный, эффект достигается в больших массивах, например 10000 элементов.

Нужно иметь в виду, что работать с упорядоченным массивом не всегда быстрее, приходится идти на компромисс.


## Алгоритмы линейного и бинарного поиска

Посмотрим на примере на `javascript`, как может быть реализован алгоритм линейного поиска

````javascript
// Неотсеортированный массив элементов
let first = [12,1,45,2,7,8,78,9,42,4];
// Функция для поиска элементов
const one = (array, target) => {
  let steps = 0;

  for (let i = 0; i < array.length; i++) {
    steps++;
    if (array[i] === target){
      return `Найден элемент : ${array[i]} за ${steps} шагов`;
    }
  }
};

console.log(one(arr,7));
````

https://www.8host.com/blog/linejnyj-i-binarnyj-poisk-v-javascript/

## Что получаем в итоге

На самом базовом уровне получаем что массив


https://skillbox.ru/media/code/chto-takoe-massiv-i-kak-on-ustroen/

https://habr.com/ru/articles/422259/
https://doka.guide/tools/structure-data-in-js/