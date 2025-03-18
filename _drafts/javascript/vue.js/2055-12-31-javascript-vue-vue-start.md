---
title: Понимаем Vue
description: >-
  Разбираемся вместе со Vue 3
author: alex
date: 2055-06-08 22:40:00 +0300
categories: [Javascript,Vue]
tags: [js,vue]
image:
  path: /assets/img/posts/main/javascript.png
  alt: Понимаем Vue
---

## Библиотека и фреймворк

Сначала для себя четко поймем в чем отличие библиотеки от фреймворка.

Касаемо библиотеки программист сам решает когда ее использовать и как применять, фреймворк наоборот диктует свои условия его использования - это основно и базовое отличие.

Как правило, **библиотека** - это набор функций, которые можно использовать если требуется. 

**Фреймворк** - это скелет приложения, который работает с нашим кодом. У него есть структура, которая помогает разработчику.

## Приложение на vue

````html
<html>
  <head>         
    <script src="https://unpkg.com/vue@3"></script>
  </head>
  <body>
        
    <div id="app">{{ message }}</div>
    <script>
      const { createApp } = Vue;
      createApp({
        data() {
          return { message: "Hello World!" };
        },
      }).mount("#app");
    </script>
  </body>
</html>
````




https://vue-faq.org/ru/book/Chapter_1__The_Vue_3_Framework.html#%D0%B8%D1%81%D0%BF%D0%BE%D0%BB%D1%8C%D0%B7%D0%BE%D0%B2%D0%B0%D0%BD%D0%B8%D0%B5-vue-%D0%B2-%D0%B2%D0%B5%D0%B1-%D0%BF%D1%80%D0%B8%D0%BB%D0%BE%D0%B6%D0%B5%D0%BD%D0%B8%D0%B8

Реактивность
Компоненты
Composables - отладка
Пропсы и атрибуты
События
Слоты
Архитектура - Как правильно писать Composables
Как дробить компоненты
Как вызывать внешние сервисы
Интергации
Обработка ошибок
Экосистема
Pinia
TanStackQuery

Декларативный DOM - расширеный html директивы v-model

Принципы приложений


Timer WebSocker
Изменение состояния
State - это данные которые изменяются с течением времени
code
events
UI - Интерфейс

Перерисовка html только тогда когда данные которые они отображают изменились

Декларативность - описываем что мы хотим получить



https://vue-faq.org/ru/book/
