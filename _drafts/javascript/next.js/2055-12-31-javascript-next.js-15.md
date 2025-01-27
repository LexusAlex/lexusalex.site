---
title: Про next.js 15
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

`Next.js` использует маршрутизацию в файлах. 

Корневой каталог `app` содержит структуру всех маршрутов и шаблонов.

Основной файл шаблона `layout.tsx` с минимальной разметкой

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

## public

Директория `public` содержит статические файлы


https://nextjs.org/docs/app/getting-started/installation#set-up-eslint
