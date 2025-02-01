---
title: Как использовать next.js 15
author: alex
date: 2055-12-31 18:00:00 +0300
categories: [Next.js]
---

## Установка

Для ручной установки `Next.js` достаточно выполнить команду

````shell
npm install next@latest react@latest react-dom@latest
````

## Где корень

`Next.js` использует маршрутизацию в файловой системе.

Корневой каталог `app` содержит структуру всех маршрутов и шаблонов.

Вложенные папки в `app` определяют структуру маршрута и будут доступны только есть в нем есть файл `page` или `route.js`

Основной файл шаблона `layout.tsx` с минимальной разметкой, выглядит так:

````tsx
import React from "react";

export default function RootLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return (
    <html lang="en">
      <body>{children}</body>
    </html>
  )
}
````

И первой страницей `page.tsx`

````tsx
export default function IndexPage() {
    return <h1>Next.js</h1>
}
````

> Если файл `layout.tsx` не найден, он будет создан автоматически
{: .prompt-info }

## Структура и файлы проекта верхнего уровня

Примерно такая структура

````text
/src
    /app
    ...
/public
````

### next.config.js

### instrumentation.ts

### middleware.ts

### .env


## Файлы в папке app

### layout

В корневом макете должны быть обязательно заданы теги `html` и `body`

### page
### loading
### not-found
### error
### global-error
### route
### template
### default

Иерархия компонентов. Они отображаются в следующей последовательности:

layout.js
template.js
error.js (React error boundary)
loading.js (React suspense boundary)
not-found.js (React error boundary)
page.js or nested layout.js

Этот набор файлов может быть добавлен в каждом сегменте пути. 

Файлы с другими названиями, могут быть размещены в каталоге `app` и никак не будут влиять на маршрутизацию.

Так же можно исключить папки с нижним подчеркиванием, например `_folder`

## Маршрутизация

Типы маршрутов

### [p]
### [...p]
### [[...p]]
### (p)

Группы маршрутов это способ организации маршрутов в вашем приложении без изменения структуры URL. 

Они позволяют группировать связанные маршруты в логические блоки, что улучшает читаемость кода и упрощает управление проектом. 

Группа маршрутов создается путем заключения имени папки в круглые скобки.

Например

````text
(test)
    (test)
        page.tsx
````

Например, можно разделить приложение на модули. Можно создать отдельный `layout` для каждой группы маршрутов.

Можно создать отдельные `layout` для каждой группы маршрутов.

### (_p)

Директория `public` содержит статические файлы


https://nextjs.org/docs/app/getting-started/project-structure#private-folders
