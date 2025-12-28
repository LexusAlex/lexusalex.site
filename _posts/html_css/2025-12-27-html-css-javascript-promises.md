---
title: Использование Promise на примерах
description: >-
  Promise базовый способ работать с отложенными вычислениями
author: alex
date: 2025-12-27 13:00:00 +0300
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

## Состояния `Promise`

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
                  - и так по кругу...
  -  Вызываем `reject`, состояние `rejected`
    - Обрабатываем данные `tnen` с параметром функцией `onReject` или `catch` с параметром функцией `onReject`
      - В браузер выводится ошибка `Erorr`
        - `Promise` создан, его состояние `pending`.
          - Вызываем `resolve` или `reject`
            - Обрабатываем данные `tnen` или `catch`
              - Возвращаем новый `Promise`
                - `Promise` создан, его состояние `pending`.
                  - и так по кругу...

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

### Пример 9.`Promise.all` Ждем выполнения сразу нескольких `Promise`

`Promise.all()` - Возвращает новый `Promise`, когда все переданные `Promise` в метод `all` в виде массива будут разрешены, выполнены

Сделаем функцию, дабы не дублировать код, и вызовем ее три раза.

````javascript
function promise(type) {
    return new Promise((resolve, reject) => {
      setTimeout(() => resolve(type), 2000)
    });
  }
  let all = Promise.all([promise(1),promise(2),promise(3)]);
  all.then(([r1,r2,r3]) => {
    console.log(r1);
    console.log(r2);
    console.log(r3);
  })
````

В результате получаем параллельное выполнение всех запросов сразу, в ответе будет новый `Promise`.

Но здесь есть нюансы, еели в `Promise.all([])` передать пустой массив, то он сразу будет разрешен `fulfilled`.

Видоизменим пример, допустим в одном из `Promise` произошла ошибка, это 2 `Promise`.

````javascript
function promise(type) {
  return new Promise((resolve, reject) => {
    setTimeout(() => (type === 1) ? resolve(type) : reject(new Error('error')), 2000)
  });
}

let all = Promise.all([promise(1), promise(2), promise(3)]);
all.then(([r1, r2, r3]) => { // Этот блок игнорируется
  console.log(r1);
  console.log(r2);
  console.log(r3);
}).catch((error) => {
  console.log(error) // Код сразу будет выполнение тут
})
````

Тогда блок `then` не будет выполнен, управление перейдет к блоку `catch`.

Если в массив передать другие типы не `Promise`, то он вернет значения, как есть, преобразовав их с помощью `Promise.resolve()`.

Исходя из примера, какие можно сделать выводы:

- Метод `Promise.all()` принимает массив `Promise` и возвращает новый `Promise`.
- Новый `Promise` будет завершен, когда будут завершены все переданные `Promise`, а результатом будет массив результатов переданных `Promise`.
- Порядок элементов массива важен, первый `Promise` будет всегда первым.
- Частый пример сделать из всех запросов, товаров `Promise` и ждать их выполнения с `Promise.all()`.
- Если в одном `Promise` произошла ошибка, то `Promise` от `Promise.all()` немедленно завершается с ошибкой, с ошибкой отклоненного `Promise`.
- `Promise.all()` ничего не отменяет и не следит за выполнением.
- Если передать в массив другие типы данных, они будут возвращены новым `Promise` как есть.
- `Promise.all()` действует по принципу все или ничего.

### Пример 10.`Promise.allSettled()` Ждем выполнения сразу нескольких `Promise`, в любом случае.

> `allSettled()` в отличие от all() не прерывает свое выполнение, даже если в одном из `Promise` произошла ошибка.
{: .prompt-info }

`Promise.allSettled()` принимает коллекцию - массив `Promise`, после чего возвращает новый `Promise`, с результатами всех переданных `Promise`.

В примере, в переменные `r1,r2,r3` попадут объекты `Object { status: "fulfilled", value: 2 }`.

````javascript
function promise(type) {
  return new Promise((resolve, reject) => {
    setTimeout(() => resolve(type), 2000)
  });
}
let all = Promise.allSettled([promise(1),promise(2),promise(3)]);
all.then(([r1,r2,r3]) => {
  console.log(r1);
  console.log(r2);
  console.log(r3);
  console.log(all);
})
````

То есть в `all` будет `Promise`, с массивом объектов.

