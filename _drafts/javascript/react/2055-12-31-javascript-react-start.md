---
title: Начать в React
description: >-
  Рассмотрим что из себя представляет react
author: alex
date: 2055-12-31 17:40:00 +0300
categories: [ Javascript,React ]
tags: [ js,docker,react ]
image:
  path: /assets/img/posts/main/react.png
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: Начать в React
---

## Приложение

Напишем простое приложение с выводом текущего времени и списка элементов.

### Начало

Возьмем для примера стандартную `html` страницу примерно с такой версткой и с одним единственным элементом `div`.

````html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>React</title>
</head>
<body>
<div id="root"></div>
<script src="React.js"></script>
</body>
</html>
````
{: file='index.html'}

Внутри `html` подключим скрипт `React.js`, и далее весь код будем писать там для удобства.

Выведем текущее время и список товаров используя нативный `javascript`.

Выглядеть он будет следующим образом:

````javascript
// Глобальные переменные
const state = {
  date: new Date().toLocaleTimeString('ru-RU'),
  data: [
    {id: 89, name: "good1", count: 3},
    {id: 123, name: "good2", count: 8},
    {id: 5, name: "good3", count: 56}
  ]
}

// div в который все обернем
let application = document.createElement('div');
application.className = 'application';

// Текущее время
let time = document.createElement('div');
time.className = "time";
time.innerText += state.date;

// данные
const data = document.createElement('div');
data.className = "data";

state.data.forEach((d) => {
  const div = document.createElement('div');
  const name = document.createElement('div');
  name.innerText = d.name;
  div.append(name);

  const count = document.createElement('div');
  count.innerText = d.count;
  div.append(count);

  data.append(div);
});

// корневой элемент
const main = document.getElementById('root');

// добавляем в приложение
application.append(time);
application.append(data);

// добавляем в корневой div
main.append(application);
````
{: file='React.js'}

В результате получаем ожидаемую верстку:

````html
<div class="application">
  <div class="time">22:34:34</div>
  <div class="data">
    <div>
      <div>good1</div>
      <div>3</div>
    </div>
    <div>
      <div>good2</div>
      <div>8</div>
    </div>
    <div>
      <div>good3</div>
      <div>56</div>
    </div>
  </div>
</div>
````

Вроде бы все хорошо, все работает, но код выглядит мягко говоря некрасиво.

Улучшим его.

### Разнесение кода на функции

Попробуем разнести код на функции, примерно так.

````javascript
// Глобальное состояние
const state = {
  date: new Date().toLocaleTimeString('ru-RU'),
  data: [
    {id: 89, name: "good1", count: 3},
    {id: 123, name: "good2", count: 8},
    {id: 5, name: "good3", count: 56}
  ]
}

// Текущее время
function Time(state) {
  let time = document.createElement('div');
  time.className = "time";
  time.innerText += state.date;
  return time;
}

// Данные
function Data(state) {
  const data = document.createElement('div');
  data.className = "data";

  state.data.forEach((d) => {
    const div = document.createElement('div');
    const name = document.createElement('div');
    name.innerText = d.name;
    div.append(name);

    const count = document.createElement('div');
    count.innerText = d.count;
    div.append(count);

    data.append(div);
  });
  return data;
}

// Приложение
function Application(state) {
  let application = document.createElement('div');
  application.className = 'application';
  application.append(Time(state));
  application.append(Data(state));
  return application;
}

// Корневой элемент
function Root() {
  return document.getElementById('root');
}

// Рендер всего приложения
function Render(Dom,Root) {
  Root.append(Dom);
}

Render(Application(state), Root());
````

Вот так работать с этим становится приятнее.

Посмотрим что тут происходит:

Первое, что мы тут делаем - это определяем глобальное состояние объектов, константа `state`, в нашем случае текущее время и данные.

Далее мы создаем функции для вывода всех основных блоков `Application, Time, Data, Root`.

Отдельно остановимся на рендере приложения. 

Это функция куда передаем новое `DOM` дерево и корневой элемент куда нужно вставить это дерево.

Конечный результат вставляется в `div#root`.

### Тикающие часы

Внесем динамику на нашу страницу, сделаем часы динамическими, с помощью `setInterval`

````javascript
setInterval( () => {
    // Получим объекты приложения и время
    const app = document.querySelector("#root > .application");
    const time = app.querySelector(".time");
    
    // Сгенерируем новое время
    state.date = new Date().toLocaleTimeString('ru-RU');
    
    // Заменим старое время - новым
    app.replaceChild(Time(state), time);
}, 1000)
````

