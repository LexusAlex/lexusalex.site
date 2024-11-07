---
title: Используем next.js
author: alex
date: 2055-12-31 18:00:00 +0300
categories: [Next.js]
---

## Что такое Next.js

Это все, что нам нужно, чтобы построить веб приложении.

fullstack фреймворк для построения веб приложений

React framework

## Установка

Конфигурирование некста next.config.mjs - конфиг некста

## Маршрутизация

Роутинг основывается на файловой структуре. Наглядно будет это показывать именно на файлах и папках.

Чтобы, что-то сделать нужен роутинг, главное что мы будем использовать на полную - это роутинг 
 
```text
/app/page.js = /  Главная страница
```

Название файла `page.js`

Функциональный компонент из этого файла - это и есть страница

`layout` оборачивает все страницы

Можно сделать большое кол-во страниц

### Статичные страницы

В большинстве случаев для статичных страниц достаточно создать следующую иерархию каталогов

![img-description](/assets/img/posts/javascript/nextjs/next-1.png){: .shadow }
_Базовый роутинг статичных страниц_

Получается следующие пути

````text
/
/page1
/page2
/page3
````

Можно делать столь угодно вложенных страниц по этому же принципу. 

![img-description](/assets/img/posts/javascript/nextjs/next-2.png){: .shadow }
_Вложенные статичные страницы_

Тогда образуются следующие пути

````text
/page1/page11
/page1/page11/page12
/page1/page11/page12/page13
/page1/page11/page12/page13/page14
/page1/page11/page12/page13/page14/page15
````

> Если забыть в каталоге создать page.js тогда будет ошибка 404
{: .prompt-info }

### Динамические страницы

#### [id]

Динамический параметр нужно указать в квадратных скобках `[id]`.

![img-description](/assets/img/posts/javascript/nextjs/next-3.png){: .shadow }
_Динамический параметр_

Дотянутся до параметра можно через `props`, в данном примере это id

```javascript
export default function id({params}) {
  return <h1>{params.id}</h1>
}
```

#### [...p]

Если у нас несколько параметров, то здесь достаточно указать троеточие `[...p]`

Получим все переданные параметры

````javascript
export default function Params({params}) {
  // путь page2/dfdfgdfg/23/2343/afgdfds/345654/d678
  return <h1>params {JSON.stringify(params)}</h1> // В результате получаем массив параметров ["dfdfgdfg","23","2343","afgdfds","345654","d678"]
}
````

#### [[...p]]

Но вот незадача, если перейти на маршрут `page2` получим ошибку `404`, чтобы получить странцу без параметров вовсе нужно добавить в маршрут еще квадратные скобки `[[...p]]`.

Тогда уже ошибки не будет и мы получим страницу без параметров

> Next при выборе пути смотрит в первую очередь на страницы с конкретным названием, если ее нет то берется в расчет динамический параметр 
{: .prompt-info }

### Группы маршрутов ()

Для построения модульной структуры полезно объединять маршруты в группы, это можно сделать заключив группы в `()` например

![img-description](/assets/img/posts/javascript/nextjs/next-6.png){: .shadow }
_Группы маршрутов_

При этом сама папка не будет участвовать в маршрутизации.

Удобно разделять маршруты на логические группы

## Шаблоны

Базовый корневой layout должен быть обязательно.

В нем так же должен быть обязательно ссылка на `{children}`

Шаблоны могут быть вложенными сколько угодно раз и каждый будет рендерить контент предыдущий шаблона

![img-description](/assets/img/posts/javascript/nextjs/next-4.png){: .shadow }
_Вложенный layout_

И если добавлять контент в каждый layout получаем примерно такое

![img-description](/assets/img/posts/javascript/nextjs/next-5.png){: .shadow }
_Контент вложенных layout_

> Вложенные layout идеальная штука для построения зависимых элементов вложенных меню
{: .prompt-info }


> В группах маршрутов layout тоже можно использовать
{: .prompt-info }

## Рендеринг

### Серверные и клиентские компоненты

Обычный классический реакт компонент

Клиентский компонент

- `Create`
  - `Renders`
  - `Renders`
  - `Renders`
  - `Renders`
    - `Destroy`