Допустим первый `Promise` был успешно разрешен, а последующие завершены с ошибкой.

````javascript
function promise(type) {
  return new Promise((resolve, reject) => {
    setTimeout(() => (type === 1) ? resolve(type) : reject(new Error('error')), 2000)
  });
}

let all = Promise.allSettled([promise(1), promise(2), promise(3)]);
all.then(([r1, r2, r3]) => {
  console.log(r1);
  console.log(r2);
  console.log(r3);
  console.log(all);
}).catch((error) => {
  console.log(error) // Код, которые не выполнится несмотря на ошибки
})

/* 
Object { status: "fulfilled", value: 1 }
Object { status: "rejected", reason: Error }
Object { status: "rejected", reason: Error }
 */
````

Как видим код не упал, мы даже не попали в `catch`. В результате у нас массив с объектами результатов `Promise`.

Очень удобно перебирать результат на месте. Примерно так:

````javascript
function promise(type) {
  return new Promise((resolve, reject) => {
    setTimeout(() => (type === 1) ? resolve(type) : reject(new Error('error')), 2000)
  });
}

let all = Promise.allSettled([promise(1), promise(2), promise(3),promise(1),promise(34)]);
all.then((res) => {
  res.forEach((item, num) => {
    console.log(`${num} ${item.status}`)
  })
})

/*
0 fulfilled
1 rejected
2 rejected
3 fulfilled
4 rejected
 */
````

Какие выводы можно сделать: 

- `Promise.allSettled()` удобно применять в независимых запросах к `api`, когда результаты не влияют на общий результат, в зависимых запросах лучше использовать метод `Promise.all()`.
- `Promise.allSettled()` всегда ждет завершения всех `Promise` в независимости от их результата.
- Есть проблема, если браузер не поддерживает `Promise.allSettled()`, тогда лучше для этого использовать полифил.

### Пример 11.`Promise.race()` Получаем результат `Promise` который выполниться быстрее.

`Promise.race()` принимает массив `Promise`, возвращает выполненный или отклоненный `Promise`, в зависимости от того с каким результатом завершился первый из переданных `Promise` со значением или отказом. 

````javascript
let p1 = new Promise((resolve, reject) => {
  setTimeout(() => {
    resolve(1)
  }, 10000)
});

let p2 = new Promise((resolve, reject) => {
  setTimeout(() => {
    resolve(2)
  }, 100)
});

let p3 = new Promise((resolve, reject) => {
  setTimeout(() => {
    resolve(3)
  }, 1000)
});

Promise.race([p1,p3,p2]).then((res) => {
  console.log(res);
})
````

В примере мы передаем три `Promise`, самый быстрый из них `p2`, он и вернется в качестве результата.

При этом даже если `Promise` завершился с ошибкой, он все равно будет возвращен, но только если он был выполнен быстрее всех.
Здесь мы уже попадем в блок `catch`.

````javascript
let p1 = new Promise((resolve, reject) => {
  setTimeout(() => {
    resolve(1)
  }, 10000)
});

let p2 = new Promise((resolve, reject) => {
  setTimeout(() => {
    //resolve(2)
    reject(new Error('error'));
  }, 100)
});

let p3 = new Promise((resolve, reject) => {
  setTimeout(() => {
    resolve(3)
  }, 1000)
});

Promise.race([p1,p3,p2]).then((res) => {
  console.log(res); // Этот код не сработает, так как у нас p2 выполнился быстрее
})
  .catch((error) => {console.log(error)}) // Сработает эта строчка
````

Основные выводы:

- `Promise.race()` возвращает самый быстрый `Promise` из всех переданных
- Если передать в `Promise.race()` пустой массив, то он никогда не сработает.
- Если в массив передать не `Promise`, все зависит в каком порядке передать, то что было раньше передано будет выполнено первым.
- Какой первый `Promise` выполнился, то будет возвращен, результат остальных будет проигнорирован.

### Пример 12.`Promise.any()` Первый успешно разрешенный `Promise`

`Promise.any()` возвращает первый переданный успешный `Promise`.

````javascript
let p1 = new Promise((resolve, reject) => {
  setTimeout(() => {
    resolve(1)
  }, 10000)
});

let p2 = new Promise((resolve, reject) => {
  setTimeout(() => {
    //resolve(2)
    reject(new Error('error'));
  }, 100)
});

