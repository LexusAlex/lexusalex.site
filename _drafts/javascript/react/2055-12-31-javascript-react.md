---
title: React
description: >-
  
author: alex
date: 2055-12-31 18:00:00 +0300
categories: [React Javascript]
tags: []
---

React - библиотека для построения пользовательских интерфейсов

https://www.youtube.com/watch?v=P7r1Pv8JOYk
 
TODO Остановился https://www.youtube.com/watch?v=nZJdssI5hS4

## Преимущества react


 
## Новый проект на react

## Способы установки

- Декларативность. Набор инструкций
- Компонентный подход

Достаточно легко создать сложный интерфейс 

Много рутинной работы делать все руками.
Реакт все работу берет на себя.

- Одиночные теги и парные теги

Вывод js

Сначала выражение вычисляется потом оно, передается как children

````jsx
// Это в любом месте jsx  кода
{cinemas[0].name}
// Так же в атрибутах работает также
<div id={2}></div> 
````
 
Методы массивов в каждой конкретной ситуации решат нашу проблему

Можно передать любой валидный javascript
 
Например:

````jsx
<div>
  {cinemas.map((c) => (
    <div key={c.id}>
      <div>{c.name}</div>
      <div>{c.films.map((f) => (
        <ul key={f.id}>
          <li>{f.name}</li>
        </ul>
      ))}
      </div>
      <div>{c.reviews.map((r) => (
        <ul key={r.id}>
          <ol>{r.text}</ol>
        </ul>
      ))}
      </div>
    </div>
  ))}
</div>
````

Проверить на наличие ключа в массиве и стоит ли вообще выводить

## Условный рендеринг

````jsx
{c.films.length ? (<div>Что-то</div>):(<div>Тогда-то</div>)}
````

## JSX

## Компоненты

Компоненты включают в себе элементы и другие компоненты

- Многократное использование

Выносить части в отдельные компоненты

Два вида компонентов:

- Функциональный - актуальный выбор
- Классовый (deprecated)

Функциональный компонент это чертеж (инструкция) (это не сам dom) как что-то сделать.
Используя одну инструкцию создаем любое ко-во компонентов.

Для `react` важны две вещи

- С помощью какой инструкции мы создавали
- Где мы создавали

Пользовать будет взаимодействовать с компонентом и у него будет меняться состояние.

### Создание компонента

- Экспорт компонента
- Определение функции с большой буквы
- return

````jsx
// Определение
export function App() {
  return <div>1</div>
}
// Использование
<App></App>
<App></App>
<App></App>
<App></App>
<App></App>
<App></App>
<App></App>
````

То есть инструкция одна, а результатов много.

Нам важно результат выполнения конкретного чертежа

## Декомпозиция кода

Как понять как двигаться

Подход сверху вниз. Реализовать все в одном файле, а потом делить на компоненты.
Этот подход самый лучший.

Принцип Dont' repeat your self не повторяйся.

Не весь повторяющеюся код стоит выносить.
Только в случае если код делает одно и тоже

Избыточная универсальность ui kit монстр. Нужна золотая середина

Буквы `s` говорит что у нас что-то в множественном числе

React fragment `<></>` или `<React.Fragment></React.Fragment>`

## Props

props это всегда объект.

Первый параметр в функциональном компоненте - всегда props

Передать `<Cinema key={c.id} c={c}/>`
Принять `export function Cinema ({c}) {}`

Пропсов можно передать сколь-угодно много

## Children

## Ключи

Реакту нужно, чтобы у элемента был уникальный ключ.
Ключи помогают реакту для перерендера элементов.

Если рисуете списки обязательно, добавляете ключи.

## Hooks

Это функции, с особыми возможностями в рамках react компонентов.

Или внутри других хуков. Делают много вещей в рамках функциональных компонентов.

Правила:

- Все хуки начинаются с `use`.
- Использовать хуки можно только в функциональных компонентах либо в других хуках.
- Применяй хуки без условий и циклов только так и всегда.

### UseState

Добавляет состояние в компонент.
Позволяет сделать компонент без состояния, компонент с состоянием.

Когда мы вызываем функцию set... мы передаем туда какое-то значение

Измерение состояния одна из основных причин перерендера и все дочерние элементы тоже перерендериваются
 
Дефолтное значение вызывается один раз

### UseEffect

Если мы вызываем функцию то она будет вызвана во время рендера.

Хук позволяет запланировать выполнение функции. Вазимодействие с актуальным домом

````jsx
// Взаимодействие с дом
useEffect(() => {
  window.addEventListener('scroll', () => console.log('123'))
}, []);
````

Планирование будет происходить на каждом рендере без массива зависимостей.
Зависимости влият на выполнение функции.

### useCallback

Не отвечает за создание функции.
Он просто хранит ссылку на функцию, но функция создается всегда

### useMemo

## Как работает react
Все реакт элементы образуют деревья:

- Реакт элементов
- Дерево файберов

Детальный разбор работы react https://blog.frontend-almanac.ru/z1S4MzuquZd

Элемент остается на конкретной позиции в дереве

- mount - операция дороже чем рендер в большинстве случаев
- перерендер
- destroy

