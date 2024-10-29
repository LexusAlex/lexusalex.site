---
title: Начать в React
description: >-
  Рассмотрим что из себя представляет react
author: alex
date: 2055-12-31 17:40:00 +0300
categories: [Javascript,React]
tags: [js,docker,react]
image:
  path: /assets/img/posts/main/vite.png
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: Знакомство с React
---

React - это библиотека для построения пользовательских интерфейсов.

## Простота

Простота react достигается благодаря декларативному стилю, компонентной архитектуре и особому механизму взаимодействия с `DOM`.

### Декларативный стиль

**Декларативный стиль** означает буквально **что должно получится**, а не как это сделать.

А вот как раз выполнение четкой последовательности команд - **это императивный стиль.**

Какие признаки использования двух стилей.

- Декларативный
  - Больше используются методы массивов, тернарные операторы, логические выражения.
  - Используется композиция функции для создания логических блоков кода.
  - Часто используются структуры с неизменяемыми данными, а новые создаются на базе существующих.
- Императивный
  - Независимые команды, которые изменяют состояние программы.
  - Используются слова `if, for, while, else`.

То есть в декларативной парадигме задачу можно решить одной строчкой, а императивной тоже самой в несколько строк.

При этом данные нигде не сохраняются, а считаются сразу на месте.

Применимо к `react`, используется декларативный подход, где описываем, то что хотим видеть.

### Взаимодействие с DOM

Компоненты - это строительные блоки которые можно переиспользовать.

Мы никогда не манипулируем с `DOM` в отличие от jquery это делает за нас `react`.

### JSX

`JSX` - это некий синтаксический сахар. По сути `jsx` - это исходный код для компиляции

React строит виртуальную модель `DOM` и будет обновлять только те компоненты которые необходимо в текущий момент времени.

Если кратко, то по реальному `DOM` дереву строится виртуальная модель `DOM React` и при изменении состояния "умный" алгоритм различий двух деревьев определяет какие элементы нужно перерендерить.

Но стоит понимать React это всего лишь библиотека, а не полноценный фреймворк.

### Что есть react

React не является полноценным фреймворком, он решает всего одну задачу, рендер `UI` элементов.

По сути из одного элемента можно построить элемент по больше, из этого элемента, собрать блок их этих элементов и т.д, это достигается благодаря компонентному подходу.

## Простой скрипт

Начать в react можно даже без установки зависимостей, докера, вот этого вот всего.

Просто создадим файл `index.html` примерно с такой разметкой.

````html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Demo react</title>
    <script src="//unpkg.com/react@18/umd/react.development.js" crossorigin></script>
    <script src="//unpkg.com/react-dom@18/umd/react-dom.development.js" crossorigin></script>
</head>
<body>
    <div id="root"></div>
    <script></script>
</body>
</html>
````

Здесь мы подключили два файла:

- `react.development.js` - ядро react
- `react-dom.development.js` - библиотека для взаимодействия с `DOM` элементами.

Мы получили доступ к глобальным объектам:

- `React`
- `ReactDOM`

Теперь немного о строительных блоках `react`:

- `React element` - это просто объект `javascript`
  - `React element DOM` - это особый объект, например `button`, они называются точно так же как реальные элементы `DOM`, на основе этих элементов react работает с обычными элементами DOM. 
  - `React component` - это готовый компонент, который может быть собран их других `React component` и `React element DOM`.

Например, компонент может быть собран из:

````text
React element DOM
React element DOM
React component
React element DOM
````

Получается композиция элементов.

> React element DOM != обычный DOM элемент
{: .prompt-info }

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

Теперь мы можем создать `React элемент DOM`, воспользуемся глобальным объектом `React` и его методом `createElement`.
Создать корневой элемент и добавить наш элемент в него.

````javascript
// Создаем элемент который будем рендерить
const divElement = React.createElement('div',{ className: 'test' },'Компонент react');
// Создаем корневой контейнер для приложения react
const root = ReactDOM.createRoot(document.getElementById('root'));
// Рендер нашего элемента
root.render(divElement);
````

