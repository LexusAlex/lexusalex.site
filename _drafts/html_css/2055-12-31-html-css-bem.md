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



### Методология БЭМ (Block, Element, Modifier)

**БЭМ** — это компонентный подход к веб-разработке, который структурирует код через разделение интерфейса на независимые блоки. Основная цель: **повторное использование кода**, **масштабируемость** и **поддерживаемость** проектов. Методология охватывает HTML, CSS, JavaScript и файловую структуру.

---

#### **Ключевые концепции**
1. **Блок (Block)**  
   — **Независимый компонент** интерфейса (например, `menu`, `button`, `header`).  
   — **Свойства**:
  - Уникальное имя (например, `header`).
  - Может быть вложен в другие блоки, но не зависит от них.
  - Повторно используется на разных страницах.
  - **Пример**:
    ```html
    <div class="header">...</div>
    ```

2. **Элемент (Element)**  
   — **Составная часть блока**, не существующая отдельно от него (например, `menu__item`, `header__logo`).  
   — **Свойства**:
  - Привязан к блоку через двойное подчеркивание: `block__element`.
  - Не может быть использован вне блока.
  - **Пример**:
    ```html
    <div class="menu">
      <div class="menu__item">...</div>
    </div>
    ```

3. **Модификатор (Modifier)**  
   — **Свойство блока/элемента**, изменяющее его внешний вид, состояние или поведение (например, `button_disabled`, `menu_theme_dark`).  
   — **Типы**:
  - **Булевый**: `block_modifier` (например, `button_active`).
  - **Ключ-значение**: `block_modifier_key_value` (например, `menu_theme_dark`).
  - **Пример**:
    ```html
    <div class="button button_active">...</div>
    <div class="menu menu_theme_dark">...</div>
    ```

---

#### **Правила именования**
| Тип              | Формат                      | Пример                 |
|------------------|----------------------------|------------------------|
| Блок             | `block-name`               | `header`               |
| Элемент          | `block-name__element-name` | `menu__item`           |
| Модификатор блока| `block-name_modifier`      | `button_disabled`      |
| Модификатор элемента | `block-name__element-name_modifier` | `menu__item_selected` |
| Модификатор (ключ-значение) | `block-name_modifier-key_value` | `menu_theme_dark` |

---

#### **Пример структуры HTML/CSS**
```html
<!-- Блок меню с модификатором темы -->
<nav class="menu menu_theme_dark">
  <!-- Элемент списка -->
  <ul class="menu__list">
    <!-- Элемент пункта с модификатором -->
    <li class="menu__item menu__item_active">
      <a class="menu__link" href="#">Главная</a>
    </li>
  </ul>
</nav>
```

```css
/* Блок */
.menu {
  display: flex;
}

/* Элемент */
.menu__item {
  padding: 10px;
}

/* Модификатор блока */
.menu_theme_dark {
  background: #333;
  color: #fff;
}

/* Модификатор элемента */
.menu__item_active {
  font-weight: bold;
}
```

---

#### **Файловая структура**
БЭМ рекомендует организовывать файлы по блокам:
```
blocks/
  ├── menu/
  │   ├── menu.css          /* Стили блока */
  │   ├── menu__item.css    /* Стили элемента */
  │   ├── menu_theme_dark.css /* Стили модификатора */
  │   └── menu.js           /* JS-логика блока */
  ├── button/
  │   ├── button.css
  │   └── button_disabled.css
```

---

#### **Преимущества БЭМ**
1. **Модульность**: Блоки независимы и легко переиспользуются.
2. **Прозрачность**: Имена классов явно указывают на принадлежность к блоку/элементу.
3. **Контроль каскадности**: Стили привязаны к классам, а не к тегам.
4. **Масштабируемость**: Удобно добавлять новые блоки без ломки существующих.
5. **Документация**: Структура кода самодокументируема.

---

#### **Особенности и нюансы**
- **Запрет на элементы элементов**:  
  Неверно: `block__element1__element2`.  
  Верно: Создать новый блок или использовать миксы.
  ```html
  <div class="block">
    <div class="block__element">
      <div class="another-block">...</div>
    </div>
  </div>
  ```

- **Миксы**:  
  Один DOM-узел может принадлежать нескольким блокам:
  ```html
  <div class="header header_theme_dark">...</div>
  ```

- **JS-блоки**:  
  Блоки могут иметь JavaScript-реализацию (например, `menu.js` с логикой раскрытия).

---

#### **Инструменты**
- **Препроцессоры**: PostCSS, Sass (с плагинами вроде `postcss-bem`).
- **Сборщики**: Webpack, Gulp (для автоматизации сборки по БЭМ).
- **Фреймворки**: React, Vue (компоненты легко адаптируются под БЭМ).

---

#### **Итог**
БЭМ — это не просто стиль именования классов, а **целостная методология**, которая:
- Стандартизирует разработку;
- Упрощает командную работу;
- Гарантирует предсказуемость кода.  
  Для больших проектов и долгосрочной поддержки БЭМ остается одним из самых эффективных подходов.
