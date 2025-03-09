---
title: Typescript. Основные типы
description: >-
  Базовое использование типов в typescript
author: alex
date: 2055-12-31 18:00:00 +0300
categories: [Javascript,Typescript]
tags: [typescript]
image:
  path: /assets/img/posts/main/typescript.png
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: Typescript. Основные типы
---

````typescript
const a_1: number = 4;
const a_2: string = 'Строка';
const a_3: boolean = true;
const a_4: undefined = undefined;
const a_5: object = {};
const a_6: null = null;

// Любой класс может быть как тип
const a_7: Number = 2;
const a_8: Date = new Date();
const a_9: String = 'str';

[a_1,a_2,a_3,a_4,a_5,a_6,a_7,a_8,a_9];
// Важно понимать что в js все типы будут удалены, js на них пофиг

// Описание типа можно сделать так
const sum : (x : number,y : number) => number = function (x : number,y : number) : number {
    return  x + y;
}

// Но лучше тип объявить так

type Sum = (x : number,y : number) => number;

const sum2: Sum = function (x : number,y : number) : number {
    return  x + y;
}

sum(5,9);
sum2(5,9);
````

ts
1
52.50

js
1
1.04