let p3 = new Promise((resolve, reject) => {
  setTimeout(() => {
    resolve(3)
  }, 1000)
});


Promise.any([p1,p3,p2]).then((res) => {
  console.log(res);
})
  .catch((error) => {console.log(error)})
````

В примере выше вернется `Promise` `p3`, так как `p2` выполнился с ошибкой и нам не подходит.

Все `Promise` завершаются с ошибкой

````javascript
let p1 = new Promise((resolve, reject) => {
  setTimeout(() => {
    //resolve(1)
    reject(new Error('error'));
  }, 10000)
});

let p2 = new Promise((resolve, reject) => {
  setTimeout(() => {
    //resolve(2)
    reject(new Error('error'));
  }, 100)
});

let p3 = new Promise((resolve, reject) => {
  setTimeout(() => {
    //resolve(3)
    reject(new Error('error'));
  }, 1000)
});


Promise.any([p1,p3,p2]).then((res) => {
  console.log(res);
})
  .catch((error) => {console.log(error)})

// AggregateError: No Promise in Promise.any was resolved
````
Что это нам дает:

- `Promise.any()` вернет первый успешно выполненный `Promise`.
- Если передать пустой массив, то будет сработан обработчик `catch`.
- Если передать в массив не `Promise`, то будет возвращен первый переданных аргумент.

### Промежуточный итог статических методов

Выше рассмотрели некоторые статические методы, подытожим, чтобы видеть общую картину.

- `Promise.resolve()` - создает успешно выполненный `Promise`.
  - Код `let p = Promise.resolve(123).then((res) => {console.log(res)});` будет идентичен `let p1 = new Promise((resolve, reject) => {resolve(123);}).then((res) => {console.log(res)})`.
- `Promise.reject()` - создает `Promise` завершенный с ошибкой.
  - По сути код `let p = Promise.reject(new Error('error')).catch((error) => {console.log(error)});` идентичен коду `let p1 = new Promise((resolve, reject) => {reject(new Error('error'));}).catch((error) => {console.log(error)})`
- `Promise.all()` - ожидает выполнение всех `Promise`.
- `Promise.allSettled()` - ожидает выполнение всех `Promise`, при этом неважно как завершился `Promise`.
- `Promise.any()` - первый успешно разрешенный `Promise`.
- `Promise.race()` - `Promise` который выполниться быстрее всех.

| Метод                    | Выполняется (когда...)                            | Отклоняется (когда...)                         | Значение при выполнении                                |
|:-------------------------|:--------------------------------------------------|:-----------------------------------------------|:-------------------------------------------------------|
| **`Promise.all`**        | Все промисы **успешно** выполнены                 | **Первый** промис отклонился                   | Массив результатов всех промисов                       |
| **`Promise.allSettled`** | **Все** промисы завершены (успешно или с ошибкой) | **Никогда** (всегда выполняется)               | Массив объектов со статусом (`{status, value/reason}`) |
| **`Promise.race`**       | **Первый** промис (любой) завершился              | **Первый** промис (любой) завершился с ошибкой | Значение/ошибка первого завершившегося промиса         |
| **`Promise.any`**        | **Первый** промис **успешно** выполнился          | **Все** промисы отклонились                    | Значение первого успешно выполненного промиса          |

### Пример 13. Загрузить изображение с помощью резервной копии

Если изображение не загрузилось по какой-либо причине использовать резервный адрес загрузки изображения.

````javascript
function load(url, url2) {
  return new Promise((resolve, reject) => {
    let image = new Image();
    image.src = url;
    image.addEventListener('load', () => {
      resolve(image);
    });
    image.addEventListener('error', (error) => {
      if (!url2 || image.src === url2) {
        reject(error);
      } else {
        image.src = url2;
      }
    });
  });
}

load('https://repository-images.githubusercontent.com/133151614/520b1700-7305-11e9-9038-99237803609b', 'https://repository-images.githubusercontent.com/478183466/4335f975-f6ff-4115-bd0c-3f3a6534f783').then((i) => {
  let container = document.getElementById('container');
  container.appendChild(i);
}).catch((error) => {
  console.error('failed');
});
````

Функция `load` возвращает `Promise`, где сначала пытаемся загрузить изображение с первого адреса, если это получается генерироваться событие `load` и `Promise` успешно разрешается.