В коде выше раз в секунду запускается повторный вызов функции `Time` с передачей туда нового времени.

Мы написали его таким образом, чтобы менялся элемент полностью, а не только происходило обновление времени.

Такой подход дает некое преимущество, так как мы повторно переиспользуем функцию `Time`, для создания элемента часов.






Если значение в объекте javascript совпадает со значением свойства - его можно сократить, из `{ name: name }` в `{ name }`.


> Если в выражении const A = {data: 123}, позже значение нельзя переопределить, так как это константа, но работать с самим объектом внутри можно, ограничений нет.
> {: .prompt-info }

С помощью javascript удобнее манипулировать элементами

`React` использует нативный js, позволяющий через синтаксис `JSX` заменять создание `html` элементов
`Vue` имеет шаблонизатор, который удобен верстальщику.
`React` для программиста, `Vue` для верстальщика.





Остановился
https://deworker.pro/edu/series/what-is-react/javascript-render

Распределить главы

React - это библиотека для построения пользовательских интерфейсов.

## Простота

Простота react достигается благодаря декларативному стилю, компонентной архитектуре и особому механизму взаимодействия с
`DOM`.

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

React строит виртуальную модель `DOM` и будет обновлять только те компоненты которые необходимо в текущий момент
времени.

Если кратко, то по реальному `DOM` дереву строится виртуальная модель `DOM React` и при изменении состояния "умный"
алгоритм различий двух деревьев определяет какие элементы нужно перерендерить.

Но стоит понимать React это всего лишь библиотека, а не полноценный фреймворк.

### Что есть react

React не является полноценным фреймворком, он решает всего одну задачу, рендер `UI` элементов.

По сути из одного элемента можно построить элемент по больше, из этого элемента, собрать блок их этих элементов и т.д,
это достигается благодаря компонентному подходу.

## Простой скрипт

Начать в react можно даже без установки зависимостей, докера, вот этого вот всего.

Просто создадим файл `index.html` примерно с такой разметкой.

https://unpkg.com/react@19.0.0/cjs/react.development.js

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
  - `React element DOM` - это особый объект, например `button`, они называются точно так же как реальные элементы `DOM`,
    на основе этих элементов react работает с обычными элементами DOM.
  - `React component` - это готовый компонент, который может быть собран их других `React component` и
    `React element DOM`.

Например, компонент может быть собран из:

````text
React element DOM
React element DOM
React component
React element DOM
````

Получается композиция элементов.

> React element DOM != обычный DOM элемент
> {: .prompt-info }

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
const divElement = React.createElement('div', {className: 'test'}, 'Компонент react');
// Создаем корневой контейнер для приложения react
const root = ReactDOM.createRoot(document.getElementById('root'));
// Рендер нашего элемента
root.render(divElement);
````

Самих `react` приложений на странице может быть несколько, например, элемент у нас один, а приложений 3.

Тогда чисто в теории возможен код:

