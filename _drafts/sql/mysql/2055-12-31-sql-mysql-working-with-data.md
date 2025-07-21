---
title: Работа с данными в mysql/mariadb
description: >-
  Разберем основные операторы с которыми работаем в mysql/mariadb
author: alex
date: 2055-06-02 09:00:00 +0300
categories: [Sql, Mysql]
tags: [mysql]
---

## SELECT - выборка данных

Наверное самая частая операция в `mysql` или в `mariadb` - это выборка среза данных из одной или нескольких таблиц.

Первое, что нужно понять, оператор `SELECT` всегда возвращает таблицу, даже если это просто вычисление.

К примеру в выражении:

````sql
SELECT 1 + 1 as sum;
````

Будет подсчитанный ответ в виде таблицы

| sum |
|-----|
| 2   | 

Как можно видеть,`sql` можно использовать как калькулятор.

В базовом варианте можно вернуть все данные из одной таблицы, сколько бы их не было.

````sql
SELECT * FROM `Alerts`;
````

Так же можно указать сразу несколько таблиц, перечислив их через запятую.

````sql
SELECT * FROM `audit_kp`,`cron`,`events`
````

Здесь еще пока нет условия, поэтому результаты будут склеены из всех переданных таблиц

Допустим в таблицах у нас следующее количество записей:

- 5
- 2
- 11

В итоговом результате будет 110 записей (данные `audit_kp` + `cron` + `events`), склеенных в одну строку результата.

При этом от порядка перечисления таблиц зависит, что за чем будет идти. 

Но так бездумно запрашивать все столбцы всех таблиц, не эффективно.

Перечислим только нужные нам столбцы.

Например, нам нужны только идентификаторы из 3 таблиц.

Поля через запятую можно выбирать с указанием таблицы или без если используется одна таблица.

````sql
SELECT audit_kp.id,cron.id,`events`.id FROM `audit_kp`,`cron`,`events`;
-- id id(1) id(2)
````

| id | id(1) | id(2) |
|----|:-----:|:-----:|
| 1  |   1   |   1   | 
| 1  |   1   |   2   |

### Алиасы

Но вот тут не понятно, идентификаторы к какой таблице относятся в итоговой выборке, для этого существуют `алиасы` или псевдонимы.

Алиасы могут быть у таблицы, поля, либо у самой выборке.

Если алиас был объявлен у таблицы, его можно использовать во всем запросе.

````sql
SELECT t1.id column1,t2.id column2,t3.id column3 FROM `audit_kp` t1,`cron` t2,`events` t3
-- Или указать через AS, что необязательно
SELECT t1.id AS column1,t2.id AS column2,t3.id AS column3 FROM `audit_kp` AS t1,`cron` AS t2,`events` AS t3
````

| column1 | column2 | column3 |
|:-------:|:-------:|:-------:|
|    1    |    1    |    1    | 
|    1    |    1    |    2    |


Алиасы нам могут быть полезны:

- При работе с несколькими таблицами.
- Если используем функции.
- Чтобы сокрытить запрос.
- Если объединяем столбцы.

В именах алиасов обычно используют латинские буквы, если в названии нужно использовать русские буквы нужно использовать обратные кавычки. К примеру

````sql
SELECT t1.id AS `Колонка 1`,t2.id AS column2,t3.id AS column3 FROM `audit_kp` AS t1,`cron` AS t2,`events` AS t3
````

| Колонка1  | column2 | column3 |
|:---------:|:-------:|:-------:|
|     1     |    1    |    1    | 
|     1     |    1    |    2    |

> Если в имени псевдонима есть пробел нужно использовать кавычки
{: .prompt-info }

Пример с пробелом в псевдониме.

````sql
SELECT t1.id AS "column 1",t2.id AS column2,t3.id AS column3 FROM `audit_kp` AS t1,`cron` AS t2,`events` AS t3
````

