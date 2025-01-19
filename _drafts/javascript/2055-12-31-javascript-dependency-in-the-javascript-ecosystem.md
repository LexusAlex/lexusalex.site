---
title: Зависимости в экосистеме javascript
description: >-
  Управление зависимостями в экосистеме javascript
author: alex
date: 2055-06-08 22:40:00 +0300
categories: [Javascript,Collections]
tags: [js,set,map]
image:
  path: /assets/img/posts/main/javascript.png
  alt: Зависимости в экосистеме javascript
---

## Пакет

В основе любого приложения на javascript лежит **пакет**. Библиотека или фреймворк представляют собой набор пакетов.

Пакеты распространяются через специальный сайт [https://www.npmjs.com/](https://www.npmjs.com/) - реестр пакетов.

Опубликованный пакет, представляет собой архив с кодом, который можно добавить в проект.

Один пакет может зависеть от другого или от нескольких пакетов, тем самым образуя **дерево зависимостей пакета**

Например, посмотрим на дерево зависимостей проекта первого уровня 

````json
react-simple@0.0.0
+-- @vitejs/plugin-react@4.3.4
| +-- @babel/core@7.26.0
| +-- @babel/plugin-transform-react-jsx-self@7.25.9
| +-- @babel/plugin-transform-react-jsx-source@7.25.9
| +-- @types/babel__core@7.20.5
| +-- react-refresh@0.14.2
| `-- vite@6.0.3 deduped
+-- react-dom@19.0.0
| +-- react@19.0.0 deduped
| `-- scheduler@0.25.0
+-- react@19.0.0
`-- vite@6.0.3
  +-- @types/node@22.7.5
  +-- esbuild@0.24.0
  +-- UNMET OPTIONAL DEPENDENCY fsevents@~2.3.3
  +-- UNMET OPTIONAL DEPENDENCY jiti@>=1.21.0
  +-- UNMET OPTIONAL DEPENDENCY less@*
  +-- UNMET OPTIONAL DEPENDENCY lightningcss@^1.21.0
  +-- postcss@8.4.49
  +-- rollup@4.24.2
  +-- UNMET OPTIONAL DEPENDENCY sass-embedded@*
  +-- UNMET OPTIONAL DEPENDENCY sass@*
  +-- UNMET OPTIONAL DEPENDENCY stylus@*
  +-- UNMET OPTIONAL DEPENDENCY sugarss@*
  +-- terser@5.34.1
  +-- UNMET OPTIONAL DEPENDENCY tsx@^4.8.1
  `-- UNMET OPTIONAL DEPENDENCY yaml@^2.4.2
````

### package.json

`package.json` - это `json` фаил который содержит настройки пакета. У него много ключей. Удобнее всего смотреть возможные ключи по [документации](https://docs.npmjs.com/cli/v11/configuring-npm/package-json)

Опции зависимостей пакета. Это `json` где в ключе название пакета, в значении диапазон версий.

- `dependencies` - зависимости пакета, без которых проект не сможет работать.
- `devDependencies` - различные средства разработки, линтеры, сборщики.
- `peerDependencies` - зависимости для некоторых фреймворков и библиотек
- `optionalDependencies` - опциональные зависимости

> Нужно учитывать, что все зависимости в package.json первоначально задумывались для приложений на Node.js 
{: .prompt-info }


