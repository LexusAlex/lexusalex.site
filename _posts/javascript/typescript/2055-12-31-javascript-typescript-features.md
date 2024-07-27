---
title: Возможности typescript
description: >-
  Осваиваем typescript
author: alex
date: 2055-12-31 18:00:00 +0300
categories: [Javascript,Typescript]
tags: [javascript,typescript]
image:
  path: /assets/img/posts/typescript.png
---

https://github.com/ManningBooks/essential-typescript-5 Примеры кода

https://typescript-handbook.ru/docs/ts-1
https://nauchikus.gitlab.io/typescript-definitive-guide/book/contents.html

## Введение

Основные возможности typescript направлены на повышение продуктивности разработчиков, в частности за счет 
использования статических типов, которые облегчают работу с системой типов в javascript.

Typescript включаем в себя компилятор, обрабатывающий файлы typescript и генерирующий чистый js код, который
можно запустить в Node.js или в браузере.

В более широком смысле typescript дополняет javascript, но не заменяет его. Чтобы эффективно работать с typescript, 
необходимо хорошо знать javascript.

Компилятор typescript способен преобразовать новейший javascript код, в код соответствующий более старым версиям javascript.
Что дает возможность разработчикам использовать новые возможности языка, и запускать его в любом браузере.

## Установка

В проект typescript устанавливается как обычный [npm пакет](https://www.npmjs.com/package/typescript), и не вызывает особых сложностей.
 
## Компиляция и выполнение кода

Typescript необходимо скомпилировать, чтобы получить чистый javascript. Для этого в комплекте идет компилятор `tsc`.

Компилятор считывает настройки конфига `tsconfig.json` находит файлы `.ts` и создает такой-же файл с расширением `.js`.

Если не использовать возможности typescript, итоговые файлы javascript будут такими же.

Уже скомпилированные файлы можно выполнить в браузере или в node.js.

## Аннотации типов

Главной особенностью typescript является аннотация типов, что дает возможность присвоить значение только определенного типа в переменную или в свойство класса.
 
Например:

```typescript
class ToDo {
  public id: number // Здесь может быть только число
  protected itemMap = new Map<number, TodoItem>(); // Обобщенный тип состоящий из двух элементов
}
````

## Классы

Классы - это по сути реальный объект в жизни.


