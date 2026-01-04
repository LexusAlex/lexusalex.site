---
title: Nginx. Принципы работы
description: >-
  Разберем принципы работы веб-сервера nginx
author: alex
date: 2056-01-02 23:30:00 +0300
categories: [Html,nginx]
image:
  path: /assets/img/posts/main/html.png
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: Разберем принципы работы веб-сервера nginx
---

## Конфигурация

Конфигурация `nginx` состоит из директив. Они позволяют внутри себя указывать другие директивы.

Директивы могут быть простые и блочные. Простая директива - это просто имя и значение, а блочная директива - это название с набором инструкций в `{}`

Внутри блочной директивы можно задавать и другие директивы, это называется контекстом. Есть директивы в глобальной области видимости, они располагаются в контексте `main`. 

Виртуальный сервер - это технический кусочек конфигурации `nginx` директива `server` в контексте `http`.

Каким образом `nginx` понимает какой виртуальный хост нужен клиенту. По заголовку `Host`.


````nginx
server {
    listen 80;
    server_name test1.local;
}
server {
    listen 80;
    server_name test2.local;
}
server {
    listen 80;
    server_name test3.local;
}
````

При выполнении запроса любым клиентом веб-сервер `nginx` проверяет заголовок `HOST`.
Если его значение не соответствует ни одному хосту, то запрос идет по умолчанию для этого порта, в базовом варианте это будет первый найденный сервер.
Можно задать директиву `default_server` для порта.

Если отправить запрос без заголовка `HOST` получим контент первого хоста `test1.local`

````http
GET http://127.0.0.1:8080/
````

Зададим `default_server` для хоста `test3.local`

````nginx
server {
    listen 80 default_server;
    server_name test3.local;
}
````

Получим контент `test3.local`.

Если нужно жестко обработать запросы без заголовка `HOST` укажем хост `default.conf`.

````nginx
server {
   listen 80;
   return 444;
}
````

При этом сервер закроет соединение с ответом `Empty reply from server`

Директиве `server_name` можно задать несколько имен

Connection

Передать метод GET тело запроса, и посмотреть что будет


https://nginx.org/ru/docs/http/request_processing.html

curl -v 127.0.0.1
*   Trying 127.0.0.1:80...
* Connected to 127.0.0.1 (127.0.0.1) port 80
> GET / HTTP/1.1
> Host: 127.0.0.1
> User-Agent: curl/8.5.0
> Accept: */*
>
< HTTP/1.1 200 OK
< Server: nginx
< Date: Sun, 28 Dec 2025 11:08:08 GMT
< Content-Type: text/html; charset=UTF-8
< Transfer-Encoding: chunked
< Connection: keep-alive
< X-Powered-By: PHP/8.5.1

phpstorm
GET http://127.0.0.1:80
Host: test1.local
User-Agent: IntelliJ HTTP Client/PhpStorm 2025.3.1
Accept-Encoding: br, deflate, gzip, x-gzip
Accept: */*


HTTP/1.1 200 OK
Server: nginx
Date: Sun, 28 Dec 2025 11:23:01 GMT
Content-Type: text/html; charset=UTF-8
Transfer-Encoding: chunked
Connection: keep-alive
X-Powered-By: PHP/8.5.1

browser

GET / HTTP/1.1
Host: 127.0.0.1
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:146.0) Gecko/20100101 Firefox/146.0
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8
Accept-Language: ru-RU,ru;q=0.8,en-US;q=0.5,en;q=0.3
Accept-Encoding: gzip, deflate, br, zstd
Connection: keep-alive
Cookie: yii-exception-theme=light-theme
Upgrade-Insecure-Requests: 1
Sec-Fetch-Dest: document
Sec-Fetch-Mode: navigate
Sec-Fetch-Site: none
Sec-Fetch-User: ?1
Priority: u=0, i

HTTP/1.1 200 OK
Server: nginx
Date: Sun, 28 Dec 2025 10:59:58 GMT
Content-Type: text/html; charset=UTF-8
Transfer-Encoding: chunked
Connection: keep-alive
X-Powered-By: PHP/8.5.1


https://habr.com/ru/companies/X5Tech/articles/798681/

https://www.youtube.com/watch?v=-Z8kyGbTXik&t=458s

