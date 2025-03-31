---
title: Группировка объектов в javascript
description: >-
  Способы как можно сгруппировать массив объектов по ключу
author: alex
date: 2025-03-31 12:30:00 +0300
categories: [Javascript, Notes]
tags: [js]
image:
  path: /assets/img/posts/main/grouping.webp
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: Группировка объектов в javascript
---

Группировка объектов в массиве не такая уже и тривиальная задача, но все же ее можно решить несколькими способами.

## Способ 1

Первое, что приходит в голову при решении данной задачи, использование функции `reduce`.

Допустим есть массив объектов нужно сгруппировать их определенному ключу.

````javascript
// Массив пользователей
const users = [
    {name : "Test", role: "group1"},
    {name : "Test1", role: "group1"},
    {name : "Test2", role: "group2"},
    {name : "Test3", role: "group1"},
    {name : "Test4", role: "group3"},
    {name : "Test5", role: "group2"},
    {name : "Test6", role: "group1"}
];

const groupping = users.reduce( (acc, person) => {
    // Если в аккумуляторе нет ключа, то формируем его и делаем пустой массив
    if (!acc[person.role]) {
        acc[person.role] = [];
    }
    // Наполняем массив значениями
    acc[person.role].push(person.name);
    // Возвращаем аккумулятор
    return acc;
}, {});

// Корректный результат
/*
 {
  "group1": [
    "Test",
    "Test1",
    "Test3",
    "Test6"
  ],
  "group2": [
    "Test2",
    "Test5"
  ],
  "group3": [
    "Test4"
  ]
} 
 */
````

Так, а если нам нужны не массивы значений, а объекты, перепишем и подсократим решение.

Кода получилось меньше

````javascript
const grouping = users.reduce((result, item) => {
    // Процесс начинается с пустого объекта
    // Создаем ключи, если нет то пустой массив, и в итоге заполняем массив текущим объектом
    (result[item.role] = result[item.role] || []).push(item);
    return result;
}, {});


/*
{
  "group1": [
    {
      "name": "Test",
      "role": "group1"
    },
    {
      "name": "Test1",
      "role": "group1"
    },
    {
      "name": "Test3",
      "role": "group1"
    },
    {
      "name": "Test6",
      "role": "group1"
    }
  ],
  "group2": [
    {
      "name": "Test2",
      "role": "group2"
    },
    {
      "name": "Test5",
      "role": "group2"
    }
  ],
  "group3": [
    {
      "name": "Test4",
      "role": "group3"
    }
  ]
}
 */
````

## Способ 2

Еще один способ группировки элементов, использовать `Map`.

````javascript
// Массив слушателей
const users = [
    {name : "Test", role: "group1"},
    {name : "Test1", role: "group1"},
    {name : "Test2", role: "group2"},
    {name : "Test3", role: "group1"},
    {name : "Test4", role: "group3"},
    {name : "Test5", role: "group2"},
    {name : "Test6", role: "group1"}
];

const grouped = new Map();

users.forEach(item => {
    if (!grouped.has(item.role)) {
        grouped.set(item.role, []);
    }
    grouped.get(item.role).push(item);
});

const grouping = Object.fromEntries(grouped);

/*
{
  "group1": [
    {
      "name": "Test",
      "role": "group1"
    },
    {
      "name": "Test1",
      "role": "group1"
    },
    {
      "name": "Test3",
      "role": "group1"
    },
    {
      "name": "Test6",
      "role": "group1"
    }
  ],
  "group2": [
    {
      "name": "Test2",
      "role": "group2"
    },
    {
      "name": "Test5",
      "role": "group2"
    }
  ],
  "group3": [
    {
      "name": "Test4",
      "role": "group3"
    }
  ]
}
 */
````

## Способ 3

Группировка по нескольким полям. Если есть необходимость группировки по нескольким полям, можно использовать `reduce` для этого.

````javascript
// Массив слушателей
const users = [
    {name : "Test", role: "group1", group: "1"},
    {name : "Test1", role: "group1", group: "2"},
    {name : "Test2", role: "group2", group: "1"},
    {name : "Test3", role: "group1", group: "3"},
    {name : "Test4", role: "group3", group: "1"},
    {name : "Test5", role: "group2", group: "2"},
    {name : "Test6", role: "group1", group: "1"}
];

const groupped = users.reduce((result, item) => {
    const key = `${item.role}-${item.group}`;
    (result[key] = result[key] || []).push(item);
    return result;
}, {});

/*
{
  "group1-1": [
    {
      "name": "Test",
      "role": "group1",
      "group": "1"
    },
    {
      "name": "Test6",
      "role": "group1",
      "group": "1"
    }
  ],
  "group1-2": [
    {
      "name": "Test1",
      "role": "group1",
      "group": "2"
    }
  ],
  "group2-1": [
    {
      "name": "Test2",
      "role": "group2",
      "group": "1"
    }
  ],
  "group1-3": [
    {
      "name": "Test3",
      "role": "group1",
      "group": "3"
    }
  ],
  "group3-1": [
    {
      "name": "Test4",
      "role": "group3",
      "group": "1"
    }
  ],
  "group2-2": [
    {
      "name": "Test5",
      "role": "group2",
      "group": "2"
    }
  ]
}
 */
````