Самих `react` приложений на странице может быть несколько, например, элемент у нас один, а приложений 3.

Тогда чисто в теории возможен код:

````javascript
const divElement = React.createElement('div',{ className: 'test' },'Компонент react');

const root = ReactDOM.createRoot(document.getElementById('root'));
root.render(divElement);

const root1 = ReactDOM.createRoot(document.getElementById('root1'));
root1.render(divElement);

const root2 = ReactDOM.createRoot(document.getElementById('root2'));
root2.render(divElement);
````

В результате на странице увидим:

````text
Компонент react
Компонент react
Компонент react
````

Получается мы создали три приложения `react`.

Теперь пойдем дальше и создадим вложенные элементы:

````javascript
const divElement = React.createElement('div',{ className: 'test' },
    [React.createElement('b',{key:1},[
        React.createElement('span',{style:{color:"red"},key:1},'React'),' элемент']
    )]
);
const root = ReactDOM.createRoot(document.getElementById('root'));
root.render(divElement);
````

Выше мы создали элемент `div` в который положили элемент `b`, а уже в который добавим `span`, 
контент которого покрасим в красный цвет, так же далее в `b` идет отдельно текст `элемент`.

![react](/assets/img/posts/javascript/react/react-1.png){: .shadow }
_Вложенные элементы_

````html
<div id="root">
  <div class="test">
    <b>
      <span style="color: red;">React</span> 
      элемент</b>
  </div>
</div>
````

Как видим мы просто конструируем `React element tree` как нам это нужно, с помощью нативных методов `javascript`.

Но, что делать, если нужно добавить несколько элементов в корневой элемент, при этом не создавать пустой `div`.

Чтобы писать более чистый код в react есть специальный элемент `React.Fragment`, он выступает в качестве корневого.

````javascript
const group = React.createElement(React.Fragment,null,
    React.createElement('div',null,'Первый div'),
    React.createElement('div',null,'Второй div'),
    React.createElement('div',null,'Третий div')
);
const root = ReactDOM.createRoot(document.getElementById('root'));
root.render(group);
````

> `React.Fragment` - это такой особый элемент который не выводит никакую разметку, что дает возможность не использовать пустой `div` элемент
{: .prompt-info }

В результате у нас получится чистый код:

````html
<div id="root">
  <div>Первый div</div>
  <div>Второй div</div>
  <div>Третий div</div>
</div>
````

### Комбинирование компонентов

Рассмотрим примеры:

#### Дублирование одного компонента

В примере продублируем один компонент несколько раз:

````javascript
const component1 = React.createElement('div',null,'Компонент 1');
const component2 = React.createElement(React.Fragment,null,component1,component1,component1);
ReactDOM.createRoot(document.getElementById('root')).render(component2);
````

Получаем разметку:

````html
<div id="root">
  <div>Компонент 1</div>
  <div>Компонент 1</div>
  <div>Компонент 1</div>
</div>
````

Здесь все просто, создали один элемент и продублировали его три раза.

#### Элементы меню

Теперь сделаем 5 ссылок элементов меню, более расширенный пример.

````javascript
const Item = React.createElement('li',null, React.createElement('a',{'href':'https://lexusalex.site','target':'_blank'},'Элемент меню'));
const Items = React.createElement('ul',null,Item,Item,Item,Item,Item);
ReactDOM.createRoot(document.getElementById('root')).render(Items);
````
В результате получаем разметку:

````html
<div id="root">
  <ul>
    <li><a href="https://lexusalex.site" target="_blank">Элемент меню</a></li>
    <li><a href="https://lexusalex.site" target="_blank">Элемент меню</a></li>
    <li><a href="https://lexusalex.site" target="_blank">Элемент меню</a></li>
    <li><a href="https://lexusalex.site" target="_blank">Элемент меню</a></li>
    <li><a href="https://lexusalex.site" target="_blank">Элемент меню</a></li>
  </ul>
