---
title: Селекторы в css
description: >-
  Типы селекторов в css
author: alex
date: 2055-03-26 14:20:00 +0300
categories: [Css]
image:
  path: /assets/img/posts/main/css.jpeg
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: Типы селекторов в css
---

**Селектор** - это такая структура, которая используется как условие определяющее каким элементам в дереве документа соответствует селектор.

Селекторы могут быть простыми или расширенными контекстными представлениями.

## Универсальный селектор *

Универсальный селектор `*` применяется ко всем элементам на странице

### Пример 1. Размер шрифта для всего документа

````css
* {
    font-size: 20px;
}
````

````html
<p>Текст</p>
<b>Жирный текст</b>
<span>Просто текст</span>
````

В результате все элементы на странице будут размером `20px`

### Пример 2. Сброс отступов и полей для всех элементов

Сброс стилей по умолчанию используют для нормализации стилей браузера по умолчанию.

В примере элемент `body` и элементы `p` имеют отступы по умолчанию, данный стиль сбрасывает их в ноль.

````css
* {
  margin: 0;
  padding: 0;
}
````

````html
<p>Блок 1</p>
<p>Блок 2</p>
<p>Блок 3</p>
````

В итоге результат получается предсказуемым для дальнейшей стилизации.

### Пример 3. box-sizing для всех элементов

> Псевдоэлементы `::before и ::after` не включают универсальный селектор, поэтому их нужно перечислять отдельно
{: .prompt-info }

Данный стиль меняет алгоритм расчета размеров элемента. Что в будущем упрощает управление размерами элемента, так как ширина элемента не будет увеличиваться.

Наглядно посмотрим на пример

Имеем несколько элементов `p`.

````css
*,
*::before,
*::after {
  box-sizing: border-box;
}

p {
  padding: 20px;
  margin: 20px;
  width: 100px;
}
````

````html
<p class="one">Блок 1</p>
<p class="two">Блок 2</p>
<p class="three">Блок 3</p>
````
С помощью `javascript` выведем размеры элемента.

Без `box-sizing: border-box` ширина элемента составляла `140px`, а это `padding` с двух сторон.
С применением этого стиля ширина будет четко заданной, это `100px`.

````javascript
console.log(document.querySelector('.one').getBoundingClientRect().width); // 100
````

В итоге, мы имеем четкий размер который указали.

## Пример 4. Все элементы в рамках контекста

В рамках одного селектора, универсальный селектор можно использовать для действия внутри этого селектора.

Первое правило, цвет для всего элемента `p`. А второе это цвет для всех элементов внутри `p`.

````css
p {
  background-color: #0d6efd;
}
p * {
  background-color: #2bcc2b;
}
````

````html
<p>
    <small>small 1</small>
    <small>small 2</small>
    <b>b 1</b>
</p>
````

![Все элементы в рамках контекста](/assets/img/posts/css/selectors/universal.png){: .shadow }
_Все элементы в рамках контекста_


https://github.com/FrontenderMagazine/axiomatic-css-and-lobotomized-owls/blob/master/rus.md
https://webref.ru/css/selector
https://doka-guide.vercel.app/css/tag-selector/
https://dan-it.gitlab.io/fe-book/programming_essentials/html_css/ext_30_useful_css-selectors/ext_30_useful_css-selectors.html
https://devreflex.ru/html-css/selektory-v-css
https://www.w3.org/TR/selectors-3/#universal-selector
https://css-live.ru/articles-css/impossible-pseudos.html
