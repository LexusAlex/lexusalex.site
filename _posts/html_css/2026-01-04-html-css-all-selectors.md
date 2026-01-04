---
title: Все css селекторы
description: >-
  Кратко и четко список css селекторов
author: alex
date: 2026-01-04 23:30:00 +0300
categories: [Css]
image:
  path: /assets/img/posts/main/css.jpeg
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: Кратко и четко список css селекторов
---

## Таблица селекторов

В данной таблице кратко перечислю селекторы `css` с их назначением. В столбце "дополнительно", будут ссылки на примеры.

| Селектор          |                     Назначение                     |                               Описание                               |             Что попадает             | Дополнительно                       | Поддержка  | Специфичность |
|-------------------|:--------------------------------------------------:|:--------------------------------------------------------------------:|:------------------------------------:|-------------------------------------|------------|:-------------:|
| `*`               |               Универсальный селектор               |                  Попадают все элементы на странице                   |      `<body><div></div></body>`      | [1](#universal-1)                   | `baseline` |     0,0,0     |
| `div`             |                   Селектор тега                    |                    Все элементы `div` на странице                    |       `<div></div><div></div>`       | [1](#tag-1)                         | `baseline` |     0,0,1     |
| `#header`         |                  Селектор по `id`                  |                       Элемент с указанным `id`                       |      `<div id="header"></div>`       | [1](#id-1)                          | `baseline` |     1,0,0     |
| `.title`          |                 Селектор по классу                 |                   Все элементы с указанным классом                   |    `<span class='title'></span>`     | [1](#class-1)                       | `baseline` |     0,1,0     |
| `.red.blue`       |                 Составной селектор                 |           Применим для классов и атрибутов, пишется слитно           |    `<div class='red blue'></div>`    | [1](#composite-1) [2](#composite-2) | `baseline` |     0,2,0     |
| `[lang]`          |                Элементы с атрибутом                |                    Все элементы где есть атрибут                     |       `<div lang="ru"></div>`        | [1](#attr-1)                        | `baselne`  |     0,1,0     |
| `[lang="en"]`     |           Элементы со значением атрибута           |        Все элементы, где у атрибута есть конкретное значение         |       `<div lang="en"></div>`        | [1](#attr-2)                        | `baselne`  |     0,1,0     |
| `[class*="red"]`  |          Значение атрибута как подстрока           |        Все элементы, где есть значение атрибута в любом месте        | `<div class="greenredyellow"></div>` | [1](#attr-3)                        | `baselne`  |     0,1,0     |
| `[class~="red"]`  |      Значение атрибута есть в списке значений      |    Все элементы, где значение есть в списке разделенным пробелами    | `<div class="red blue black"></div>` | [1](#attr-4)                        | `baselne`  |     0,1,0     |
| `[class^="red-"]` |      Значение атрибута начинается со значения      |      Все элементы, где значение атрибута начинается со значения      |   `<div class="red-color"></div>`    | [1](#attr-5)                        | `baselne`  |     0,1,0     |
| `[class$="red"]`  |    Значение атрибута заканчивается со значения     |    Все элементы, где значение атрибута заканчивается со значения     |   `<div class="color-red"></div>`    | [1](#attr-6)                        | `baselne`  |     0,1,0     |
| `[class\|="red"]` | Значение атрибута либо точно равно либо равно+тире | Все элементы, где значение атрибута либо точно равно либо равно+тире |   `<div class="red-color"></div>`    | [1](#attr-7)                        | `baselne`  |     0,1,0     |
| `[class="red" i]` |        Значение атрибута без учета регистра        |    Все элементы, где указано значение атрибута без учета регистра    |      `<div class="RED"></div>`       | [1](#attr-8)                        | `baselne`  |     0,1,0     |
|                   |                                                    |                                                                      |                                      |                                     |            |               |
|                   |                                                    |                                                                      |                                      |                                     |            |               |
|                   |                                                    |                                                                      |                                      |                                     |            |               |
|                   |                                                    |                                                                      |                                      |                                     |            |               |
|                   |                                                    |                                                                      |                                      |                                     |            |               |
|                   |                                                    |                                                                      |                                      |                                     |            |               |
|                   |                                                    |                                                                      |                                      |                                     |            |               |
|                   |                                                    |                                                                      |                                      |                                     |            |               |
|                   |                                                    |                                                                      |                                      |                                     |            |               |

````css

````

````html

````

![](/assets/img/posts/css/selectors/all/s1.png){: .shadow }

Примеры к селекторам

## universal-1

Применим ко всем элементам на странице

````css
* {
    background-color: #2bcc2b;
}
````

````html
<b>b</b>
<span>span</span>
<div>
  <div>
    <div>div</div>
  </div>
</div>
````

![Универсальный селектор](/assets/img/posts/css/selectors/all/s1.png){: .shadow }

Применяется ко всем элементам к которым возможно применить стиль

## tag-1

Применим ко всем тегам `div` на любом уровне вложенности

````css
div {
  background-color: #2bcc2b;
}
````

````html
<b>b</b>
<span>span</span>
<div>
  <div>
    <div>div1</div>
  </div>
</div>
<div>div2</div>
````

![Селектор тега](/assets/img/posts/css/selectors/all/s2.png){: .shadow }

В данном случае `div1` и `div2` попадают под селектор

## id-1

На странице может быть только один селектор тега

````css
#header {
  background-color: #2bcc2b;
}
````

````html
<b>b</b>
<span>span</span>
<div>
  <div>
    <div id="header">header</div>
  </div>
</div>
<div>div2</div>
<div>div3</div>
````

![Селектор по id](/assets/img/posts/css/selectors/all/s3.png){: .shadow }

## class-1

Все элементы с указанным классом

````css
.title {
    color: #2bcc2b;
}
````

````html
<b class="title">b</b>
<span>span</span>
<div>
  <div>
    <div class="title">title</div>
  </div>
</div>
<div>div2</div>
<div class="title">div3</div>
````

![Селектор по классу](/assets/img/posts/css/selectors/all/s4.png){: .shadow }

В данном случае будут выбраны все элементы у которых есть класс `.title`.

## composite-1

Применяется для всех элементов, где есть два класса в любом порядке

````css
.red.blue {
    background-color: #2bcc2b;
}
````

````html
<div class="red blue">1</div>
<div class="blue red">2</div>
<div class="blue red yellow">3</div>
<div class="blue">4</div>
<div class="red">5</div>
<div>
  <div>
    <div>
      <span class="red blue">6</span>
    </div>
  </div>
</div>
````

![Составной селектор](/assets/img/posts/css/selectors/all/s5.png){: .shadow }

В данном случае два класса есть у элемента 1,2,3,6 они и будут выделены

## composite-2

`div` с определенным атрибутом

````css
div[title] {
    color: #2bcc2b;
}
````

````html
<div title="1">1</div>
<div title="2">2</div>
<div title="">3</div>
<div>
  <div>
    <span title="2">4</span>
  </div>
</div>
````

![Составной селектор](/assets/img/posts/css/selectors/all/s8.png){: .shadow }

В данном случае под условие попадут только элементы `div` с любым атрибутом `title`

## attr-1

````css
[title] {
    color: #2bcc2b;
}
````

````html
<div title="1">1</div>
<div title="2">2</div>
<div>3</div>
<div>
  <div>
    <span title="3">4</span>
  </div>
</div>
````

![Селектор атрибута](/assets/img/posts/css/selectors/all/s6.png){: .shadow }

В данном случае попадают 2 первых `div` и вложенный `span`.

## attr-2

Атрибут с определенным значением

````css
[title="2"] {
  color: #2bcc2b;
}
````

````html
<div title="1">1</div>
<div title="2">2</div>
<div title="">3</div>
<div>
  <div>
    <span title="2">4</span>
  </div>
</div>
````

![Селектор атрибута](/assets/img/posts/css/selectors/all/s7.png){: .shadow }

В данном примере только 2 и 4 элементы попадают под условие.

## attr-3

Атрибут, где значение находиться в любом месте как подстрока.

````css
[class*="red"] {
  background-color: #8250df;
}
````

````html
<div class="red">1</div>
<div class="red blue">2</div>
<div class="red-123">3</div>
<div class="yellow-red">4</div>
<div class="yellow-red-blue">5</div>
<div class="yellow-rd-blue">6</div>
<div>
  <div>
    <span class="REDred">7</span>
  </div>
</div>
````

![Селектор атрибута](/assets/img/posts/css/selectors/all/s9.png){: .shadow }

Все элементы, кроме 6, попадают под условие.


## attr-4

Значение атрибута есть в списке разделенном пробелами

````css
[class~="red"] {
  background-color: #8250df;
}
````

````html
<div class="red">1</div>
<div class="red blue">2</div>
<div class="blue red yellow">3</div>
<div class="yellow-red">4</div>
<div class="yellow-red-blue">5</div>
<div class="yellow-rd-blue">6</div>
<div>
  <div>
    <span class="REDred">7</span>
  </div>
</div>
````

![Селектор атрибута](/assets/img/posts/css/selectors/all/s10.png){: .shadow }

Только первые три `div` попадают, так как у них есть атрибут класс с несколькими классами


## attr-5

Значение атрибута начинается со значения

````css
[class^="red"] {
    background-color: #8250df;
}
````

````html
<div class="redok">1</div>
<div class="medred blue">2</div>
<div class="blue red yellow">3</div>
<div class="yellow-red">4</div>
<div class="yellow-red-blue">5</div>
<div class="yellow-rd-blue">6</div>
<div>
  <div>
    <span class="red-color">7</span>
  </div>
</div>
````

![Селектор атрибута](/assets/img/posts/css/selectors/all/s11.png){: .shadow }

В данном случае попадет элемент 1 и 7

## attr-6

Значение атрибута заканчивается значением

````css
[class$="red"] {
   background-color: #8250df;
}
````

````html
<div class="redok">1</div>
<div class="medred blue">2</div>
<div class="blue red yellow">3</div>
<div class="yellow-red">4</div>
<div class="yellow-red-blue">5</div>
<div class="yellow-rd-blue">6</div>
<div>
  <div>
    <span class="red-color-Rred">7</span>
  </div>
</div>
````

![Селектор атрибута](/assets/img/posts/css/selectors/all/s12.png){: .shadow }

Тут попадет элемент 4 и 7


## attr-7

Значение атрибута либо равно, либо равно+тире

````css
[class|="red"] {
  background-color: #8250df;
}
````

````html
<div class="red">1</div>
<div class="med red blue">2</div>
<div class="blue red yellow">3</div>
<div class="yellow-red">4</div>
<div class="yellow-red-blue">5</div>
<div class="yellow-rd-blue">6</div>
<div>
  <div>
    <span class="red-color">7</span>
  </div>
</div>
````

![Селектор атрибута](/assets/img/posts/css/selectors/all/s13.png){: .shadow }

В данном случае попадает 1 и 7 элемент, в первом точное совпадение, а в 7 идет тире после названия

## attr-8

````css
[class="red" i] {
    background-color: #8250df;
}
````

````html
<div class="red">1</div>
<div class="Red">2</div>
<div class="RED">3</div>
<div>
  <div>
    <span class="black">4</span>
  </div>
</div>
````

![Селектор атрибута](/assets/img/posts/css/selectors/all/s14.png){: .shadow }

Здесь под действие селектора попадают 3 первых элемента `div`.
