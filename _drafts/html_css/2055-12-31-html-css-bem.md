---
title: БЭМ методология верстки
description: >-
  Элементы для разметки контента на странице header, footer, main
author: alex
date: 2025-04-06 19:45:00 +0300
categories: [Html]
image:
  path: /assets/img/posts/main/three_boxes.webp
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: БЭМ методология верстки
---

## Блок

Это компонент который можно повторно переиспользовать

Кнопка

Позволяет структурировать `css`.

````html
<button class="btn">Кнопка</button>
````

````css
/* Кнопка */
.btn {
  border: none;
  outline: none;
  border-radius: 10px;
  padding: 13px 20px;
  color: white;
  transition: background-color .3s;
}

.btn:hover {
  background-color: #0d6efd;
}
````

У блоков не должно быть внешних отступов

## Элемент

Элемент не может существовать вне блока, в данном случае это `img`

````html
  <div class="rating">
    <img class="rating__star" src="" alt="">
    <img class="rating__star" src="" alt="">
    <img class="rating__star" src="" alt="">
    <img class="rating__star" src="" alt="">
    <img class="rating__star" src="" alt="">
  </div>
````

Элемент привязан к блоку, составляющая часть блока

````css
.rating {
  display: flex;
}
.rating__star:not(:last-child) {
  margin-right: 6px;
}
````

Карточка - блок

Если компонент не может существовать вне блока, то это элемент

````html
<div class="card">
  <img class="card__main" src="" alt="">
  <div class="card__body">
    <div class="card__price-rating">
      <div class="card__price"></div>
      <div class="rating card__rating">
        <img class="rating__star" src="" alt="">
        <img class="rating__star" src="" alt="">
        <img class="rating__star" src="" alt="">
        <img class="rating__star" src="" alt="">
        <img class="rating__star" src="" alt="">
      </div>
    </div>
    <h3 class="card__title">Название</h3>
    <span class="card__location">Мир</span>
    <button class="btn card_btn">Кнопка</button>
  </div>
</div>
````

````css
.card {}
.card_main {}
````

Можно использовать блоки внутри других блоков

Так же карточку можно переиспользовать

## Модификатор

Позволяет добавить уникальные настройки

Удобно будет добавить модифицирующий класс

Если модификатор принадлежит блоку то сначала нужно указать название блока

````html
<button class="btn btn_yellow">Кнопка</button>
````

Название модификатора описывает, то что он меняет

````css
.btn_yellow {
  
}
````

Модификатор должен быть написан после стилизации блока и элемента

````html
<div class="rating">
    <img class="rating__star" src="" alt="">
    <img class="rating__star" src="" alt="">
    <img class="rating__star rating__star_big-size_s" src="" alt="">
    <img class="rating__star" src="" alt="">
    <img class="rating__star rating__star_big-size_m" src="" alt="">
</div>
````

````css
.rating__star_big-size_s {
  transform: scale(1.2);
}

.rating__star_big-size_m {
  transform: scale(1.2);
}
````

````html
<ul class="cards-list">
  <li class="cards-list__item">1</li>
  <li class="cards-list__item">2</li>
  <li class="cards-list__item">3</li>
</ul>
````



https://result.school/roadmap/frontend/article/bem

Очень хорошо по бэм
писать статью по ней
https://www.youtube.com/watch?v=3sGZvLMrKrU
https://www.youtube.com/watch?v=btJVoCZyjbA
https://www.youtube.com/watch?v=W8GphcizGqE

https://habr.com/ru/articles/767086/

https://ru.bem.info/methodology/quick-start/
