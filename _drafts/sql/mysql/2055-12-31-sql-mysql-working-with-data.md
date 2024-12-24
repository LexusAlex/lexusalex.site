---
title: Работа с данными в mysql
description: >-
  Разберем основные операторы с которыми работаем в mysql
author: alex
date: 2055-06-02 09:00:00 +0300
categories: [Sql, Mysql]
tags: [mysql]
---

## SELECT - выборка данных

Наверное самая частая операция в mysql - это выборка среза данных из одной или нескольких таблиц.

Первое, что нужно понять, оператор `SELECT` всегда возвращает таблицу, даже если это просто вычисление

````sql
SELECT 1 + 1 as sum
````



UPDATE `` SET `sum` = 2 WHERE `sum` = 2 LIMIT 1;
INSERT INTO `` (`sum`) VALUES (2);

https://www.dev-notes.ru/articles/eloquent/use-exists-instead-of-count/
https://www.dev-notes.ru/articles/database/mysql-joins-tutorial-with-examples/
