---
title: Философия middleware
description: >-
  Рассмотрим, что такое промежуточное программное обеспечение
author: alex
date: 2024-12-20 16:00:00 +0300
categories: [Basics,Projects]
tags: [php,middleware]
image:
  path: /assets/img/posts/main/middle.jpg
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: Философия middleware
---

## Что такое middleware

`middleware` - это некая прослойка между запросом и непосредственно его выполнением. 

По сути `middleware` - это код, промежуточный слой которого навешивается на маршрут или группу маршрутов. Либо `middleware` можно навесить на все приложение.

## Где применяется

`middleware` могут применятся в разных частях системы.

Они осуществляют роль фильтра, обработчика запросов, авторизацию и аутентификацию.

Рассмотрим их в контексте веб-сервисов или веб-приложений.

На их уровне может быть:

- Проверка роли пользователя.
- Аутентификация и авторизация пользователя.
- Шифрование.
- Обрезка пробелов в запросе.
- Проверка токена.
- Проверка на ip адрес запроса.
- Логирование и дебаг.
- обработка CORS

То есть получается, что какие-то фильтры могут быть применены для всех запросов приложения всегда. Либо применены к определенному действию или группе действий

````text
Приложение
    Группа действий
        Действие
````

## Принцип действия

Принцип действия `middleware` можно рассмотреть на примере обычных функций в любом языке программирования.

Например, рассмотрим пример на `php`.

````php
<?php
    // Функции фильтры которые будем применять к действию
    function filter1($action){
    	// что-то делаем с данными
    	echo 'Применение фильтра 1'."<br>";
    	return $action;
    }
    
    function filter2($action){
    	// что-то делаем с данными
    	echo 'Применение фильтра 2'."<br>";
    	return $action;
    }
    
    function filter3($action){
    	// что-то делаем с данными
    	echo 'Применение фильтра 3'."<br>";
    	return $action;
    }
    
    // Действие 1
    function action($action){
    	filter1(filter2(filter3($action)));
    	return 'Выполнение '. $action;
    }
    echo action('action');
    
    /*
      Применение фильтра 3
      Применение фильтра 2
      Применение фильтра 1
      Выполнение action
     */
     
     // Действие 2
     function action2($action){
    	filter1(filter3($action));
    	return 'Выполнение '. $action;
    }
    
    echo action2('action');
    /*
     Применение фильтра 3
     Применение фильтра 1
     Выполнение action
     */
?>
````

В примере выше у нас есть набор фильтров, через которые у нас проходит запрос.
На каждом этапе запрос может не пройти фильтр и вернуть ошибку.

В "действии 1", запрос у нас пропускается через 3 фильтра, а в "действии 2" через 2 фильтра.

`middleware` работают похожим образом.

Теперь посмотрим как работают реальные `middleware` во фреймворке `slim`.

Кто не знает, напомню что в `slim` маршруты можно определять как анонимные функции.

Вот так:

````php
<?php
use Slim\Psr7\Request;
use Slim\Psr7\Response;
// Приложение было определено заранее 
// А это маршрут /test
$application->get('/test', function (Request $request, Response $response) {
      echo $_SERVER['REQUEST_URI'];
      return $response;
});
?>
````

Теперь добавим два `middleware`, на уровне одного действия методом `add`.

````php
<?php
use Slim\Psr7\Request;
use Slim\Psr7\Response;
use Psr\Http\Server\RequestHandlerInterface;

$application->get('/test', function (Request $request, Response $response) {
    echo $_SERVER['REQUEST_URI'];
    return $response;
  // Добавляем middleware
})->add(function (Request $request, RequestHandlerInterface $handler){
    echo "one middleware for /test<br>"; return $handler->handle($request);
})->add(function (Request $request, RequestHandlerInterface $handler){
    echo "two middleware for /test<br>"; return $handler->handle($request);
});
?>
````

В данном случае `middleware` выполняются как бы наоборот, снизу вверх до контента действия, каждый раз проталкивая запрос дальше.

На каждом этапе `middleware` могут вносить корректировки в запрос, модифицируя или отклоняя его.

Текст, который будет выведен:

````text
two middleware for /test
one middleware for /test
/test
````

Теперь маршруты:

````text
/routeGroup/test1
/routeGroup/test2
/routeGroup/subGroup1/test
/routeGroup/subGroup1/otherGroup1/test
````