- Есть перерендер
- Компонент рендерится на и на сервере и на клиеенте, но имеет клиентскую логику
- Реакт за ними следит
- Интерактивчик
- Тоже рендерися на сервере

Серверный компонент

- `Create`
  - `Destroy`

- Нет перерендера
- Компонент отрендерился на сервере один раз и больше он перерисовываться не будет
- Просто данные без взаимодействия с пользователем
- Снижается нагрузка на react, серверный компоненты это просто статика
- Чем больше серверных компонентов, тем меньше размер страницы
- Данные

Композиция компонентов становится важна. Грамотно собрать компоненты 

### Типы рендеринга

#### CSR

Клиент
  Клиент получает белый лист
Сервер
  Нагрузка минимальна

#### SSG

Генерация страниц во время билда
  Плохая масштабирвемость
  Юзерозависимая информация

#### SSR

Клиент
Сервер
  Сервер подготавливает данные
  Отрендерь страницу с данными 
  Минимальные требования к устройству клиента
  Подготовка страницы по запросу клиента

#### Гибрид

Генерация каких-то страниц во время билда
Объедение подходов выше 

## Загрузка данных

Загрузка данных списка происходит очень просто.

Делаем функцию возвращающую результат:

````javascript
export async function getR() {
  const result = await fetch('https://jsonplaceholder.typicode.com/posts') // Специальный fetch
  return result.json();
}
````

Непосредственно вывод

````jsx
export default async function Page1() {
  const result = await getR();
  return (
    <div>
      {result.map((r) => (
        <div>
          <Link key={r.id} href={`/page1/${r.id}`}>{r.title}</Link>
        </div>
      ))}
      {JSON.stringify(result)}
      page1
    </div>
  );
}
````

Загрузить конкретный элемент списка не сложнее. Нужно только передать `id` записи
 
````javascript
export async function getRId(id) {
  const result = await fetch(`https://jsonplaceholder.typicode.com/posts/${id}`)
  return result.json();
}
````

Вывести:

````jsx
export default async function id({params}) {
  const id = await getRId(params.id);
  console.log(id);
  return <>
    <p>
      <h1>{id.title}</h1>
      <h2>{id.id}</h2>
      <p>{id.body}</p>
    </p>
  </>
}
````
 
Таким образом отображение данных можно делать просто без проблем, так как все данные кешируются.

### Кеширование

Чтобы запретить кешировать запросы нужно указать параметр в `fetch`

````javascript
export async function getR() {
  const result = await fetch('https://jsonplaceholder.typicode.com/posts',
    {cache: "no-store"})
  return result.json();
}
````

Например, если информация всегда должна быть актуальной, тогда кеш выключаем.

Если страница обновляется достаточно редко, тогда поведение по дефолту с включенным кешированием

> По дефолту все запросы кешируются.
{: .prompt-info }

#### Срок жизни кеша

Так же есть возможность задать срок жизни кеша

````javascript
export async function getR() {
  const result = await fetch('https://jsonplaceholder.typicode.com/posts',
    {next: {relalidate: 3600}}) // время в секундах актуальности кеша либо задать 0 если хотим снова без кеша
  return result.json();
}
````

У next есть возможность ревалидировать страницу по тегу и по пути. Next может сбросить кеш конкретного маршрута.

Для этого можно создать специальный маршрут. И дергать его когда нужно ревалидировать страницу

````jsx
import {revalidateTag} from "next/cache";
import {NextResponse} from "next/server";

export function GET(request) {
   const tag = request.nextUrl.searchParams.get("tag");

   revalidateTag(tag);

   return NextResponse.json({
     revalidate: true,
     tag,
   })
}
````

### Статические страницы

В next есть возможность сделать статические страницы.

Сначала разберемся как понять, сколько страниц динамических, а сколько статических.

Нужно сделать `build` приложения. В конце билда в консоле будет итоговая строчка со списком собранных страниц

````text
○  (Static)   prerendered as static content  - статические
ƒ  (Dynamic)  server-rendered on demand - рендер по запросу
````

https://www.youtube.com/watch?v=0y5ZNChoNM8&t=4998s

## Оптимизация