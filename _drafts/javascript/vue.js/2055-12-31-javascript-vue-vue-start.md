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

Простейшее приложение на vue

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

## Однофайловый компонент

Это такой компонент (`SFC`), где можно писать HTML, CSS и JavaScript, определяющие единый компонент.

Такой компонент обычно представляет собой фаил с тремя секциями.

````vue
<script setup>
// Here we write our JavaScript
</script>

<template>      
  
</template>

<style scoped>

</style>
````

### script

Здесь мы пишем `javascript` или `typescript`.

````vue
<script setup>
import { ref } from "vue";
const _hello = ref("Hello World");
</script>
````

### template

Это обычный `html` c возможностью использовать другие компоненты директивы

### style

Ограничение стилей в рамках данного компонента

## Директивы

Это специальные значения которые связывают `javascript` и `html` элемент.

### v-bind

Или `:` связывают переменную с атрибутом `html`.

Пример

````vue
<script setup>
import { ref } from "vue";
const one = ref('строка');
</script>

<template>
  <div class="logo" :id="one">1235</div>
</template>
````

### v-show

Скрывает или показывает элемент

````vue
<script setup>
const show = false;
</script>

<template>
  <div class="logo" v-show="show">1235</div>
</template>
````

### v-if, v-else и v-else-if

Это аналоги условных операторов в `javascript`, но в отличие от `v-show` они полностью удаляют элемент из дерева

### v-for и :key

Цикл `for` в `javascript`

````vue
<template>
  <span v-for="i in 100" :key="i">{{ i }}</span>
</template>
````

### v-model

Это двухстороннее связывание html элемента и его переменной в `javascript`

````vue
<input type="text" v-model="name">
````

### v-on

или `@` - это событие

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