</div>
````

> По неофициальному соглашению имена переменных в которых содержатся компоненты, начинаются с большой буквы, например `Items`.
{: .prompt-info }


Как мы поняли компоненты можно переиспользовать и комбинировать друг с другом. 
Компоненты можно использовать столько раз, сколько потребуется.

В этом мощь использования компонентов, что ускоряет разработку. 
Компоненты так же обладают некоторыми другими свойствами, но об этом ниже.

## Свойства

Свойства или `props` - это **неизменяемое значение** внутри элемента.

Они очень похожи на атрибуты, например `href` или `title`.

> Самое важное, понять, что значение из свойства можно только читать. Так же не следует редактировать или добавлять свойства внутри самого компонента. Этим должен заниматься родительский элемент.
{: .prompt-info }

Перепишем пример с меню выше, для этого вынесем `Item` в **функциональный компонент.**

Код становится сложнее.

````javascript
// Функциональный компонент Item, куда передаем свойства.
function Item({ nameLink, Link }) {
    return React.createElement('li',null, React.createElement('a',{'href':Link,'target':'_blank'},nameLink));
}

const Items = React.createElement('ul',null,
    // Вызов нашего компонента с передаечей в него props
    React.createElement(Item,{nameLink:'lexusalex.site',Link: 'https://lexusalex.site'}),
    React.createElement(Item,{nameLink:'lexusalex.ru',Link: 'https://lexusalex.ru'}),
    React.createElement(Item,{nameLink:'ya.ru',Link: 'https://ya.ru'}),
    React.createElement(Item,{nameLink:'google.com',Link: 'https://google.com'}),
    React.createElement(Item,{nameLink:'mail.ru',Link: 'https://mail.ru'}),
);
ReactDOM.createRoot(document.getElementById('root')).render(Items);
````

В результате будет выведена ожидаемая разметка:

````html
<div id="root">
  <ul>
    <li><a href="https://lexusalex.site" target="_blank">lexusalex.site</a></li>
    <li><a href="https://lexusalex.ru" target="_blank">lexusalex.ru</a></li>
    <li><a href="https://ya.ru" target="_blank">ya.ru</a></li>
    <li><a href="https://google.com" target="_blank">google.com</a></li>
    <li><a href="https://mail.ru" target="_blank">mail.ru</a></li>
  </ul>
</div>
````

Например, ссылки мы хотим использовать еще и в другом месте, для этого их можно вынести ссылки в самостоятельный компонент.

````javascript
// Функциональный компонент
function Item({ nameLink, Link }) {
   return React.createElement('li',null, React.createElement('a',{'href':Link,'target':'_blank'},nameLink));
}
// Отдельный компонент для вывода ссылок
function Links() {
    return React.createElement(React.Fragment,null,
        React.createElement(Item,{nameLink:'lexusalex.site',Link: 'https://lexusalex.site'}),
        React.createElement(Item,{nameLink:'lexusalex.ru',Link: 'https://lexusalex.ru'}),
        React.createElement(Item,{nameLink:'ya.ru',Link: 'https://ya.ru'}),
        React.createElement(Item,{nameLink:'google.com',Link: 'https://google.com'}),
        React.createElement(Item,{nameLink:'mail.ru',Link: 'https://mail.ru'})
    )
}
// Вывод
const Items = React.createElement('ul',null,React.createElement(Links));
ReactDOM.createRoot(document.getElementById('root')).render(Items);
````

Не стоит забывать, что это обычный `javascript`, и мы тут ничего не изобрели. Мы просто комбинируем, компоненты как нам нужно.




В качестве корневого "узла" используют React fragment `<></>` или `<React.Fragment></React.Fragment>`.

Функциональный компонент - это функция в название которой начинается с большой буквы.
Функциональный компонент возвращает либо `React элемент` либо `null`.

Дерево react элементов, от корневого элемента

> React element tree != DOM tree
{: .prompt-info }

