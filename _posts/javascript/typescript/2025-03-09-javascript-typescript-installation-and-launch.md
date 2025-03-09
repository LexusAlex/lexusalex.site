---
title: Typescript. Установка и запуск
description: >-
  Как установить и запустить typescript локально
author: alex
date: 2025-03-09 11:30:00 +0300
categories: [Javascript,Typescript]
tags: [typescript,vite]
image:
  path: /assets/img/posts/main/typescript.png
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: Typescript. Установка и запуск
---

## Вводная

В этой серии статей изучим основы `typescript`. Сегодня начнем с установки окружения и запуска проекта.

## Typescript 

`Typescript` является строгим надмножеством над `javascript`.

Основные возможности `typescript` направлены на повышение продуктивности разработчиков, в частности за счет
использования статических типов, которые облегчают работу с системой типов в `javascript`.

`Typescript` включает в себя компилятор, обрабатывающий файлы `typescript` и генерирующий чистый js код, который
можно запустить в `Node.js` или в браузере.

В более широком смысле `typescript` дополняет `javascript`, но не заменяет его. Чтобы эффективно работать с `typescript`,
необходимо хорошо знать `javascript`.

Компилятор `typescript` способен преобразовать новейший `javascript` код, в код соответствующий более старым версиям `javascript`.
Что дает возможность разработчикам использовать новые возможности языка, и запускать его в любом браузере.

## Подготовка окружения

Для того чтобы экспериментировать с примерами, подготовим тестовое окружение в `docker`, самый быстрый вариант это сделать с помощью сборщика `vite`.

Создадим стандартный `dockerfile` nodejs

`````dockerfile
FROM node:lts

RUN useradd -m alex && usermod -a -G node alex

RUN npm install -g npm@latest

WORKDIR demo-applications/ts-vite

USER node
`````
{: file='docker/node/Dockerfile'}

Добавим `docker-compose.yml`

````yaml
services:
  cli:
    build:
      context: docker
      dockerfile: node/Dockerfile
    volumes:
      - ./:/demo-applications/ts-vite
````
{: file='docker-compose.yml'}

И чтобы это все запускать `Makefile`

````makefile
docker-build:
	docker compose build --pull
docker-up:
	docker compose up -d
docker-down:
	docker compose down --remove-orphans
npm-install:
	docker compose run --rm cli npm install
compile:
	docker compose run --rm cli npm run compile
npm-be-updated-all:
	docker compose run --rm cli npm outdated --depth=9999
````
{: file='Makefile'}

Теперь можем уже поставить в проект `vite` и `typescript`, выполнив команду 

````shell
docker compose run --rm cli npm install -D vite typescript
````

Так же дополнив `package.json` специфическими вещами `vite` и нашими командами, в результате получим примерно такой файл

````json5
{
  "name": "ts-vite",
  "private": true,
  "version": "0.0.0",
  "type": "module",
  "scripts": {
    "dev": "vite",
    "build": "tsc && vite build",
    "preview": "vite preview",
    "compile": "tsc --outDir out"
  },
  "devDependencies": {
    "typescript": "^5.8.2",
    "vite": "^6.2.1"
  }
}
````
{: file='package.json'}

Не забудем добавить `.gitignore`

````text
# Logs
logs
*.log
npm-debug.log*
yarn-debug.log*
yarn-error.log*
pnpm-debug.log*
lerna-debug.log*

node_modules
dist
dist-ssr
*.local

# Editor directories and files
.vscode/*
!.vscode/extensions.json
.idea
.DS_Store
*.suo
*.ntvs*
*.njsproj
*.sln
*.sw?
````
{: file='.gitignore'}

Так же для `vite` нужно добавить точку входа в приложение - это `index.html` и `main.ts`

````html
<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>TS</title>
  </head>
  <body>
    <script type="module" src="/src/main.ts"></script>
  </body>
</html>
````
{: file='index.html'}

````typescript
let one: number = 1;

console.log(one);
````
{: file='src/main.ts'}

Чтобы корректно работал `typescript`, `vite` так же предоставляет конфигурацию

````json5
{
  "compilerOptions": {
    "target": "ES2020",
    "useDefineForClassFields": true,
    "module": "ESNext",
    "lib": ["ES2020", "DOM", "DOM.Iterable"],
    "skipLibCheck": true,

    /* Bundler mode */
    "moduleResolution": "bundler",
    "allowImportingTsExtensions": true,
    "isolatedModules": true,
    "moduleDetection": "force",
    "noEmit": true,

    /* Linting */
    "strict": true,
    "noUnusedLocals": true,
    "noUnusedParameters": true,
    "noFallthroughCasesInSwitch": true,
    "noUncheckedSideEffectImports": true
  },
  "include": ["src"]
}
````
{: file='tsconfig.json'}

Все готово, чтобы запустить сборку.

## Сборка

Готовый проект будет собираться в папке `dist`, достаточно выполнить команду

````shell
docker compose run --rm cli npm run build
````

В результате сборщик нам собирает готовый к использованию в браузере файл `javascript`

````javascript
(function(){const t=document.createElement("link").relList;if(t&&t.supports&&t.supports("modulepreload"))return;for(const e of document.querySelectorAll('link[rel="modulepreload"]'))i(e);new MutationObserver(e=>{for(const r of e)if(r.type==="childList")for(const o of r.addedNodes)o.tagName==="LINK"&&o.rel==="modulepreload"&&i(o)}).observe(document,{childList:!0,subtree:!0});function s(e){const r={};return e.integrity&&(r.integrity=e.integrity),e.referrerPolicy&&(r.referrerPolicy=e.referrerPolicy),e.crossOrigin==="use-credentials"?r.credentials="include":e.crossOrigin==="anonymous"?r.credentials="omit":r.credentials="same-origin",r}function i(e){if(e.ep)return;e.ep=!0;const r=s(e);fetch(e.href,r)}})();let n=1;console.log(n);
````

Но здесь не понятно, что же в итоге получится, чтобы запустить компиляцию отдельного файла у нас есть команда `compile`

````shell
docker compose run --rm cli npm run compile src/main.ts
````

В результате в папке `out` получаем фаил после обработке компилятором `typescript`.

Таким образом получаем способы сборки проекта. На базовом уровне изучения этого достаточно.

## В следующий раз

В будущих статьях последовательно разберем основные возможности `typescript`.