Если нужно объединить результаты из всех колонок в одну можно воспользоваться функцией `CONCAT`. Иногда это бывает полезно. Например

````sql
SELECT CONCAT(t1.id,'-',t2.id,'-',t3.id) AS result FROM `audit_kp` AS t1,`cron` AS t2,`events` AS t3
````

Где в функции `CONCAT` нужно указать колонки или строки. Для статистки самое то.

|    result    | 
|:------------:|
|    1-1-1     |
|    1-1-2     |


Сейчас, наш запрос в примерах бесполезен, так как мы не получаем полезные данные, а склеиваем все в один.

Добавим условие выборки с помощью подвыражения `WHERE`.

### WHERE

Добавим конкретики в наше выражение. Чтобы возвращать только нужные нам строки

Можно использовать операторы сравнения, логические операторы, операторы для работы со сроками

Рассмотрим базовый пример, постепенно увеличивая количество условий.

````sql
-- Это выражение без условий выведет все строки 
SELECT * FROM `application_types`
````

Посмотрим на операторы сравнения

````sql
-- Четкое сопоставление =
SELECT * FROM `application_types` WHERE group_id = 3
-- Не равно <> !=
SELECT * FROM `application_types` WHERE group_id <> 3
SELECT * FROM `application_types` WHERE group_id != 3
-- Меньше <
SELECT * FROM `application_types` WHERE group_id < 3 -- В примере идентификатор 3 не попадает в выборку 
-- Меньше либо равно <=
SELECT * FROM `application_types` WHERE group_id <= 3 -- Вот теперь 3 попадает в выборку
-- Больше >
SELECT * FROM `application_types` WHERE group_id > 3
-- Больше либо равно >=
SELECT * FROM `application_types` WHERE group_id >= 3
````

А что если нам нужно больше условий, здесь нам помогут логические операторы

````sql
-- NOT Не равно
SELECT * FROM `application_types` WHERE NOT group_id = 3
-- AND Логическое И
SELECT * FROM `application_types` WHERE group_id > 3 AND group_id < 5
-- OR Логическое ИЛИ
SELECT * FROM `application_types` WHERE group_id = 3 OR group_id = 5
````

Эти операторы можно сочетать друг с другом, практически как угодно.

Например, в таком сложном условии 

````sql
SELECT *
FROM `application_types`
WHERE (group_id = 3 AND price < 2000 AND NOT price = 500 AND deleted = 0)
   OR (group_id = 5 AND price < 2000)
````

Также если таблиц становится несколько условие `WHERE` поможет нам отфильтровать ненужные записи.

````sql
SELECT *
FROM `application_types`,
     application_type_groups
WHERE application_types.group_id = application_type_groups.id
  AND application_type_groups.`name` = 'Охрана труда'
  AND NOT application_types.price = 500
  AND application_types.exam_type = 2
  AND application_type_groups.position = 1
  AND application_types.id > 200
  AND application_types.id < 300
````

Если нам нужны не все поля двух таблиц, мы уже умеем их указывать, да еще можем использовать алиасы для сокращенной записи

````sql
SELECT t.id AS t_id,
       t.group_id AS t_g_id,
       t.`name` AS t_name,
			 g.`name` AS g_name	
FROM `application_types` AS t,
      application_type_groups AS g
WHERE t.group_id = g.id
````

Далее можно использовать любые конструкции, операторы

Можно заметить имея несколько базовых конструкций уже можно делать много вещей, получая при этом полезные данные.


https://hmarketing.ru/blog/mysql/operator-where/


## INSERT вставка данных
## UPDATE обновление данных
## DELETE удаление данных

UPDATE `` SET `sum` = 2 WHERE `sum` = 2 LIMIT 1;
INSERT INTO `` (`sum`) VALUES (2);

https://www.dev-notes.ru/articles/eloquent/use-exists-instead-of-count/
https://www.dev-notes.ru/articles/database/mysql-joins-tutorial-with-examples/
