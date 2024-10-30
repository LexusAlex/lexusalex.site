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

Например, ссылки мы хотим использовать еще и в другом месте, для этого их можно вынести в самостоятельный компонент `links`.

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

Не стоит забывать, что это обычный `javascript`, именно он выполняется в браузере, и мы тут ничего не изобрели. 
Мы просто комбинируем, компоненты как нам нужно.

## JSX

Но, созданные элементы все равно выглядят громоздко. Чтобы улучшить читаемость, нам поможет `JSX`.

`JSX` - это специальная надстройка над `javascript`.

Сравним обычное создание элемента:

````javascript
React.createElement('a',{'href':Link,'target':'_blank'},"Текст ссылки")
````

Создадим такой-же элемент с использованием `JSX`.

````jsx
<a href="https://lexusalex.site" target="_blank">Текст ссылки</a>
````

> Важно понимать, что `JSX` это не строка, не `HTML`, это объект `javascript`. Который делает создание элементов, компактнее и упрощает чтение.
{: .prompt-info }

> JSX создан только для разработчиков, под капотом, он преобразуется в тот же javascript, который мы писали выше.
{: .prompt-info }

Согласитесь, читать `JSX`, проще, чем обычный `javascript`.

Писать `React` компоненты, можно и без `JSX`, это дело вкуса.

Итак, `JSX` упрощает написание кода, он выглядит как `HTML`.

К тому же `React` по умолчанию предполагает использование синтаксиса `JSX`, и выводит полезные сообщения об ошибках.

Код `JSX` компилируется в стандартный `ECMAScript`, но при этом `javascript` не является.

Сам процесс преобразования из `JSX` в стандартный `javascript` код который работает в браузере, называется **транспиляция**.

**Транспиляция** - это преобразование синтаксиса с одного исходного языка в другой, то есть `JSX` в чистый `javascript`.

Создадим полностью идентичные компоненты `TestComponentJsx` и `TestComponentJs`, и сравним полученную разметку.

````jsx
function TestComponentJsx() {
  return (<div className="test" title="pest"><p><b>Текст</b></p></div>);
}

function TestComponentJs() {
  return React.createElement('div',{'className': 'test','title':'pest'},React.createElement('p',null,React.createElement('b',null,'Текст')));
}
````

````html
<!-- JSX -->
<div id="root"><div class="test" title="pest"><p><b>Текст</b></p></div></div>
<!-- Javascript -->
<div id="root"><div class="test" title="pest"><p><b>Текст</b></p></div></div>
````

Как видим разницы никакой, но кода значительно больше.

> Стандартные компоненты, такие как h1,div,span и другие, записывают как <h1>, а не стандартные, то есть пользовательские пишут в большой буквы, например <Items />
> При этом закрывающий тег может быть, а может и не быть, об этои ниже.
{: .prompt-info }

> Если возврат из компонента многострочный, то его оборачивают в круглые скобки `()` в конструкции `return (...)` или в присвоении в переменную const e = (...) 
{: .prompt-info }


> До этого момента мы не использовали сервер для разработки, а запускали просто в браузере, и так тоже можно, но удобнее будет развернуть окружение для разработки.
> Об этом я написал заметку [https://lexusalex.site/posts/javascript-react-pure-react/](https://lexusalex.site/posts/javascript-react-pure-react/), на этом останавливаться не будем.
> Далее у нас уже развернуто окружение для разработки.
{: .prompt-info }

### Переменные 

Переменные в `JSX` выводятся с обрамлением их в фигурные скобки `{}`.

> В `{}` может быть любой валидный javascript код.
{: .prompt-info }

Для демонстрации использования подстановки переменных создадим компонент `App`:

````jsx
export function App() {
  // Переменные подстанавливаются в фигурных скобках
  const text = 'Текст';
  const date = new Date().toLocaleDateString();
  const arr = [1,2,3];
  const obj = {a:1,b:2};
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
        <div>{1+1}</div>
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
<App test="123" />
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
export function App({test1,test2}) {
  return (
    <>
      <div>{test1}</div> // 123
      <div>{test2}</div> // 456
    </>
  );
}
````

> React будет рендерить все свойства даже если их нет в спецификации HTML
{: .prompt-info }

Если нужно показать объект, то просто передаем его параметрами

````jsx
const test = {'id': 1, 'name': 'test'}
<App id={test.id} name={test.name}/>
export function App({id,name}) {
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

Наиболее безопасным способом, как мне кажется является точное перечисление свойств, только так можно передать определенное их количество.
В случае со `spread` оператором, в объекте может быть произвольное количество свойств.

### Условные конструкции

Понятно, что в любой программе без условий никуда. По сути это же `javascript`, а это значит можно использовать любые языковые конструкции.

Например, здесь используем тернарный оператор.

````jsx
export function App() {
  let arr = [1,2,3];
  // Проверяем, что массив не пуст
  let res = arr.length ? (<div>В массиве что-то есть</div>):(<div>Массив пуст</div>);
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
{: .prompt-info }

Еще используют логическое `&&` для выполнения того или иного рендера.

````jsx
function Verified(){
  // Сложный и тяжелый рендер
  return (<>verified</>);
}

export function App() {
  let isVerified = true;
  let check = true;
  // Код не дойдет до рендера если хотя бы одно значение будет false
  // Ложные значение это false,0,"",null,Undefined,Nan
  return (<>{isVerified && check && <Verified />}</>)
}
````

Проверки можно вставлять в любое место `JSX`. Для сложных случаев ветвления лучше набросать структуру отдельно, а потом уже реализовывать.

> Если компонент не содержит дочерних элементов, рекомендуется писать его одиночным тегом, в противном случае парным тегом.
{: .prompt-info }

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
function Child(props){
  return (<div></div>)
}
````

Далее в компоненте `Parent` мы получаем доступ ко всем его дочерним элементам, доступ к конкретному пропсу.

````jsx
function Parent(props){
  return (<>{props.children[4].props.type}</>) // 5
}
````

> При рендере элементов из массива или другого списка в свойство key рекомендуется подставлять не индекс массива, а уникальный индентификатор элемента, это сбережет от ошибок в будущем.
> Каждый дочерний узел должен иметь уникальное свойство `key`.
{: .prompt-info }


## Пример 1 - Список элементов

Реализуем стандартный `select` список элементов.

````jsx
function Select (props) {
  return (
    <select>
      {props.items.map((item,k) => (
        <option selected={k===3?"selected":""} key={k}>{item}</option>
      ))}
    </select>
  )
}

export function App() {
  const items = ['item1','item2','item3','item4','item5'];
  return (<Select items={items} />)
}
````

В качестве корневого "узла" используют React fragment `<></>` или `<React.Fragment></React.Fragment>`.

Функциональный компонент - это функция в название которой начинается с большой буквы.
Функциональный компонент возвращает либо `React элемент` либо `null`.

Дерево react элементов, от корневого элемента

> React element tree != DOM tree
{: .prompt-info }

