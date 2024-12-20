---
title: Документация php становится интерактивной
description: >-
  В документацию php добавлена возможность выполнять код прямо на странице
author: alex
date: 2024-12-04 14:10:00 +0300
categories: [Php]
tags: [php]
image:
  path: /assets/img/posts/main/documentation.webp
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: Документация php становится интерактивной
---

## Введение 

Мир разработки быстрыми темпами движется вперёд, и инструменты, на которые мы полагаемся, тоже должны соответствовать требованиям нового времени. 
PHP — язык, который ежегодно модернизируется и оптимизируется, — вновь удивляет своих пользователей. 
На этот раз внедрение интерактивной среды для исполнения кода прямо на страницах официальной документации стало настоящим новшеством, о котором стоит рассказать отдельно.

Теперь программисты могут не только читать примеры кода, представленные в официальной документации PHP, но и **мгновенно проверить их выполнение прямо на странице**, без необходимости сворачивать браузер, открывать локальный сервер или внешний редактор. 

Это важная веха в эволюции языка, который остается одним из самых популярных инструментов для веб-разработки.

## Почему это нововведение важно?

1. **Мгновенные эксперименты с кодом**  
   Теперь, изучая новую функцию PHP, вы можете сразу увидеть результат её выполнения без какого-либо стороннего софта. Например, если вы изучаете функцию `array_map()`, достаточно запустить её пример на странице, чтобы понять, как она работает с реальными аргументами.

2. **Оптимизация обучения**  
   Интерактивный код — это не только удобно, но и невероятно полезно для разработчиков всех уровней. Новички могут сразу экспериментировать с кодом, проверяя все нюансы и особенности, а профессионалы — быстро тестировать идеи, не отвлекаясь на конфигурацию среды разработки.

3. **Экономия времени**  
   Сокращается необходимость перехода между документацией и локальным сервером. Всё, что нужно, — это браузер и доступ к сети.

## Как это работает?

На страницах документации PHP теперь появились специальные **интерактивные блоки**, которые содержат редактор кода и кнопку «Выполнить». 

Вы можете:
- Изменить пример кода, предоставленный в документации.
- Нажать на кнопку, чтобы выполнить этот код в защищённом серверном окружении.
- Посмотреть результат выполнения прямо под блоком кода.

Пример:

```php
<?php
$numbers = [1, 2, 3, 4];
$squared = array_map(fn($n) => $n * $n, $numbers);
print_r($squared);
```
После нажатия «Выполнить» вы получите вывод:

```text
Array
(
    [0] => 1
    [1] => 4
    [2] => 9
    [3] => 16
)
```

Эта среда полностью безопасна: она изолирована и работает в песочнице, поэтому никаких изменений в вашей локальной системе после выполнения кода не произойдет.

Вот пример прямо на странице документации [https://www.php.net/manual/ru/function.array-column.php#refsect1-function.array-column-examples](https://www.php.net/manual/ru/function.array-column.php#refsect1-function.array-column-examples)

## Кому это будет полезно?

- **Новичкам**  
  Впервые изучаете PHP? Теперь вам не потребуется отдельный сервер или специальная IDE, чтобы познакомиться с работой функций. Это идеальный способ для тех, кто делает свои первые шаги в языке.

- **Преподавателям**  
  Обучать студентов стало проще: интерактивные уроки с живыми примерами кода повышают вовлеченность и ускоряют процесс обучения.

- **Продвинутым разработчикам**  
  Иногда нужно быстро проверить, как работает та или иная новая функция, введенная в последних версиях PHP. Блоки с интерактивным выполнением сэкономят ваше время.

- **Командам, проверяющим обновления языка**  
  Документация теперь позволяет вживую тестировать нововведения, такие как `Property Hooks`, `Lazy Objects`, или обновления в работе массивов и строк.

## Примеры из документации

Среди уроков, идеально подходящих к этой функции, можно выделить такие задачи:

1. Проверка работы новых функций, например, `str_contains()`, `array_find()` и других.
2. Тестирование утилит для работы с массивами и объектами, включая примеры использования `property hooks` из PHP 8.4.
3. Наглядное изучение поведения PHP с различным вводом данных.

## Будущее интерактивной документации

PHP демонстрирует приверженность к созданию высококачественного инструмента для разработчиков, и внедрение исполняемого кода в документации — лишь один из шагов. В дальнейшем, вероятно, появятся новые функции, такие как:

- Возможность сохранять результаты выполнения примеров для последующего анализа.
- Дополнительные настройки среды выполнения (например, выбор версии PHP или добавление пользовательских библиотек).
- Интеграция с обучающими материалами и задачами, прямо связанными с документацией.

## Заключение

Интерактивная документация PHP — это не просто удобство, а **инвестиция в сообщество разработчиков**. 
Новая функция позволяет учиться быстрее, работать продуктивнее и исследовать язык PHP глубже. 
Это важный шаг, который делает PHP еще более доступным инструментом и укрепляет его позиции как одного из ведущих языков для веб-разработки.

Если вы ещё не проверили эту возможность, обязательно загляните в документацию PHP и протестируйте новые примеры кода прямо на странице. 
Вы будете удивлены тем, насколько это упрощает вашу работу!

PHP становится ближе к своим разработчикам — и это не может не радовать.
