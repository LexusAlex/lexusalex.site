---
title: Библиотека laminas-config-aggregator
description: >-
   Рассмотрим библиотеку laminas-config-aggregator, как способ собрать конфигурацию php приложения 
author: alex
date: 2024-08-25 20:30:00 +0300
categories: [Php, Libraries]
tags: [php]
image:
  path: /assets/img/posts/main/laminas.webp
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: Конфигурация приложения php на примере laminas-config-aggregator
---

## Что такое конфигурация приложения. Основные понятия
 
Основные понятия связанные с конфигурацией приложения:

- **Развертывание приложения** - это процесс использующий один код, но разные конфигурации приложения.
- **Код** - это один единый репозиторий, для всех развертываний приложения.
- **Конфигурация приложения** - это все то, что может меняться между развертываниями.
- **Окружение** - это настройки, которые меняются между развертываниями приложения. В каких-то случаях настройки окружения можно назвать развертываем приложения.

Если кратко, то конфигурация это такой большой массив с настройками базы данных, кешей, валидаторов, логгеров и других вещей.

> Все критичные данных пароли, доступы к бд, нужно хранить в переменных окружения операционной системы, они и будут меняться между развертываниями приложения.
{: .prompt-info }

Чаще всего конфигурацию приложения группируют, по названию окружения:

- `development`
- `production`
- `test`
- `staging`
- `pre-production`

Можно создать файл `dependencies.php` и положить туда всю конфигурацию, но самым распространенным способом в разных фреймворках является наличие отдельного файла конфигурации для каждого из окружений, например:

````text
configuration/
    development.php
    production.php
    test.php
````

В каждом из которых будет массив конфигурации. 

Недостатком такого подхода является дублирование параметров.

Чтобы этого избежать этого можно пойти следующим образом, обозначив отдельный файл для каждой отдельной конфигурации.

````text
configuration/
    db.global.php
    logger.global.php
    development.php
    logger.development.php
    production.php
    test.php
````

Получается нагромождение файлов, со временем список файлов будет сложно читать и поддерживать.

Более удачный вариант на мой взгляд, разделить конфигурации в зависимости от окружений и модулей.

Модули - это просто группировка файлов по функционалу.

Например, разбив следующим образом:

````text
/
    Blog/
        Configuration/
            common/
                logger.php
                serializer.php
                error.php
                validator.php
                db.php
            development/
                logger.php
                db.php
                twig.php
            test/
                twig.php
                db.php
    Configurations/
    Authorization/
````

Получаем такую структуру, что у нас сначала идут модули, потом в них окружения и уже в них же конфигурация.

Теперь нужно собрать это все в один файл. Можно вручную рекурсивно собирать все файлы в один массив с помощью функции `glob`.

Например, так: 

````php
<?php

declare(strict_types=1);

$files = glob(__DIR__ . '/common/*.php');

$configs = array_map(
    static function ($file) {
        return require $file;
    },
    $files
);

return array_merge_recursive(...$configs);
````
 
Просто циклом пройдем по всем файлам и склеим все в один файл конфигурации.

Можно жить и так, но что делать с многомерными массивами, они будут некорректно перезаписывать одни и те же значения. Нужно что-то придумывать или воспользоваться специальными библиотеками для этого.

## laminas-config-aggregator

