---
title: Использование Promise
description: >-
  Promise базовый способ работать с отложенными вычислениями
author: alex
date: 2055-08-24 15:00:00 +0300
categories: [Html]
tags: [javascript]
image:
  path: /assets/img/posts/main/html.png
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: Promise базовый способ работать с отложенными вычислениями
---

## Кратко

`Promise` - это специальный объект для выполнения отложенных асинхронных операций, результат которого возврщается в некоторый момент в будущем.

По умолчанию `Promise` находится в режиме ожидания, через некоторое время он будет разрешен либо отклонен.

Асинхронная операция, это любое действие которое не выполняется мгновенно, как раз `Promise` представляет будущий результат такой операции, он сам по себе будет возвращен, результат операции придет позже.

Многие `api используют `Promise`, поэтому он считается базой которую нужно знать. Он как контейнер для конечного результата.

В качестве сравнения, проведем аналогию между событиями и промисами. Обработчики событий выполняются несколько раз, в то время как `then` выполеняется только один раз, то есть можно сказать `Promise` - это одноразовая операция.
При вызове `then` результат будет получен, а при событии если обработчик не был навешен оно просто потеряется. В `Promise` уже встроен обработчик ошибок, в событиях их нужно обрабатывать отдельно.

`Promise` полезен в первую очередь для обработки асинхронных операций.

## Объект без параметров

Если создать объект без параметров, получаем ошибка, так как внутрь нужно обязательно передать функцию `executor` - то есть исполнитель.

````javascript
let promise = new Promise(); // Uncaught TypeError: undefined is not a function
````

## Executor

Важным аспектом в понимании `Promise` является функция `executor`. Ее нужно передать в конструктор `new Promise();`, она как раз и будет производить всю работу.

Функция `executor` выполняется сразу же и синхронно при создании объекта.

````javascript
let promise = new Promise(() => {console.log(132)}); // 132
````

Но при этом сначала выполнится функция `executor`, а только потом создаться объект `Promise`.

Для удобства вынесем функцию `executor` в отдельную функцию, сделаем их 2

````javascript
let executor2 = () => {console.log('executor2');} // Вторая функция

let promise = new Promise(executor2); // executor2

function executor1() // Первая функция
{
  console.log('executor1');
}
````

Вроде поведение ожидаемо, функция в переменной нужно объявить до использования, а обычную функцию можно и после. 

> В любом случае функция `executor` будет всегда выполнена до создания объекта `Promise`.
{: .prompt-info }

Даже если создать несколько промисов, ситуация не поменяется

````javascript
let promise = new Promise(executor1);
let promise2 = new Promise(executor1);
let promise3 = new Promise(executor1);

function executor1()
{
  console.log('executor1'); // 3 раза 'executor1'
}
````

Если попробовать вернуть что-то из функции, то мы ничего не получим. То есть значение `123` мы никогда не увидим.

````javascript
let promise = new Promise(() => {
  return 123; // ...
});
````

В функцию `executor` передается 2 аргумента `resolve` и `reject`. Это функции которые будут менять состояние `Promise` внутри функции `executor`.

То есть результат возврата из функции `executor` устанавливается только путем вызова `resolve()` или `reject()`, обычный `return` игнорируется.

Задача разработчика внутри `executor` вызвать `resolve()` или `reject()`, тем самым перевести в `fulfilled` или `rejected`. Об этом чуть ниже.

`resolve()` вызовет успешное выполнение `Promise`, а `reject()` отклонит его.

## Состояния `Promise`.

Как мы поняли `executor` описывает выполнение асинхронной операции, по завершению которой, необходимо вызвать `resolve()` или `reject()`.

По умолчанию `Promise` у нас находится в состоянии `pending`, то есть в ожидании, не выполнен и не отклонён.

````javascript
let promise = new Promise((resolve, reject) => {});
console.log(promise); // Promise { <state>: "pending" }
````

Если в какой-то момент времени мы сами разрешить `Promise`, то вызывает `resolve()`.

````javascript
let promise = new Promise((resolve, reject) => {
  resolve();
});
console.log(promise); // Promise { <state>: "fulfilled", <value>: undefined }
````

Получаем состояние `fulfilled`, то есть успешное завершение операции.

Если нужно отклонить `Promise`, вызываем `reject()`.

````javascript
let promise = new Promise((resolve, reject) => {
  reject();
});
console.log(promise); // Promise { <state>: "rejected", <reason>: undefined } Uncaught (in promise) undefined
````

Состояние `rejected`, что говорит о том, что процедура завершилась с ошибкой.

В каждую из функции можно передать значение `resolve(value); reject(error);`

`Promise` можно перевести в одно из двух состояний получив при этом значение

````javascript
let promise = new Promise((resolve, reject) => {
  // Имитируем ассинхронную операцию
  setTimeout(() => {resolve("5 sec");console.log("first");console.log(promise);}, 5000);
  // first
  // Promise { <state>: "fulfilled", <value>: "5 sec" }
});
````

````javascript
let promise = new Promise((resolve, reject) => {
  // Имитируем ассинхронную операцию
  setTimeout(() => {reject("Error");console.log(promise);console.log("error");}, 5000);
  //error
  // Promise { <state>: "rejected", <reason>: "Error" }
  // Uncaught (in promise) Error
});
````

В примерах выше мы сначала успешно разрешаем `Promise` передавая значение, далее мы завершаем `Promise` с ошибкой которая выводится в консоль.

## resolve()

Теперь попробуем вызвать `resolve()` несколько раз

````javascript
let promise = new Promise((resolve, reject) => {
  resolve('1'); // Будет вызван только этот resolve, остальные игнорируются
  resolve('2');
  resolve('3');
});

console.log(promise); // Promise { <state>: "fulfilled", <value>: "1" }
````

В данном случае будет выполнен только первый `resolve`

Еще `resolve` можно сразу разрешить на месте. Кода меньше. 

````javascript
let s = Promise.resolve("Success");
console.log(s); // Promise { <state>: "fulfilled", <value>: "Success" }
````

Если параметр `reject` не требуется, его можно не передавать

````javascript
let promise = new Promise((resolve) => {
  resolve('1');
});
````

## reject()

Вызовем `reject` несколько раз

````javascript
let promise = new Promise((resolve, reject) => {
  reject('Error1'); // Сработает эта ошибка
  reject('Error2');
  reject('Error3');
});

console.log(promise); // Promise { <state>: "rejected", <reason>: "Error1" } Uncaught (in promise) Error1
````

Получаем тоже, самое только первый `reject` будет применен.

В `reject` лучше передавать объект ошибки `reject(new Error('Error'))` так результат будет информативнее.

````javascript
let promise = new Promise((resolve, reject) => {
  resolve('ok'); // Сработает эта строка, далее код проигнорируется
  reject(new Error('Error')); // игнор
  setTimeout(() => {reject(new Error('Error')); console.log(promise)}, 3000); // игнор
});
````

В таком сборном примере, как только `resolve` был сделан, остальной код будет проигнорирован. 

> Состояние `Promise` может быть изменено только один раз либо успешно, либо ошибка.
{: .prompt-info }

Так же `reject` можно вызвать сразу на месте не создавая объект `Promise.reject`. В этом случае будет создан отклоненный `Promise`.

````javascript
let error = Promise.reject(new Error("Error"))
console.log(error); // Promise { <state>: "rejected", <reason>: Error }
````

На текущий момент понятно, что первоначальное состояние `Promise` `pending`, потом идет выполнение асинхронной операции и состояние
с помощью `resolve` становится `fulfilled`, где указывается значение или с помощью `reject` `rejected`, куда передается ошибка.

Сейчас от `Promise` толку мало. Мы подошли к моменту когда нам нужно обработать полученный результат.

## then

`then` - Основной метод который будет автоматически вызван когда `Promise` завершен, то есть он находит в любом состоянии кроме `pending`.

````javascript
let promise = new Promise((resolve, reject) => {
  resolve('ok1');
});

promise.then((result) => {console.log(result)}) // ок1
````

Метод `then` принимает два аргумента, это две функции

- `onFulfill` - функция вызывается когда статус `Promise` становиться `fulfilled`. В параметр этой функции передается результат выполнения операции.
- `onReject` - функция будет вызвана когда `Promise` переходит в состояние `rejected`. В параметр передается информация об ошибке.

````javascript
let promise = new Promise((resolve, reject) => {
  reject(new Error('error'));
});

promise.then(
  (result) => {console.log(result)},
  (error) => {console.log(error)} // Попадем сюда
);
````

Метод `then` возвращает новый `Promise`.

Если мы заинтересованы только в положительном исходе `Promise`, вторую функцию можно не передавать.

Как можно заметить такой код плохо читается более эффективно использовать для этого метод `catch`.

## catch

`catch` используется для обработки ошибок при выполнении `Promise`, то есть ловит ошибки переданные в метод `reject`.

Метод принимает параметр

- `onReject` - функция которая будет вызвана когда `Promise` переходит в состояние `rejected`. В параметр передается информация об ошибке.

````javascript
let promise = new Promise((resolve, reject) => {
  reject(new Error('error'));
});

promise.then((result) => {return result})
       .catch((error) => {console.log(error)});
````

Метод `catch` будет ловить все ошибки.

Метод `catch` возвращает новый `Promise`.

## finally

Вызывается когда `Promise` перешел в состояние `fulfilled`, или в `rejected`.

`finally()` вызывается вне зависимости от того как завершился `Promise`.

Обычно `finally()` подчищает, то что нужно сделать в конце операции, скрыть индикаторы, закрыть меню и т.д.

## Общая схема работы

Теперь когда теоретические моменты выяснены, можно разобрать общую схему как работает `Promise`.

- `Promise` создан, его состояние `pending`.
  -  Вызываем `resolve`, состояние `fulfilled`
    - Обрабатываем данные `tnen`
      - Возвращаем новый `Promise`
        - `Promise` создан, его состояние `pending`.
          - Вызываем `resolve` или `reject`
            - Обрабатываем данные `tnen` или `catch`
              - Возвращаем новый `Promise`
                - `Promise` создан, его состояние `pending`.
                  - и так по кругу
  -  Вызываем `reject`, состояние `rejected`
    - Обрабатываем данные `tnen` с параметром функцией `onReject` или `catch` с параметром функцией `onReject`
      - В браузер выводится ошибка `Erorr`
        - `Promise` создан, его состояние `pending`.
          - Вызываем `resolve` или `reject`
            - Обрабатываем данные `tnen` или `catch`
              - Возвращаем новый `Promise`
                - `Promise` создан, его состояние `pending`.
                  - и так по кругу

Как можно видеть, можно строить целые цепочки `Promise`, что дает невероятную гибкость, что позволяет создавать зависимые асинхронные операции, в примерах рассмотрим это подробнее.

## Примеры

Рассмотрим на примерах различные возможности `Promise`.

### Пример 1. Успешное выполнение

Спустя 3 секунды добавим контент в пустой `div`.

````html
<div id="container"></div>
<script>
  new Promise((resolve) => {
    // Асинхронная операция
    setTimeout(() => {
      resolve("data");
    }, 3000);
  }).then((result) => {
    document.getElementById('container').innerHTML = result;
  });
</script>
````

В примере мы обработали успешное выполнение `Promise`

### Пример 2. Успешное выполнение и ошибка при выполнении операции

Теперь представим что контейнера куда нужно добавить контент не существует, тогда будет вызван `reject`, тогда впоследствии ошибку вставим в документ 

В противном случае если контейнер найден, тогда вставим контент непосредственно в документ.

````html
<div id="container"></div>
<script>
  new Promise((resolve,reject) => {
    // Асинхронная операция
    setTimeout(() => {
      let container = document.getElementById('container1');
      if (container !== null) {
        resolve({'element': container, 'data': 'data'});
      } else {
        reject(new Error('Элемента не существует'));
      }
    }, 3000);
  }).then((result) => {
    result.element.innerHTML = result.data;
  },(error) => { document.body.innerHTML = '<b>'+error+'</b>'});
</script>
````

В примере мы имеем элемент которого может не существовать, мы его проверяем его наличие в дереве и принимаем решение о дальнейших действиях.

Ошибки рекомендуют обрабатывать с помощью `catch`.

Перепишем этот пример по-другому, добавив `catch`

````html
<div id="container"></div>
<script>
  new Promise((resolve, reject) => {
    // Асинхронная операция
    setTimeout(() => {
      let container = document.getElementById('container1');
      if (container !== null) {
        resolve({'element': container, 'data': 'data'});
      } else {
        reject(new Error('Элемента не существует'));
      }
    }, 3000);
  }).then((result) => {
    result.element.innerHTML = result.data;
  }).catch((error) => {
    document.body.innerHTML = '<b>' + error + '</b>'
  });
</script>
````

Вот так код читается гораздо лучше. По мне это лучший вариант использования.

> `catch` ловит все ошибки
{: .prompt-info }

### Пример 3. Передача результата в следующий `Promise`

Теперь у нас несколько `then` и на каждом идет какое-то сложное вычисление.

````html
<div id="container"></div>
<script>
  let container = document.getElementById('container');
  new Promise((resolve, reject) => {
    resolve(1);
  }).then((result) => { return result + 1;})
    .then((result) => { return result + 1;})
    .then((result) => { return result + 1;})
    .then((result) => { return result + 1;})
    .then((final) => {container.textContent = `Итоговый результат: ${final}`;})
</script>
````

Как мы понимаем результат будет накапливаться, и в итоге получаем 5, как сумму всех результатов.

Пример показывает, что результат можно видоизменять на каждой итерации.

Перепишем пример, с эмулированием асинхронной операции.

````html
<div id="container"></div>
<script>
  let container = document.getElementById('container');
  new Promise((resolve, reject) => {
    resolve(1);
  }).then((result) => { setTimeout(() => {container.textContent = `Итоговый результат: ${result}`; },3000);return result + 1;})
    .then((result) => { setTimeout(() => {container.textContent = `Итоговый результат: ${result}`; },6000);return result + 1;})
    .then((result) => { setTimeout(() => {container.textContent = `Итоговый результат: ${result}`; },9000);return result + 1;})
    .then((result) => { setTimeout(() => {container.textContent = `Итоговый результат: ${result}`; },12000);return result;})
    .then((final) => {container.textContent = `Итоговый результат: ${final}`;})
</script>
````

Тут мы устанавливаем начальное значение и каждые 3 секунды увеличиваем его, добавляя, при этом в `DOM` дерево элементов.

В конце пишем итоговый результат, хоть и это не обязательно.

### Пример 4. Возникновение ошибки в then. О необходимости catch

`catch` перехватывает ошибки которые возникают во всех элементах цепочки

````javascript
let promise = new Promise((resolve, reject) => {
  reject(new Error('error'));
});

promise
  .then((result) => {
    console.log("1:", result);
  })
  .then((result) => {
    console.log("2:", result);
  })
  .catch((error) => {
    // Ошибка пройдет через оба .then() и будет поймана здесь
    console.log(error.message); // Выведет: error
  });
````

В примере мы пройдем через все `then`, но попадем только в последний `catch`.

> `catch` это сокращенный вариант then(null, () => {})
{: .prompt-info }

### Пример 5. Проверка возраста

`Promise` можно вернуть из функции, например как в примере функции `checkAge` проверки возраста.

Мы так же для удобства будем логировать весь процесс выполнения кода

````javascript
  function checkAge(age) {
    return new Promise((resolve, reject) => {
      console.log('Начало проверки');
      setTimeout(() => {
        if (age >= 18) {
          // Если все хорошо, вызываем resolve с результатом
          resolve('Доступ разрешен');
        } else {
          // Если ошибка, вызываем reject с причиной ошибки
          reject(new Error('Доступ запрещен: вам еще нет 18'));
        }
      }, 2000); // Имитируем задержку в 2 секунды
    });
}

checkAge(20)
  .then(result => {
    // .then() выполнится, если Promise перешел в состояние 'fulfilled'
    console.log('Успех:', result);
  })
  .catch(error => {
    // .catch() выполнится, если Promise перешел в состояние 'rejected'
    console.error('Ошибка:', error);
  })
  .finally(() => {
    // .finally() выполнится в любом случае, после then или catch
    console.log('Проверка завершена.');
  });
````

Если успешное выполнение функции, тогда вывод консоли будет такой

````text
Начало проверки
Успех: Доступ разрешен
Проверка завершена.
````

Если ошибка, тогда вывод будет таким

````text
Начало проверки
Ошибка: Error: Доступ запрещен: вам еще нет 18
Проверка завершена.
````

Обратим внимание на блок `finally` он будет выполнен в любом случае, независимо как завершиться `Promise`

### Пример 6. Возврат положительного значения на месте

Иногда можно вернуть сразу вернуть значение из `Promise` не создавая его объект. Такой код занимает буквалтно одну строчку.

````javascript
Promise.resolve("ok").then((result) => {console.log(result)}); // ok
````

Помимо этого можно вернуть массив.

````javascript
Promise.resolve([66,88,100]).then((result) => {console.log(result[2])}); // 100
````

Или даже другой `Promise`.

````javascript
Promise.resolve(Promise.resolve(Promise.resolve(Promise.resolve(true)))).then((result) => {console.log(result)});  // true
````

Здесь много вложенных `Promise`, при этом не требуется вызывать `then` на каждом из них. Это называется выравниванием `Promise`.

Казалось бы, но такие примеры могут сэкономить и упростить код.

> Лучше не использовать длинные цепочки методов 
{: .prompt-info }

### Пример 7. Случайный результат `Promise`

````javascript
let promise = new Promise((resolve, reject) => {
  setTimeout(() => {
    let rand = Math.random();
    if (rand > 0.5) {
      console.log(rand);
      resolve('ок');
    } else {
      console.log(rand);
      reject(new Error('error'));
    }
  },2000)
});

promise
  .then((success) => {console.log(success)})
  .catch((error) => {console.log(error)});
````

Результат будет то `resolve` то `reject`, при обновлении страницы

### Пример 8. Очистка finally(), которая будет сработана в любом случае

Блок `.finally()` будет всегда выполнен и не важно как завершился `Promise`.

````javascript
new Promise((resolve, reject) => {
  resolve('ok');
}).finally(() => {console.log('Загрузка завершена')})
  .then((r) => {console.log(r); return r;})
  .then((r) => {console.log(r)})
````

````text
Загрузка завершена
ok
ok
````

Так как `.finally()` ничего не знает о состоянии `Promise`, он будет выполнен первым, а далее уже блоки `then`.

То есть у нас получается:

- `.finally()` будет выполнен всегда.
- У `.finally()` нет аргументов.
- Результат цепочки не будет изменен, даже если что-то вернуть из `.finally()`
- Часто используется для очистки общего результата, например скрыть спиннер загрузки

Вот тут например ошибка пройдет через `finally`.

````javascript
new Promise((resolve, reject) => {
  reject(new Error('error'));
}).finally(() => {console.log('Загрузка завершена')})
  .then((r) => {console.log(r); return r;})
  .catch((e) => {console.log(e)})
````

TODO Расмотреть методы

## Итог

- Можно вызывать зависимые друг от друга действия
- Как правило, все асинхронные действия должны возвращать `Promise`