В группы следующим образом:

````php
$application->group('/routeGroup', function (\Slim\Routing\RouteCollectorProxy $group){
      $group->get('/test1', function (Request $request, Response $response) {
          echo $_SERVER['REQUEST_URI'];
          return $response;
      });
      $group->get('/test2', function (Request $request, Response $response) {
          echo $_SERVER['REQUEST_URI'];
          return $response;
      });
      $group->group('/subGroup1', function (\Slim\Routing\RouteCollectorProxy $group2){
          $group2->get('/test', function ($request, $response) {
              echo $_SERVER['REQUEST_URI'];
              return $response;
          });
          $group2->group('/otherGroup1', function (\Slim\Routing\RouteCollectorProxy $group3){
              $group3->get('/test', function ($request, $response) {
                  echo $_SERVER['REQUEST_URI'];
                  return $response;
              });
          });
      });
  });
````

Теперь добавим к маршрутам `middleware`, и посмотрим на результаты 

````php
$application->group('/routeGroup', function (\Slim\Routing\RouteCollectorProxy $group){
      $group->get('/test1', function (Request $request, Response $response) {
          echo $_SERVER['REQUEST_URI'];
          return $response;
      });
      $group->get('/test2', function (Request $request, Response $response) {
          echo $_SERVER['REQUEST_URI'];
          return $response;
      })->add(function (Request $request, RequestHandlerInterface $handler){
          echo "middleware for two /routeGroup/test2<br>"; return $handler->handle($request);
      })->add(function (Request $request, RequestHandlerInterface $handler){
          echo "middleware for one /routeGroup/test2<br>"; return $handler->handle($request);
      });
      $group->group('/subGroup1', function (\Slim\Routing\RouteCollectorProxy $group2){
          $group2->get('/test', function ($request, $response) {
              echo $_SERVER['REQUEST_URI'];
              return $response;
          });
          $group2->group('/otherGroup1', function (\Slim\Routing\RouteCollectorProxy $group3){
              $group3->get('/test', function ($request, $response) {
                  echo $_SERVER['REQUEST_URI'];
                  return $response;
              });
          });
      })->add(function (Request $request, RequestHandlerInterface $handler){
          echo "middleware for one /routeGroup/subGroup1<br>"; return $handler->handle($request);
      });
  })->add(function (Request $request, RequestHandlerInterface $handler){
      echo "middleware for one /routeGroup<br>"; return $handler->handle($request);
  });
````

Результаты, что получилось:

````text
Маршрут
/routeGroup/test1
Ответ
middleware for one /routeGroup
/routeGroup/test1

Маршрут
/routeGroup/test2
Ответ
middleware for one /routeGroup
middleware for one /routeGroup/test2
middleware for two /routeGroup/test2
/routeGroup/test2

Маршрут
/routeGroup/subGroup1/test
Ответ
middleware for one /routeGroup
middleware for one /routeGroup/subGroup1
/routeGroup/subGroup1/test

Маршрут
/routeGroup/subGroup1/otherGroup1/test
Ответ
middleware for one /routeGroup
middleware for one /routeGroup/subGroup1
/routeGroup/subGroup1/otherGroup1/test
````

То есть мы добавили `middleware` на всю группу, на внутреннюю группу и на конкретное действие. Мы можем манипулировать как нам нужно.

Еще можно объявить глобальные `middleware`, которые будут срабатывать на все маршруты.

````php
<?php
$application->add(function (Request $request, RequestHandlerInterface $handler){
    echo "global middleware<br>"; return $handler->handle($request);
});
?>
````

## Плюсы и минусы

Среди плюсов можно отметить:

- Ускоряет разработку и управление проектом, так как мы используем одни и те же решения для разных контекстов.
- Дает возможность использовать одни и те же `middleware` в разных проектах.
- Сокращение ошибок благодаря централизованному управлению.

Из минусов можно сказать, что, так как запрос идет через промежуточное программное обеспечение, это может замедлить работу приложения в целом.

## Что в итоге

`middleware` - это такой посредник, который работает с входящим запросом приложения, видоизменяет его и отправляет запрос дальше следущему `middleware`. В результате доходя до действия.

С помощью `middleware`, можно автоматизировать проверки, которые должны происходить при каждом запросе.
