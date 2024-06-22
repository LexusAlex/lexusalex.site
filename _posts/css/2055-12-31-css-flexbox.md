---
title: Flexbox
description: >-
  
author: alex
date: 2055-06-01 18:00:00 +0300
categories: [Css]
tags: [flexbox]
---

https://doka.guide/css/flexbox-guide/
https://getbootstrap.com/docs/5.3/layout/breakpoints/
https://blog.skillfactory.ru/glossary/flexbox/

## Что такое flexbox

`flexbox` это способ позиционирования элементов в CSS. 

С помощью `flexbox` можно быстро и легко описывать, как будет располагаться тот или иной блок на странице. 

Элементы выстраиваются по заданной оси и автоматически распределяются согласно настройкам.

`flexbox` определяет способность гибкого элемента растягиваться или сжиматься для заполнения собой доступного пространства.

## Базовое поведение

По умолчанию все блочные элементы располагаются друг под другом. Это стандартное поведение для блочных элементов.

![img-description](/assets/img/posts/css/flexbox/flex-1.png){: .shadow }
_Базовый пример без использования flexbox_

## Container

Контейнер - это элемент которому задано css свойство `display:flex` или `display: inline-flex`.

![img-description](/assets/img/posts/css/flexbox/flex-2.png){: .shadow }
_display:flex_

![img-description](/assets/img/posts/css/flexbox/flex-3.png){: .shadow }
_display:inline-flex_

Элемент приобретает свойства контейнера.

### Особенности

- Контейнеры могут вложены друг в друга.
- Каждый контейнер имеет точки начала и точки конца.
- Дочерние элементы контейнера начинают подчиниться свойствам флекса, но это касается только прямых потомков.
- При `display:flex` снаружи контейнер обычный блочный элемент, который занимает всю ширину родительского элемента.
- При `display:inline-flex` снаружи контейнер это строчный элемент, его размеры зависят от его контента.

### Основная ось (горизонтальная)

По умолчанию все элементы контейнера располагаются вдоль **основной оси** слева направо.

Это ось по которой выстраивается поток элементов.

### Поперечная ось (перпендикулярная, вертикальная, вспомогательная)

Нужна для того, чтобы понимать куда переносить элементы.

### Когда использовать flex и когда inline-flex
1

### flex-direction

Свойство управляет направлением элементов основной `row` и поперечной осей `column`.

> Можно менять расположение элементов на оси, но привязка к ней все равно остается.
{: .prompt-info }

#### row

Элементы располагаются слева направо вдоль основной оси как они идут в разметке.

![img-description](/assets/img/posts/css/flexbox/flex-4.png){: .shadow }
_flex-direction:row_

> Является значением по умолчанию
{: .prompt-info }

#### row-reverse

Элементы располагаются справа налево вдоль основной оси как они идут в разметке.

![img-description](/assets/img/posts/css/flexbox/flex-5.png){: .shadow }
_flex-direction:row-reverse_

#### column

Элементы располагаются сверху вниз вдоль поперечной оси

![img-description](/assets/img/posts/css/flexbox/flex-6.png){: .shadow }
_flex-direction:column_

#### column-reverse

Элементы располагаются снизу вверх вдоль поперечной оси

![img-description](/assets/img/posts/css/flexbox/flex-7.png){: .shadow }
_flex-direction:column-reverse_

### flex-wrap

Определяет как переносятся элементы когда в родительском контейнере закончилось место.

#### no-wrap

Значение по умолчанию `no-wrap`, говорит о том, что даже если элементы не помещаются в контейнер, они не переносятся на новый ряд, а вмещаются максимально в строку.

При этом размеры родителя не имеют никакого значения.

Ниже мы задали размер для каждого элемента `250px`, но как видим размер существенно меньше.

![img-description](/assets/img/posts/css/flexbox/flex-8.png){: .shadow }
_flex-wrap:no-wrap_

> Является значением по умолчанию
{: .prompt-info }

#### wrap

Элементы будут переноситься на новый ряд, если не влезают в родительскую строку.

В данном случае, не поместились три элемента, они и перенеслись на следующую строку.

Размеры каждого элемента при этом, как мы и указали `250px`.

![img-description](/assets/img/posts/css/flexbox/flex-9.png){: .shadow }
_flex-wrap:wrap_

То есть при изменении экрана элементы будут максимально заполнять всю имеющиеся область. В случае если элемент не влезает

![img-description](/assets/img/posts/css/flexbox/flex-11.png){: .shadow }
_Перенос элементов на следующую строку_

#### wrap-reverse

Расположение элементов снизу вверх, сначала заполняются нижние ряды родителя, потом что не влезло переноситься наверх.

> Меняется направление дополнительной оси или вспомогательной оси
{: .prompt-info }

![img-description](/assets/img/posts/css/flexbox/flex-10.png){: .shadow }
_flex-wrap:wrap-reverse_

### flex-flow

Свойство, которое позволяет сразу задать `flex-direction` и `flex-wrap`.

Сочетания:

- `flex-flow: column nowrap;` - колонка не переносить
- `flex-flow: column wrap;` - колонка переносить
- `flex-flow: column-reverse nowrap;` - перевернутая колонка не переносить
- `flex-flow: column-reverse wrap;` - перевернутая колонка не переносить
- `flex-flow: row wrap;` - ряд переносить
- `flex-flow: row nowrap;` - ряд не переносить
- `flex-flow: row-reverse wrap;` - перевернутый ряд не переносить

Используется если точно известно параметры сетки.

Работают как свойства описанные выше:

- [flex-direction](/posts/css-flexbox/#flex-direction)
- [flex-wrap](/posts/css-flexbox/#flex-wrap)

## Item

Дочерние элементы контейнера.

- Все элементы вложенные в элемент уже не являются flex item

## Примеры

### Расстановка элементов друг под другом

Задача расположить 10 элементов с заданным размером в выставленной высоте родителя друг под другом в два ряда.

````html
<div class="container"> 
    <div class="item item1">1</div>
    <div class="item item2">2</div>
    <div class="item item3">3</div>
    <div class="item item4">4</div>
    <div class="item item5">5</div>
    <div class="item item6">6</div>
    <div class="item item7">7</div>
    <div class="item item8">8</div>
    <div class="item item9">9</div>
    <div class="item item0">10</div>
</div>
````

````css
* {
      box-sizing: border-box;
  }
.container {
    font-size: 35px; /* Размер шрифта для контейнера */
    text-align: center;
    display: flex;
    height: 130px; /* Высота контейнера */
    flex-direction: column; /* Расположение элементов друг под другом */
    flex-wrap: wrap; /* Разрешеаем переносить элементы на следующую строку */
}

.item {
    background-color: rgba(117,180,157,0.27);
    border: #000066 1px solid;
    padding: 8px;
    width: 200px; /* Фиксированная ширина каждого элемента */
}
````

Получаем такой результат

![img-description](/assets/img/posts/css/flexbox/flex-12.png){: .shadow }
_Расстановка элементов друг под другом_