Если изображение не загрузилось, сработает событие `error`, где уже проверяем и пытаемся загрузить второе изображение, если это не получилось то `Promise` завершается с ошибкой.

Если все ок, второе изображение загружается.

В зависимости от результата, нужное изображение будет вставлено в дерево.

### Пример 14. Упрощение `Promise` с помощью `async`/`await`

Как можно было видеть код с использованием `Promise` через цепочки `then`,`catch` может быть громоздким и сложен для восприятия.

С целью упрощения был введен специальный синтаксис ключевые слова `async` и `await`.

Так, как часто требуется вернуть из функции `Promise`, ключевое слово `async` делает функцию асинхронной.

Сделаем обычную функцию которая возвращает `Promise`.

````javascript
function getData(){
  return new Promise((resolve, reject) => {
    resolve(123)
  })
}
````

Теперь сделаем то же самое, только с использованием ключевого слова `async`.

````javascript
async function getData2() {
  return 123;
}
````

Или с помощью статического метода `resolve`

````javascript
function getData3(){
  return Promise.resolve(123);
}
````

В результате получаем один и тот же результат.

````text
Promise { <state>: "fulfilled", <value>: 123 }
Promise { <state>: "fulfilled", <value>: 123 }
Promise { <state>: "fulfilled", <value>: 123 }
````

Соответственно обработаем результат

````javascript
getData().then((res) => {console.log(res)}); // 123
getData2().then((res) => {console.log(res)}); // 123
getData3().then((res) => {console.log(res)}); // 123
````

Асинхронные функции полезны при работе с `api`, чтение файлов, и др.

`await` "Приостанавливает" выполнение `async` функции до тех пор, пока `Promise` не выполнится успешно.

Например, как то так.

````javascript
async function getData2() {
  return setTimeout(() => {console.log('async')},3000)
}

async function setData()
{
  let u = await getData2();
}

setData();
````

`await` нельзя использовать вне асинхронной функции.

````javascript
function delay(ms) {
  return new Promise(resolve => {
    setTimeout(resolve, ms);
  });
}

async function construct(d,text){
  await delay(d);
  console.log(text);
}

async function setData() {
  let u1 = await construct(3000,'async 1');
  let u2 = await construct(3000,'async 2');
  console.log('Все функции выполнены последовательно!');
}

setData();
````

В этом примере мы используем вспомогательную функцию `delay`, которая вернет `Promise`.
И функция `construct` которая будет вызывать функцию `delay`. 
`setData` будет вызывать `construct`.

В результате функции будут выполнены синхронно.

Если нужно выбросить исключение из асинхронной функции, то это можно сделать так

````javascript
async function th() {
  throw new Error("err");
}

th().catch((error) => {console.log(error)});
````

Либо с помощью `await`.

````javascript
async function th() {
  throw new Error("err");
}

async function ht()
{
  await th();
}

ht().catch((error) => {console.log(error)});
````

## Итог

Что можно сказать по итогу:

`Promise` объект, представляющий будущее завершение асинхронной операции.

- `Promise` помогает бороться с `Callback Hell`
- `Promise` дает возможность централизованно обрабатывать ошибки в блоке `.catch()`.
- Можно вызывать зависимые друг от друга действия, это удобно.
- Как правило, все асинхронные действия должны возвращать `Promise`.
- `Promise` - это унифицированный подход который понимают все браузеры.
- Отклоненный `rejected` `Promise` без `.catch()` может уронить все приложение, поэтому `.catch()` лучше всегда добавлять.
- В реальной разработке приходится прибегать к `console.log` на каждом шаге, для отладки кода.
- Ключевое слово `async` перед функцией всегда вернет `Promise`.
- `async`/`await` Упрощают работу с `Promise`. По сути это просто синтаксический сахар. Код при этом получает более линейным и работает более синхронным образом.
- Не смешивайте синтаксис `async/await` и `Promise.then`
- Функция с `async` если внутри содержит выражение `await` приостанавливает выполнение функции и ждет ответа от асинхронной функции, но не отнимает ресурсы процессора.
- Если `Promise` отклоняется, то `await` генерирует исключение с отклонённым значением.
- Если типом значения `await` является не `Promise` то оно будет преобразовано к успешно выполненному `Promise`.