Воспользуемся простой библиотекой [laminas-config-aggregator](https://github.com/laminas/laminas-config-aggregator)

Она как раз нужна для объединения конфигурации из разных источников, будь это `php`, `xml`, `yml`, `ini` файлы.

### Установка

Установка стандартная через composer

````shell
composer require laminas/laminas-config-aggregator
# На текущий момент, a это август 2024 актуальная версия 1.15.0 
````
 
### Использование
 
Итак, имеем структуру файлов:

````text
└── Main
    └── Configuration
        ├── db.global.php
        ├── main.production.php
        └── test.global.php
````

Нам нужно склеить их в один.

````php
use Laminas\ConfigAggregator\ConfigAggregator;
use Laminas\ConfigAggregator\PhpFileProvider;
// Подключаем все переданные файлы в ConfigAggregator правильным способом
$aggregator = new ConfigAggregator([
    new PhpFileProvider(__DIR__. '/../src/Main/Configuration/*.global.php'),
]);
// Получаем итоговый массив
// Повторяющиеся ключи будут перезаписаны, что дает возможность удобно управлять конфигурацией например в зависимости от переменных окружения
var_dump($aggregator->getMergedConfig());
````

Рассмотрим другие варианты использования

````php
use Laminas\ConfigAggregator\ConfigAggregator;
use Laminas\ConfigAggregator\PhpFileProvider;

// Класс конфигурации
class C
{
    public function __invoke()
    {
        return ['db' => 999];
    }
}
// Во всех массивах есть ключ db, в результирующем массиве будет последний со значением 999
$aggregator = new ConfigAggregator([
    new PhpFileProvider(__DIR__. '/../src/Main/Configuration/*.production.php'),
    new PhpFileProvider(__DIR__. '/../src/Main/Configuration/*.global.php'),
    // Просто конфигурация из массива
    function () {
        return ['db' => 888];
    },
    // Конфигурация из класса
    C::class
]);

var_dump($aggregator->getMergedConfig());
````
 
Применений этому можно найти массу.

### Кэширование

Важной особенностью библиотеки является возможность кэширования конфигурации.

Имеет место если Конфиг очень большой и меняется нечасто.

````php
use Laminas\ConfigAggregator\ArrayProvider;
use Laminas\ConfigAggregator\ConfigAggregator;
use Laminas\ConfigAggregator\PhpFileProvider;


$aggregator = new ConfigAggregator([
    // Укажем специальный ключ config_cache_enabled в true, тем самым скажем, что брать из кэша
    new ArrayProvider([ConfigAggregator::ENABLE_CACHE => true]),
    new PhpFileProvider(__DIR__. '/../src/Main/Configuration/*.production.php'),
    new PhpFileProvider(__DIR__. '/../src/Main/Configuration/*.global.php'),
    function () {
        return ['db' => 888];
    },
    // Фаил куда сохранять конфигурацию
], 'var/config-cache.php');

var_dump($aggregator->getMergedConfig());
````

В результате получаем файл `config-cache.php` вида:

````php
<?php

/**
 * This configuration cache file was generated by Laminas\ConfigAggregator\ConfigAggregator
 * at 2024-08-25T16:02:08+00:00
 */
return [
    'config_cache_enabled' => true,
    'db' => 888,
    'test' => 123
];
````

При последующих запросах, конфигурация будет браться из файла `config-cache.php`.

Для того чтобы сбросить кэш, просто удалите файл.

## Что получаем в итоге

Библиотека laminas/laminas-config-aggregator дает нам возможность:

- Удобно склеивать конфигурацию приложения с возможностью использовать регулярное выражение в пути.
- Помимо `php` массивов поддерживает и другие форматы конфигурации например `xml`, `yml`.
- Сама библиотека имеет минимум зависимостей.
- Возможно кэшировать конфигурацию, для дальнейшего быстрого доступа к ней.

Как это использовать:

Для готового массива конфигурации можно найти массу применений.

Самое основное это передать его в контейнер внедрения зависимостей, для дальнейшего использования.

Например, можно склеивать массив с ошибками приложения, и выводить только последнюю ошибку.

Более подробно можно почитать в [документации](https://docs.laminas.dev/laminas-config-aggregator/)

## Заключение

> Важнее всего, чтобы работа с конфигурацией была удобной. Гибкость системы заключается в отсутствии зависимости между моделями данных, бизнес-логикой, поведением и местом хранения данных. Это позволяет разработчикам оставаться сосредоточенными на своих задачах, не отвлекаясь на технические ограничения.
{: .prompt-info }

Это первая статья из цикла статей построения приложений на php.

Остальные статьи:

1. Библиотека laminas-config-aggregator - Текущая статья
2. [Контейнер внедрения зависимостей в php](https://lexusalex.site/posts/php-dependency-injection-container/)
