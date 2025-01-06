---
title: Про jest в javascript
description: >-
  Возможности тестового фреймворка jest
author: alex
date: 2055-12-31 18:00:00 +0300
categories: [Javascript]
tags: [jest]
---

> Теоретические основы тестирования будут в отдельных статьях
{: .prompt-info }

Какие библиотеки есть для тестирования:

- jasmine
- mocha
- vitest

Но стандарт дефакто сейчас `jest`.

Для `react` это `testing-library/react`

Jest - фреймворк для тестирования.

## Что может jest

- Запускать проверку тестов
- Глобальные функции
  - describe
  - test,it
  - expect
- Утверждения для проверок
- Unit
- Функциональные тесты

## Установка

````shell
npm install --save-dev jest
````

Чтобы использовать `jest` с современным синтаксисом, нужно установить дополнительные пакеты

````shell
npm install --save-dev babel-jest @babel/core @babel/preset-env
````

Так же нужно добавить `babel.config`

````javascript
module.exports = {
  presets: [['@babel/preset-env', {targets: {node: 'current'}}]],
};
````

Поставим типы

````shell
docker compose run --rm node-cli npm install -D @types/jest
````

Запустим первый тест

````shell
> test
> jest src/default

 PASS  src/default/func.test.js
  ✓ func (3 ms)

Test Suites: 1 passed, 1 total
Tests:       1 passed, 1 total
Snapshots:   0 total
Time:        0.489 s

> test
> jest src/default

 FAIL  src/default/func.test.js
  ✕ func (4 ms)

  ● func

    expect(received).toBe(expected) // Object.is equality

    Expected: 2
    Received: 1

      2 |
      3 | test('func', () => {
    > 4 |     expect(func()).toBe(2);
        |                    ^
      5 | })

      at Object.toBe (src/default/func.test.js:4:20)

Test Suites: 1 failed, 1 total
Tests:       1 failed, 1 total
Snapshots:   0 total
Time:        0.517 s
````




https://jestjs.netlify.app/ru/docs/testing-frameworks
https://docs.nestjs.com/fundamentals/testing#unit-testing
https://doka.guide/tools/testing-with-jest/
https://www.youtube.com/watch?v=y2emL1fMRyY&t=2335s
https://my-js.org/docs/other/best-practices/#%D1%88%D0%BF%D0%B0%D1%80%D0%B3%D0%B0%D0%BB%D0%BA%D0%B0-%D0%BF%D0%BE-jest
https://habr.com/ru/articles/502302/
