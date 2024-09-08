---
title: Просто о Flexbox в css
description: >-
   Посмотрим как работать с гибкой сеткой flexbox.
   Разберем свойства и научимся их применять
author: alex
date: 2024-07-28 09:30:00 +0300
categories: [Css, Flexbox]
tags: [flex]
image:
  path: /assets/img/posts/main/flexbox.png
  alt: flexbox
---

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

С этого момента элемент приобретает свойства контейнера.

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

Размер элементов поперечной оси всегда перпендикулярен основному размеру. 

Если основной размер - ширина, то поперечный размер - высота, и наоборот.

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

Свойство, которое позволяет сразу задать и `flex-direction` и `flex-wrap`.

Сочетания:

- `flex-flow: column nowrap;` - колонка не переносить
- `flex-flow: column wrap;` - колонка переносить
- `flex-flow: column-reverse nowrap;` - перевернутая колонка не переносить
- `flex-flow: column-reverse wrap;` - перевернутая колонка не переносить
- `flex-flow: row wrap;` - ряд переносить
- `flex-flow: row nowrap;` - ряд не переносить
- `flex-flow: row-reverse wrap;` - перевернутый ряд не переносить

Используется если точно известно параметры сетки.

Работают так же как и свойства описанные выше:

- [flex-direction](/posts/css-flexbox/#flex-direction)
- [flex-wrap](/posts/css-flexbox/#flex-wrap)

### justify-content

Выравнивание элементов внутри контейнера по основной оси. По умолчанию она идет слева направо.

#### flex-start и start

Элементы контейнера прижимаются к краю от которого начинается основная ось.

Для `row` это левый край, а для `column` это верх

![img-description](/assets/img/posts/css/flexbox/flex-13.png){: .shadow }
_justify-content:flex-start_

> Значение по умолчанию
{: .prompt-info }

> flex-start и flex-end будут менять направление чтения текста на сайте в отличии от свойств left и right
{: .prompt-info }

#### flex-end и end

Элементы контейнера будут прижаты к краю у которого заканчивается основная ось.

Для `row` это правый край, а для `column` это низ

![img-description](/assets/img/posts/css/flexbox/flex-14.png){: .shadow }
_justify-content:flex-end_

> Значения start и end в большинстве браузеров идентичны flex-start и flex-end 
{: .prompt-info }

#### center

Элементы контейнера выстраиваются по центру.

![img-description](/assets/img/posts/css/flexbox/flex-15.png){: .shadow }
_justify-content:center_

#### left

Выравнивание элементов по левому краю контейнера.

![img-description](/assets/img/posts/css/flexbox/flex-16.png){: .shadow }
_justify-content:left_

> Отличие left от flex-start в том, что при flex-direction:row-reverse элементы всегда будут с левой стороны
{: .prompt-info }

#### right

Выравнивание элементов по правому краю контейнера.

![img-description](/assets/img/posts/css/flexbox/flex-17.png){: .shadow }
_justify-content:right_

#### space-between

Прижимать крайние элементы к левому и правому краям, а элементы между ними распределять равномерно.

![img-description](/assets/img/posts/css/flexbox/flex-20.png){: .shadow }
_justify-content:space-between_

При `flex-direction:row-reverse` элементы пойдут в обратном направлении.

![img-description](/assets/img/posts/css/flexbox/flex-21.png){: .shadow }
_justify-content:space-between_

#### space-around

Свободное пространство делится между всеми элементами. Но от крайних элементов слева и справа будет половина этого расстояния.

![img-description](/assets/img/posts/css/flexbox/flex-22.png){: .shadow }
_justify-content:space-around_

#### space-evenly

Настояние между всеми элементами будет одинаковым.

![img-description](/assets/img/posts/css/flexbox/flex-23.png){: .shadow }
_justify-content:space-evenly_

> Главное здесь понять как элементы должны располагаться на странице
{: .prompt-info }

Если `flex-direction:column` и высота контейнера будет больше контета в нем то `justify-content` будет так же работать как и при `flex-direction:row`

![img-description](/assets/img/posts/css/flexbox/flex-24.png){: .shadow }
_justify-content и flex-direction:column_

### align-items

Выравнивание элементов по вертикальной(поперечной) оси.

Напомню при `row` основная ось идет слева направо, а поперечная сверху вниз.

При `column` основная ось сверху вниз, а поперечная слева направо

#### stretch

Элементы по максимуму заполняют всего родителя.

![img-description](/assets/img/posts/css/flexbox/flex-25.png){: .shadow }
_align-items:stretch_

> Значение по умолчанию
{: .prompt-info }

#### flex-start и start

Элементы выстраиваются в начале поперечной оси

![img-description](/assets/img/posts/css/flexbox/flex-27.png){: .shadow }
_align-items:flex-start и start_

#### flex-end и end

Элементы выстраиваются в конце поперечной оси

![img-description](/assets/img/posts/css/flexbox/flex-28.png){: .shadow }
_align-items:flex-end и end_

> Значения start и end учитывают направление текста в браузере пользователя
{: .prompt-info }

#### center

Элементы выстраиваются по центру поперечной оси

![img-description](/assets/img/posts/css/flexbox/flex-30.png){: .shadow }
_align-items:center_

#### baseline

Элементы выстраиваются по "базовой линии" текста, то есть по низу.

Например, если поменять размер шрифта, то элементы будут выстроены по нижней его части, то есть по базовой линии текста. 

![img-description](/assets/img/posts/css/flexbox/flex-31.png){: .shadow }
_align-items:baseline_

### align-content

Распределяет элементы по поперечной оси. Можем управлять их поведением

Имеет значение только элементы располагаются в несколько рядов

То есть какие должны быть вводные для срабатывания свойства:

- `flex-wrap: wrap;`
- `width: 50%;` ширина на самом элементе

> Позиционирование будет применено в рамках нескольких строк
{: .prompt-info }

#### stretch

Ряды будут растянуты одинаково для того, чтобы занять все пространство родителя.

![img-description](/assets/img/posts/css/flexbox/flex-33.png){: .shadow }
_align-content:stretch_

> Значение по умолчанию
{: .prompt-info }

![flex-36.png](/assets/img/posts/css/flexbox/flex-36.png)

#### flex-start и start

Элементы располагаются у начала второстепенной оси

![img-description](/assets/img/posts/css/flexbox/flex-34.png){: .shadow }
_align-content:flex-start и start_

#### flex-end и end

Элементы располагаются у конца поперечной оси

![img-description](/assets/img/posts/css/flexbox/flex-35.png){: .shadow }
_align-content:flex-end и end_

#### center

Элементы будут выстроены по центру контейнера

![img-description](/assets/img/posts/css/flexbox/flex-36.png){: .shadow }
_align-content:center_

#### space-between

Первый и последний элементы встают к краям поперечной оси, остальные элементы распределяются так, чтобы между ними были равномерные отступы.

![img-description](/assets/img/posts/css/flexbox/flex-37.png){: .shadow }
_align-content:space-between_

#### space-around

У первого и последнего элемента оступы по поперечной оси вдвое меньше отступов между другими элементами. 
При этом между остальными элементами отступы равнозначны.

![img-description](/assets/img/posts/css/flexbox/flex-38.png){: .shadow }
_align-content:space-around_

#### space-evenly

Отступы от всех элементов одинаковые 

![img-description](/assets/img/posts/css/flexbox/flex-39.png){: .shadow }
_align-content:space-evenly_

### gap

Расстояние между строками и столбцами.

Можно указывать два значения, но если указано одно, оно и будет использоваться для колонок и столбцов.

- Первое значение устанавливает отступ между рядами `row` `row-gap`
- Второе значение устанавливает отступ между колонками `column` `column-gap`

Примеры:

- `gap: 30px calc(10rem - 10px);` динамические промежутки между ячейками сетки
- `gap: 10px 5px;`

![img-description](/assets/img/posts/css/flexbox/flex-40.png){: .shadow }
_gap: 10px 5px_

> row-gap и column-gap используются как отдельные свойства
{: .prompt-info }

## Item

Прямые дочерние элементы контейнера.

- Все элементы вложенные в элемент уже не являются flex item и их нужно снова сделать контейнерами.

Свойства ниже управляют непосредственно самими элементами.

### order

Меняем порядок отображение элементов внутри контейнера.

По умолчанию элементы отобраться как они идут в разметке.

Значение всех элементов по умолчанию = `0`.

Каждый элемент можно двигать как нам нужно меняя значение `order` на положительное или отрицательное число.

`order` влияет на визуальное отображение элементов.

Примеры значений:

- `0`
- `-1`
- `7`

Рассмотрим пример:

![img-description](/assets/img/posts/css/flexbox/flex-41.png){: .shadow }
_order_

В примере выше у каждого элемента есть свой класс. Зададим значение `order` для некоторых из них

````css
.item1 {
  order: 1;
}
.item10 {
  order: 2;
}
.item9 {
  order: -1;
}
````

Напоминаю все элементы имеют по умолчанию значение `order=0`

- Элемент 10 идет в самый конец, так как у него `order:2`
- Элемент 1 идет в след элементу 10, так как у него `order:1`
- Элемент 9 идет в начало, так как у него `order:-1`

> Использовать order можно например при перемещении элементов при адаптивной верстке например переместить шапку сайта вниз на небольших экранах
{: .prompt-info }

### align-self

По сути `align-self` переопределяет `align-items` но для одного элемента по текущей линии.

По умолчанию значение `auto` это значит наследует значение элемента из `align-items`

![img-description](/assets/img/posts/css/flexbox/flex-42.png){: .shadow }
_align-self_

В примере выше мы выставили разные значения `align-self` для каждого элемента:

- 1 `align-self: auto;` - значение по умолчанию
- 2 `align-self: start;` - в начало строки
- 3 `align-self: end;` - в конец строки
- 4 `align-self: flex-start;` - в начало строки
- 5 `align-self: flex-end;` - в конец строки
- 6 `align-self: center;` - посередине строки
- 7 `align-self: baseline;` - по базовой линии шрифта

Работает одинаково для `flex-direction:row` и `flex-direction:column`

### flex-basis

Базовое пространство которое будет занимать элемент, до того как оно будет заполнено.

При расчете размеров элемента принимается во внимание свойства высоты, ширины элемента.

Если размеры не заданы, тогда элемент занимает столько пространства сколько ему нужно для отображения контента.

![img-description](/assets/img/posts/css/flexbox/flex-43.png){: .shadow }
_flex-basis_

В примере выше мы задали значение по умолчанию для 1 элемента в `200px` а для 6 `100px`.

> Значение по умолчанию для всех элементов auto, это значит отображение размеров по контенту
{: .prompt-info }

### flex-grow

Управляет расширением отдельного элемента по частям. 

Если есть свободное пространство элемент может заполнить это пространство.

Если задать всем элементам значение больше 0, то свободное пространство будет распределено между всеми элементами.

Если кратко `flex-grow` говорит сколько частей свободного пространства нужно занять элементу.

Например, распределим все свободное пространство между 10 элементами, для этого элементам укажем всем элементам `flex-grow:1`

![img-description](/assets/img/posts/css/flexbox/flex-44.png){: .shadow }
_flex-grow:1_

Теперь увеличим первый элемент на 5 частей.

![img-description](/assets/img/posts/css/flexbox/flex-45.png){: .shadow }
_flex-grow:5_

> Важно понимать элементы заполняют именно свободное пространство
{: .prompt-info }

> Значение по умолчанию для всех элементов 0 частей
{: .prompt-info }

### flex-shrink

Управляет сжатием отдельно взятого элемента.

Насколько сильнее сжать один элемент относительно другого.

Как мы должны сжиматься если у нас нет свободного пространства.

> Значение по умолчанию для всех элементов 1
{: .prompt-info }

### flex
 
Универсальное свойство для задания сразу трех значений

- `flex-grow`
- `flex-shrink`
- `flex-basis`

Какие могут быть значения:

- `flex: 0 1 auto` - значение по умолчанию для всех элементов
- `flex: 1` - Одно число интерпретируется как `flex-grow` . Означает что элемент будет одну фракцию от всех элементов.
- `flex: 1em` - Значение высоты интерпретируется как `flex-basics`
- `flex: 1 30px;` - Два значения `flex-grow` и `flex-basics`
- `flex: 2 2;` - Два значения без размера `flex-grow` и `flex-shrink`
- `flex: 2 2 10%;` - Три значения `flex-grow` затем `flex-shrink` и далее `flex-basics`

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

### Обратный порядок элементов, но не перемещая их

Задача не меняя позицию элементов поменять их порядок.

````css
.container {
  font-size: 35px;
  text-align: center;
  display: flex;
  flex-direction: row-reverse; /* делаем порядок элементов обратным */
  justify-content: left; /* жестко говорим располагай по левой стороне */
}

/* или */

.container {
  font-size: 35px;
  text-align: center;
  display: flex;
  flex-direction: row-reverse;
  justify-content: left;
}

````

В итоге, если жестко заданы `left` или `right`, элементы будут строго располагаться по нужную сторону.

![img-description](/assets/img/posts/css/flexbox/flex-18.png){: .shadow }
_Обратный порядок элементов, но не перемещая их left_

![img-description](/assets/img/posts/css/flexbox/flex-19.png){: .shadow }
_Обратный порядок элементов, но не перемещая их right_

### Колонки с одинаковым расстоянием между ними

Задача сделать адаптивные колонки с одинаковым расстоянием между ними.

```css
.container {
    font-size: 35px;
    height: 100vh; /* растягиваем колонки на всю высоту вьюпорта*/
    text-align: center;
    display: flex;
    flex-direction: row;
    justify-content: space-evenly; /* равномерное расстояние между колонками */
    align-items: stretch;
}
```

![img-description](/assets/img/posts/css/flexbox/flex-26.png){: .shadow }
_Колонки с одинаковым расстоянием между ними_

### Адаптивные колонки

Задача сделать 10 простейших адаптивных колонок

````css
.container {
  font-size: 35px;
  height: 100vh;
  text-align: center;
  display: flex;
  flex-direction: row;
  justify-content: center; /* выравнивание по центру по основной оси */
  align-items: stretch;
}

.item {
  background-color: rgba(117,180,157,0.27);
  border: #000066 1px solid;
  padding: 8px;
  width: 10%; /* так как у нас 10 колонок делаем им ширину в % */
}
````
 
В результате получаем такую красоту

![img-description](/assets/img/posts/css/flexbox/flex-29.png){: .shadow }
_Адаптивные колонки_

### Элемент строго по центру

Задача. Допустим есть элемент с фиксированными значениями, его нужно выставить по центру, нет ничего проще

````css
.container {
  font-size: 35px;
  height: 100vh;
  text-align: center;
  display: flex;
  flex-direction: row;
  justify-content: center; /* центрирование по основной оси */
  align-items: center; /* центрирование по вспомогательной оси */
}

.item {
  background-color: rgba(117,180,157,0.27);
  border: #000066 1px solid;
  padding: 8px;
}

.item1 {
  width: 200px;
  height: 200px;
}
````

![img-description](/assets/img/posts/css/flexbox/flex-32.png){: .shadow }
_Элемент строго по центру_

### Полный адаптив

Задача. Есть набор блоков с заданными размерами, нужно сделать их адаптивными.

````css
.container {
  font-size: 35px;
  text-align: center;
  display: flex;
  flex-direction: row; 
  flex-wrap: wrap; /* Разрешаем переносить */
  justify-content: start;
  align-items: stretch;
  align-content: stretch;
}

.item {
  background-color: rgba(117,180,157,0.27);
  border: #000066 1px solid;
  padding: 8px;
  flex-basis: 300px; /* По умолчанию все элементы равны 300px */
  flex-grow: 1;  /* Разрешаем расти всем элементам */
}
````

В итоге получаем полная адаптивная верстка.

![img-description](/assets/img/posts/css/flexbox/flex-46.png){: .shadow }
_Полный адаптив_

## Итог

- Чаще всего используется значения `justify-content` это `space-between` и `center`.
- Рекомендуется проверять поддержку свойств браузерами на сайте [https://caniuse.com/](https://caniuse.com/?search=justify-content%20flex)
- Если необходимо прижать элемент к левой или правой части, то необходимо элементу указать `margin-left: auto`
- Если меняем расположение элементов, например свойством `flex-direction: row-reverse`, то нужно понимать, что изменения только визуальные, в самом `html` они остались в том же порядке в котором и были
- Основная ось выстраивается слева направо, а поперечная сверху вниз.
- flex элементы по умолчанию сжимаются под свое содержимое, это полезно когда есть блоки с динамическим контентом.
- Внешние отступы в отличие от блочной модели не схлопываются и не выпадают
- flex элементы умеют перераспределять свободное пространство вокруг себя, таким образом меняя ширину и высоту
- Отступы можно задать не только по горизонтали, но и по вертикали.

## Что в планах

По отношению к флексам в этой статье рассмотрел не все, что хотел. В планах сделать отдельные заметки на темы:

- flexbox во фреймворках
- Что же использовать `flexbox` или `grid`. Почему grid не заменит flex

> Подписывайтесь на телеграмм канал [lexusalextg](https://t.me/lexusalextg), чтобы оперативно узнавать о новых статьях, дополнениях и полезных материалах.
{: .prompt-tip }