````javascript
const divElement = React.createElement('div', {className: 'test'}, 'Компонент react');

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
const divElement = React.createElement('div', {className: 'test'},
  [React.createElement('b', {key: 1}, [
    React.createElement('span', {style: {color: "red"}, key: 1}, 'React'), ' элемент']
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
const group = React.createElement(React.Fragment, null,
  React.createElement('div', null, 'Первый div'),
  React.createElement('div', null, 'Второй div'),
  React.createElement('div', null, 'Третий div')
);
const root = ReactDOM.createRoot(document.getElementById('root'));
root.render(group);
````

> `React.Fragment` - это такой особый элемент который не выводит никакую разметку, что дает возможность не использовать
> пустой `div` элемент
> {: .prompt-info }

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
const component1 = React.createElement('div', null, 'Компонент 1');
const component2 = React.createElement(React.Fragment, null, component1, component1, component1);
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
const Item = React.createElement('li', null, React.createElement('a', {
  'href': 'https://lexusalex.site',
  'target': '_blank'
}, 'Элемент меню'));
const Items = React.createElement('ul', null, Item, Item, Item, Item, Item);
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

> По неофициальному соглашению имена переменных в которых содержатся компоненты, начинаются с большой буквы, например
`Items`.
> {: .prompt-info }


Как мы поняли компоненты можно переиспользовать и комбинировать друг с другом.
Компоненты можно использовать столько раз, сколько потребуется.

В этом мощь использования компонентов, что ускоряет разработку.
Компоненты так же обладают некоторыми другими свойствами, но об этом ниже.

## Свойства

Свойства или `props` - это **неизменяемое значение** внутри элемента.

Они очень похожи на атрибуты, например `href` или `title`.

> Самое важное, понять, что значение из свойства можно только читать. Так же не следует редактировать или добавлять
> свойства внутри самого компонента. Этим должен заниматься родительский элемент.
> {: .prompt-info }

Перепишем пример с меню выше, для этого вынесем `Item` в **функциональный компонент.**

Код становится сложнее.

````javascript
// Функциональный компонент Item, куда передаем свойства.
function Item({nameLink, Link}) {
  return React.createElement('li', null, React.createElement('a', {'href': Link, 'target': '_blank'}, nameLink));
}

const Items = React.createElement('ul', null,
  // Вызов нашего компонента с передаечей в него props
  React.createElement(Item, {nameLink: 'lexusalex.site', Link: 'https://lexusalex.site'}),
  React.createElement(Item, {nameLink: 'lexusalex.ru', Link: 'https://lexusalex.ru'}),
  React.createElement(Item, {nameLink: 'ya.ru', Link: 'https://ya.ru'}),
  React.createElement(Item, {nameLink: 'google.com', Link: 'https://google.com'}),
  React.createElement(Item, {nameLink: 'mail.ru', Link: 'https://mail.ru'}),
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

Например, ссылки мы хотим использовать еще и в другом месте, для этого их можно вынести в самостоятельный компонент
`links`.

````javascript
// Функциональный компонент
function Item({nameLink, Link}) {
  return React.createElement('li', null, React.createElement('a', {'href': Link, 'target': '_blank'}, nameLink));
}

// Отдельный компонент для вывода ссылок
function Links() {
  return React.createElement(React.Fragment, null,
    React.createElement(Item, {nameLink: 'lexusalex.site', Link: 'https://lexusalex.site'}),
    React.createElement(Item, {nameLink: 'lexusalex.ru', Link: 'https://lexusalex.ru'}),
    React.createElement(Item, {nameLink: 'ya.ru', Link: 'https://ya.ru'}),
    React.createElement(Item, {nameLink: 'google.com', Link: 'https://google.com'}),
    React.createElement(Item, {nameLink: 'mail.ru', Link: 'https://mail.ru'})
  )
}

// Вывод
const Items = React.createElement('ul', null, React.createElement(Links));
ReactDOM.createRoot(document.getElementById('root')).render(Items);
````

Не стоит забывать, что это обычный `javascript`, именно он выполняется в браузере, и мы тут ничего не изобрели.
Мы просто комбинируем, компоненты как нам нужно.

## JSX

Но, созданные элементы все равно выглядят громоздко. Чтобы улучшить читаемость, нам поможет `JSX`.

`JSX` - это специальная надстройка над `javascript`.

Сравним обычное создание элемента:

````javascript
React.createElement('a', {'href': Link, 'target': '_blank'}, "Текст ссылки")
````

Создадим такой-же элемент с использованием `JSX`.

````jsx
<a href="https://lexusalex.site" target="_blank">Текст ссылки</a>
````

> Важно понимать, что `JSX` это не строка, не `HTML`, это объект `javascript`. Который делает создание элементов,
> компактнее и упрощает чтение.
> {: .prompt-info }

> JSX создан только для разработчиков, под капотом, он преобразуется в тот же javascript, который мы писали выше.
> {: .prompt-info }

Согласитесь, читать `JSX`, проще, чем обычный `javascript`.

Писать `React` компоненты, можно и без `JSX`, это дело вкуса.

Итак, `JSX` упрощает написание кода, он выглядит как `HTML`.

К тому же `React` по умолчанию предполагает использование синтаксиса `JSX`, и выводит полезные сообщения об ошибках.

Код `JSX` компилируется в стандартный `ECMAScript`, но при этом `javascript` не является.

Сам процесс преобразования из `JSX` в стандартный `javascript` код который работает в браузере, называется *
*транспиляция**.

**Транспиляция** - это преобразование синтаксиса с одного исходного языка в другой, то есть `JSX` в чистый `javascript`.

Создадим полностью идентичные компоненты `TestComponentJsx` и `TestComponentJs`, и сравним полученную разметку.

````jsx
function TestComponentJsx() {
  return (<div className="test" title="pest"><p><b>Текст</b></p></div>);
}

function TestComponentJs() {
  return React.createElement('div', {
    'className': 'test',
    'title': 'pest'
  }, React.createElement('p', null, React.createElement('b', null, 'Текст')));
}
````

````html
<!-- JSX -->
<div id="root">
  <div class="test" title="pest"><p><b>Текст</b></p></div>
</div>
<!-- Javascript -->
<div id="root">
  <div class="test" title="pest"><p><b>Текст</b></p></div>
</div>
````

Как видим разницы никакой, но кода значительно больше.

> Стандартные компоненты, такие как h1,div,span и другие, записывают как <h1>, а не стандартные, то есть
> пользовательские пишут в большой буквы, например <Items />
> При этом закрывающий тег может быть, а может и не быть, об этои ниже.
> {: .prompt-info }

> Если возврат из компонента многострочный, то его оборачивают в круглые скобки `()` в конструкции `return (...)` или в
> присвоении в переменную const e = (...)
> {: .prompt-info }


> До этого момента мы не использовали сервер для разработки, а запускали просто в браузере, и так тоже можно, но удобнее
> будет развернуть окружение для разработки.
> Об этом я написал
> заметку [https://lexusalex.site/posts/javascript-react-pure-react/](https://lexusalex.site/posts/javascript-react-pure-react/),
> на этом останавливаться не будем.
> Далее у нас уже развернуто окружение для разработки.
> {: .prompt-info }

### Переменные

Переменные в `JSX` выводятся с обрамлением их в фигурные скобки `{}`.

> В `{}` может быть любой валидный javascript код.
> {: .prompt-info }

Для демонстрации использования подстановки переменных создадим компонент `App`:

````jsx
export function App() {
  // Переменные подстанавливаются в фигурных скобках
  const text = 'Текст';
  const date = new Date().toLocaleDateString();
  const arr = [1, 2, 3];
  const obj = {a: 1, b: 2};
  // Теги должны быть обязательно закрыты
  const newTag = <b>Жирная строка</b>;
  // В атрибутах тоже работает
  const attr = "titleValue";
  return (
    <div>
      <p>
        <div title={attr}>{text}</div>
        <div>Дата {date}</div>
        <div>{arr[1]}</div>
        <div>{obj.b}</div>
        <div>{"Просто вывод"}</div>
        <div>{1 + 1}</div>
        <div>{newTag}</div>
      </p>
    </div>
  );
}
````

Что будет в разметке:

````text
Текст
Дата 10/30/2024
2
2
Просто вывод
2
Жирная строка
````

Работает с массивами, объектами, любыми вычислениями в `javascript`.

Для наглядности выведем текущую дату в обычном javascript коде.

````javascript
const date = new Date().toLocaleDateString();
console.log(`Встраивание даты в строку ${date}`);
````

и в `JSX`:

`````jsx
const date = new Date().toLocaleDateString();
<div>Встраивание даты в строку {date}</div>
`````

### Атрибуты

Атрибуты задаются здесь, так же и в `HTML` в формате `p1=v p2=v2`.

Неявно в каждый компонент передается некий объект `props` - это переданные свойства от родительского элемента.

````jsx
// Вызов компонента App
<App test="123"/>

// В компоненте App выводим наше свойство
export function App(props) {
  return (
    <div>{props.test}</div> // 123
  );
}

// Даже если ничего не передать props все равно существует, он пустой
export function App(props) {
  console.log(props); // Object
  return (
    <div></div>
  );
}
````

Можно сразу провести деструктуризацию, например

````jsx
<App test1={"123"} test2={"456"}/>

export function App({test1, test2}) {
  return (
    <>
      <div>{test1}</div>
      // 123
      <div>{test2}</div> // 456
    </>
  );
}
````

> React будет рендерить все свойства даже если их нет в спецификации HTML
> {: .prompt-info }

Если нужно показать объект, то просто передаем его параметрами

````jsx
const test = {'id': 1, 'name': 'test'}
<App id={test.id} name={test.name}/>

export function App({id, name}) {
  return (
    <>
      <div>{id}</div>
      <div>{name}</div>
    </>
  );
}
````

Если объект большой, то можно не перечислять каждое из свойств, можно воспользоваться `spread` оператором.

````jsx
const test = {'id': 1, 'name': 'test'}
<App {...test}/> // При таком будут отрендерены все свойства объекта
export function App(test) {
  return (
    <>
      <div>{test.id}</div>
      <div>{test.name}</div>
    </>
  );
}
````

Наиболее безопасным способом, как мне кажется является точное перечисление свойств, только так можно передать
определенное их количество.
В случае со `spread` оператором, в объекте может быть произвольное количество свойств.

### Условные конструкции

Понятно, что в любой программе без условий никуда. По сути это же `javascript`, а это значит можно использовать любые
языковые конструкции.

Например, здесь используем тернарный оператор.

````jsx
export function App() {
  let arr = [1, 2, 3];
  // Проверяем, что массив не пуст
  let res = arr.length ? (<div>В массиве что-то есть</div>) : (<div>Массив пуст</div>);
  return (
    <>{res}</>
  );
}
````

Так же можно сделать быстрый возврат, если не нужно, что бы код двигался дальше.

````jsx
export function App() {
  let page = 'test';
  // Если не test, то выходим ничего не рендеря
  if (page !== 'test') {
    return null;
  }
  // Дошли до сюда выводим нужную строку
  return <>page test</>
}
````

> Компонент возвращает либо React элемент, либо null
> {: .prompt-info }

Еще используют логическое `&&` для выполнения того или иного рендера.

````jsx
function Verified() {
  // Сложный и тяжелый рендер
  return (<>verified</>);
}

export function App() {
  let isVerified = true;
  let check = true;
  // Код не дойдет до рендера если хотя бы одно значение будет false
  // Ложные значение это false,0,"",null,Undefined,Nan
  return (<>{isVerified && check && <Verified/>}</>)
}
````

Проверки можно вставлять в любое место `JSX`. Для сложных случаев ветвления лучше набросать структуру отдельно, а потом
уже реализовывать.

> Если компонент не содержит дочерних элементов, рекомендуется писать его одиночным тегом, в противном случае парным
> тегом.
> {: .prompt-info }

### На что обратить внимание

1. Закрывающий слеш обязателен в парных тегах `<Item></Item>` и в одинарных `<Item />`
2. `JSX` автоматически экранирует специальные символы html такие как `&nbsp;` или `&copy;`
3. Атрибут `style` это объект, например такой `{'fontSize':'10px','color':'red'}`, но если передать значение напрямую,
   получим ошибку, чтобы этого избежать в двойных фигурных скобках `{{'fontSize':'10px','color':'red'}}`
4. Другие имена для атрибутов `class` и `for`, вместо них следует использовать `className` и `htmlFor`, в остальном
   имена атрибутов в `html` совпадают с `jsx`. + все атрибуты нужно писать в верблюжьей нотации, например `autoPlay`
   вместо `autoplay` или `maxLength` вместо `maxlength` (`React` просто такие атрибуты не увидит).
5. В элементах форм атрибуты `disabled,required,checked,autofocus,readOnly`, нужно писать так`<input disabled={false}/>`
   а не так `<input disabled="false"/>`, так как `false` это не пустая строка, следовательно, это `true`. Если написать
   `<input required />`, React будет считать это значение `true`

Так же можно воспользоваться инвертированием значения:

````jsx
let edit = false;
<input required={!edit}/>
````

6. Символы новой строки `jsx` не считает пробелами.

Пример, текст будет выведен в одну строку:

```jsx
<>
  Тест
  <em>Тест2</em>
  Тест3
</>
```

````html
ТестТест2Тест3
````

Как, все-таки дать понять `React`, что пробелы нужны и важны.
Просто указать в выражении.

````jsx
<>
  Тест <em>Тест2</em> Тест3
</>
````

````html
Тест Тест2 Тест3
````

Либо еще вариант, добавить пробелы искусственно

````jsx
<>
  Тест
  {" "}
  <em>Тест2</em>
  {" "}
  Тест3
</>
````

````html
Тест Тест2 Тест3
````

## Дочерние элементы - свойство children

Теперь разберемся с дочерними элементами. Это такие элементы которые непосредственно лежат в родительском элементе.

У нас есть следующий `JSX`:

````jsx
export function App(test) {
  return (
    <Parent>
      <Child type="1"></Child>
      <Child type="2"></Child>
      <Child type="3"></Child>
      <Child type="4"></Child>
      <Child type="5"></Child>
    </Parent>
  );
}
````

Нужно из компонента `Parent` получить доступ к дочерним элементам, у нас их 5, компонент выглядит примерно так

````jsx
function Child(props) {
  return (<div></div>)
}
````

Далее в компоненте `Parent` мы получаем доступ ко всем его дочерним элементам, доступ к конкретному пропсу.

````jsx
function Parent(props) {
  return (<>{props.children[4].props.type}</>) // 5
}
````

> При рендере элементов из массива или другого списка в свойство key рекомендуется подставлять не индекс массива, а
> уникальный идентификатор элемента, это сбережет от ошибок в будущем.
> Каждый дочерний узел должен иметь уникальное свойство `key`.
> {: .prompt-info }

## React Fragment

В качестве корневого "узла" удобно использовать `React fragment` `<></>` или `<React.Fragment></React.Fragment>`.

Атрибуты и свойства здесь не используются, но можно использовать свойство `key` для указания уникального ключа, к
примеру при переборе

````jsx
export function App() {
  return (
    <>
      <Fragment>1</Fragment>
      <Fragment>2</Fragment>
      <Fragment>3</Fragment>
    </>
  )
}
````

## Функциональные компоненты

Долгое время в `React` использовались компоненты на базе классов. Функциональный компонент представляет более компактный
тип записи.

Мы с ними уже знакомы с функциональными компонентами, мы использовали их выше. Здесь мы расширим это понятие.

**Функциональный компонент** - это функция в название которой начинается с большой буквы.

> Функциональный компонент возвращает либо `React элемент` либо `null`.
> {: .prompt-info }

> Любое значение, которое может быть выполнено в виде обычной функции, возвращающая jsx, может быть компонентом.
> {: .prompt-info }

В функциональный компонент всегда в первый аргумент передаются свойства.

```jsx
export function App(props) {
  return (
    <div>{props.test}</div>
  );
}
```

Для более удобного доступа к свойствам применяют деструктуризацию.

```jsx
export function App({test}) {
  return (
    <div>{test}</div>
  );
}
```

Так же если свойство не указано можно определить значение по умолчанию

```jsx
export function App({test = "test"}) {
  return (
    <div>{test}</div>
  );
}
```

В итоге функциональный компонент дает нам некоторые преимущества над классовыми компонентами:

- Содержат меньше строк кода.
- Функциональные компоненты проще читать
- Можно
  писать [чистые функции](https://lexusalex.site/posts/php-dependency-injection-container/#%D1%84%D1%83%D0%BD%D0%BA%D1%86%D0%B8%D1%8F-%D0%B7%D0%B0%D0%B2%D0%B8%D1%81%D1%8F%D1%89%D0%B0%D1%8F-%D0%BE%D1%82-%D1%81%D0%B2%D0%BE%D0%B8%D1%85-%D0%BF%D0%B0%D1%80%D0%B0%D0%BC%D0%B5%D1%82%D1%80%D0%BE%D0%B2)
- Удобно тестировать компонент

## Состояние

**Состояние** - это способность компонента изменяться по средствам внутренних переменных.

Не очень понятно, давай-те разберемся.

Без состояния приложение было бы статичным и никак не реагировало на действия пользователя. Например, при нажатии на
кнопку, что-то должно происходить.
Приложение `React` состоит из набора компонентов, вместе они и определяют приложение. Компоненты могут быть с состоянием
и без состояния.

**Компонент с состоянием** может обновляться на основании внутренних механизмов `React`, а вот **компонент без состояния
** обновляется только тогда, когда родительский компонент даст ему такую команду.

То есть состояние компонента это механизм, который хранит и изменяет значение в компоненте со временем.

> Небольшую заметку про состояние я уже
> писал [https://lexusalex.site/posts/basics-stateful-and-stateless/](https://lexusalex.site/posts/basics-stateful-and-stateless/)
> {: .prompt-info }

Примерный разброс компонентов в приложении может быть таким.

````text
Корень
    Компонент без состояния
    Компонент без состояния
    Компонент с состоянием
    Компонент с состоянием
        Компонент с состоянием
            Компонент без состояния
        Компонент с состоянием
        Компонент без состояния
            Компонент без состояния
                Компонент с состоянием
                    Компонент без состояния
                    Компонент без состояния
                    Компонент без состояния
                    Компонент без состояния
                    Компонент без состояния
                    Компонент без состояния
                        Компонент с состоянием
                            Компонент с состоянием
                            Компонент с состоянием
                            Компонент с состоянием
                    Компонент без состояния
                    Компонент с состоянием
````

Компоненты с состоянием преимущественно располагаются в верхней части родительского элемента.

Состояние, как правило, хранят в компонентах где оно используется.

Например, его состоянием можно хранить в любом родительском компоненте выше.

````text
Корень
    Компонент без состояния
        Компонент без состояния
            Компонент без состояния
                Компонент с состоянием
````

> Существует рекомендация, что состояние лучше хранить как можно ближе к корню, но это дело вкуса.
> {: .prompt-info }


> Важный момент что `React element tree` != `DOM tree`, это абсолютно разные вещи.
> {: .prompt-info }


Следующий вопрос, что можно хранить в состоянии компонента

### Что хранить

Первое, что приходит на ум - это данные приложения, имя пользователя при логине,залогинен пользователь, список покупок
пользователя, все те данные которые специфичны для пользователя.
Следующий момент - это интерфейс, различные табы, кнопки, цвета, то есть временные данные, которые нужны лишь для
визуального отображения и никак не связаны с пользовательскими данными.
Так же в состояние можно хранить данные полей формы.
То есть в состоянии компонента храним изменяемые данные.

Данные которые не нужно хранить в состоянии - это статичные данные.

### Как задать состояние. Функция useState

Теперь необходимо сообщить `React`, что данные поменялись, и компонент нужно обновить.

Это можно сделать с помощью специальной функции `useState`, функция вернет текущее значение, новое значение и функцию
обновления.

В базовом варианте это выглядит так:

````jsx
export function App() {
  //Текущее значение, функция установки нового значения, дефолтное значение
  const [counter, setCounter] = useState(10);
  return (
    <>
      <button onClick={() => setCounter(value => value + 1)}>+1 Клик</button>
      // Обновление значения по клику
      <br/>
      {counter} // Текущее состояние
    </>
  )
}
````

![react](/assets/img/posts/javascript/react/react-2.png){: .shadow }
_useState_

При клике на кнопку значение будет меняться, как именно это работает, рассмотрим далее.

### Хуки

**Хук** - специальная функция с особой функциональностью `React`. Функция `useState` является хуком. Хук по сути
связывает компонент со внутренним механизмом `React`.

Хуки работают по своим правилам:

1. Название хука начинается с `use*`.
2. Хуки можно вызвать только о компонентах или других хуках.
3. Хуки нельзя вызвать условно, в циклах или во вложенных функциях. То есть при каждом рендере должен вызываться один и
   тот же хук.

### Инициализация состояния

````jsx
const [counter, setCounter] = useState(10);
````

Важно задать первоначальное значение `useState`, иначе будет ошибка. Оно важно только при первом рендере, при
последующих рендерах комопанента, оно будет игнорироваться.

Но каким должно быть начальное значение, чаще всего это `0`, `[]`, все зависит от использования значения. Так же
значение может быть динамическим приходящим из свойства.

В качестве примера создадим три счетчика значений, работающих независимо

````jsx
function Count({c}) {
  const [counter, setCounter] = useState(c);
  return (
    <>
      <button onClick={() => setCounter(value => value + 1)}>+1 Клик</button>
      <br/>
      {counter}
    </>
  )
}

export function App() {
  return (
    <>
      <Count c={0}></Count>
      <br/>
      <Count c={23}></Count>
      <br/>
      <Count c={99999}></Count>
    </>
  )
}
````

Какие все-таки начальные значения могут быть:

- `true|false`
- `""`
- `null`

Так же начальное состояние можно получить из `Cookie`, `localStorage` и других хранилищ, или же как то динамически
вычислять, например определить функцию `const [counter, setCounter] = useState(() => getCalculateDefaultValue());`

Посмотрим на пример

````jsx
export default function State() {
  // index переменная состояния
  // setIndex функция которая будет обновлять index
  let start = 1;
  const [index, setIndex] = useState(start);
  console.log(`start value ${start}`);
  console.log(`current value ${index}`);
  return (
    <>
      <button onClick={() => {
        setIndex(index + 1);
        console.log(`set value ${index}`)
      }}>useState
      </button>
    </>
  );
}
````

Что мы увидим в консоли, при запуске скрипта

`React` при строгом режиме рендерит компонент 2 раза, чтобы убедится в отсутствии `side effects`. Поэтому мы будем
видеть результат два раза.

````text
// Первый рендер, все ожидаемо
start value 1 - стартовое значение
current value 1 - текущее значение
start value 1 - стартовое значение
current value 1 - текущее значение
// Делаем клик
set value 1 - внутри функции set значение осталось прежним, то есть текущим
start value 1 - стартовое значение, не меняется
current value 2 - текущее значение, поменялось
start value 1 - стартовое значение, не меняется
current value 2 - текущее значение, поменялось
// Делаем клик
set value 2 - предыдущее значение было 2, хотя значение уже поменялось
start value 1 - стартовое значение, не меняется
current value 3 - текущее значение, поменялось
start value 1 - стартовое значение, не меняется
current value 3 - текущее значение, поменялось
````

Пример с кнопкой:

````jsx
function ShowButton() {
  // Состояние скрытия/показа кнопки
  // По дефолту она скрыта
  const [show, setShow] = useState(false);
  // Кнопка с обработчиком, при клике меняем текущее состояние, инвертируем название кнопки и выводим ее текст
  return (
    <>
      <button onClick={() => {
        setShow(!show)
      }}>
        {show ? 'Hide' : 'Show'}
      </button>
      {show && <p>Скрытый текст</p>}
    </>
  )
}
````

Как это работает.
Первоначальное значение = `false`.
Если кликнуть на кнопку, значение `show` не будет изменено `show = false`, оно поменяется только при следующей итерации.
Так работает хук

### Что вернет хук

````jsx
const [counter, setCounter] = useState(10);
````

Получается, что хук возвращает массив из двух странных элементов `[текущее значение, установка нового значения]`. Эти
значения можно обрабатывать по-разному, но именно деструктуризация самый часто используемый.

Но сам хук вернет именно то, что мы ему передадим.

Хорошей практикой является размешать в одном состоянии тесно связанные друг с другом данные.

### Задание значения

Присвоить значение можно просто передав его статически

````jsx
function Opens() {
  const [exp, setExp] = useState(false);
  return (<>
    <button onClick={() => setExp(true)}>+</button>
    <button onClick={() => setExp(false)}>-</button>
    {exp && <p>Открыли</p>}
  </>)
}
````

Пример очень простой, но показывает возможность статически заданного значения.

Так же можно вернуть новое значение динамически, что мы и делали в примерах выше, но с особенностями:

````jsx
function Count2() {
  const [counter, setCounter] = useState(0);
  return <button onClick={() => {
    setCounter(value => value + 1);
    setCounter(value => value + 1);
    setCounter(value => value + 1);
  }
  }>{counter}</button>;
}
````

Здесь при каждом клике мы будем плюсовать `+3` к результату. Как бы все понятно, логично, но если просто задать значение
без функции:

````jsx
function Count2() {
  const [counter, setCounter] = useState(0);
  return <button onClick={() => {
    setCounter(1); // Будет выполнен только этот setCounter остальные игнорированны
    setCounter(1);
    setCounter(1);
    setCounter(1);
    setCounter(1);
    setCounter(1);
  }
  }>{counter}</button>;
}
````

Ну и конечно использовать сколько угодно состояний в одном компоненте.

## Эффекты

Специальный хук `useEffect` может помочь если нужно загрузить внешние данные, создание интервала.

## Примеры

### Пример 1 - Список элементов

Реализуем стандартный `select` со списком элементов.

````jsx
function Select(props) {
  return (
    <select>
      {props.items.map((item, k) => (
        <option selected={k === 3 ? "selected" : ""} key={k}>{item}</option>
      ))}
    </select>
  )
}

export function App() {
  const items = ['item1', 'item2', 'item3', 'item4', 'item5'];
  return (<Select items={items}/>)
}
````

### Пример 2 - Работа со списком элементов

Реализуем функции:

- Добавление элементов
- Удаление элементов
- Изменение элементов
- Сортировка элементов

Работа происходит с массивом элементов, через состояние.

````jsx
function Lists() {
  const [list, setList] = useState([]);
  const result = list.map((element, index) => {
    return <p key={index}>{element}</p>;
  });
  return <>
    <button onClick={() => {
      setList([...list, 'Элемент 1', 'Элемент 2']);
    }}>add
    </button>
    <button onClick={() => {
      let index = 1;
      setList([...list.slice(0, index), ...list.slice(index + 1)]);
    }}>delete
    </button>
    <button onClick={() => {
      let index = 1;
      setList([...list.slice(0, index), 'поменяли элемент', ...list.slice(index + 1)]);
    }}>change
    </button>
    <button onClick={() => {
      let copy = Object.assign([], list);
      copy.sort();
      setList(copy);
    }}>sort
    </button>
    {result}
  </>
}

export function App() {
  return (
    <>
      <Lists></Lists>
    </>
  )
}
````

На выходе получаем фактически список задач.

### Пример 3. Добавление товаров

А здесь реализуем функционал вывода и добавления товаров с использованием нескольких компонентов

````jsx
// Список продуктов
const i = [
  {id: 1, name: "Товар 1", description: "Описание товара 1"},
  {id: 2, name: "Товар 2", description: "Описание товара 2"},
  {id: 3, name: "Товар 3", description: "Описание товара 3"},
];

// Список элементов
function Items() {
  const [prods, setProds] = useState(i);
  let res = (prods.map(prod => {
    return (
      <Item
        key={prod.id}
        id={prod.id}
        name={prod.name}
        description={prod.description}
      ></Item>
    )
  }));

  return (
    <>
      {res}
      <button onClick={() => setProds([...prods, {
        id: (prods.length + 1),
        name: "Товар " + (prods.length + 1),
        description: "Описание товара " + (prods.length + 1)
      },])}>Добавить товар
      </button>
    </>
  );
}

// Конкретный элемент
function Item({id, name, description}) {
  return <div key={id}>
    Id: {id}
    Имя: {name},
    Описание: {description},
  </div>;
}


export function App() {
  return (
    <>
      <Items></Items>
    </>
  )
}
````
