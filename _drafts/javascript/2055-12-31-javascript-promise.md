https://learn.javascript.ru/promise-api

https://www.youtube.com/watch?v=RMl4r6s1Y8M&t=159s

https://lexusalex.ru/javascript-18-promise


Синхронный код
Асинхронный код

`Promise` - Объект для работы с асинхронным кодом. Этот же объект возвращается в качестве результата.

````javascript
// new Promise() - Ошибка
let promise = new Promise(() => {}); // Функция исполнитель асинхроннйо операции

console.log(promise); // Promise { <pending> }
````

Он может быть в одном из 3 состояний

1. `pending` - ожидание
2. `fulfilled` - выполнено успешно, результат получен
3. `rejected` - выполнено с ошибкой

`Promise` может изменить свое состояние только один раз.

Методы

1. `then`  - обработка `fulfilled`
2. `catch` - обработка `rejected`

https://www.youtube.com/watch?v=C7TgmKZRNF4&t=735s


