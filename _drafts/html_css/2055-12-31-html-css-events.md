
https://doka.guide/js/events/
https://learn.javascript.ru/introduction-browser-events

https://html.spec.whatwg.org/multipage/webappapis.html#event-handlers-on-elements,-document-objects,-and-window-objects



Событийная модель HTML-документа — это фундаментальный механизм, позволяющий JavaScript взаимодействовать с пользователем и реагировать на действия в браузере. Рассмотрим ключевые аспекты:

---

### **1. Основные понятия**
- **Событие (Event)**: Действие или происшествие (клик мыши, нажатие клавиши, загрузка страницы и т.д.).
- **Обработчик события (Event Handler)**: Функция, вызываемая при возникновении события.
- **Цель события (Event Target)**: Элемент, на котором произошло событие (например, кнопка при клике).

---

### **2. Поток событий (Event Flow)**
События распространяются по документу в 3 фазы:
1. **Фаза погружения (Capturing Phase)**  
   Событие движется от `window` к целевому элементу (сверху вниз по DOM).
2. **Фаза цели (Target Phase)**  
   Событие достигает целевого элемента.
3. **Фаза всплытия (Bubbling Phase)**  
   Событие движется обратно от целевого элемента к `window` (снизу вверх).

```html
<div id="parent">
  <button id="child">Click</button>
</div>
```
При клике на `button`:
1. Погружение: `window` → `document` → `<div>` → `<button>`.
2. Цель: `<button>`.
3. Всплытие: `<button>` → `<div>` → `document` → `window`.

---

### **3. Способы назначения обработчиков**
#### **a. Атрибуты HTML (не рекомендуется)**
```html
<button onclick="alert('Click!')">Press</button>
```
**Минусы**: Смешение разметки и логики, ограниченная функциональность.

#### **b. Свойства DOM-элементов**
```javascript
const btn = document.querySelector('button');
btn.onclick = () => alert('Click!');
```
**Минусы**: Можно назначить только один обработчик.

#### **c. `addEventListener()` (рекомендуется)**
```javascript
btn.addEventListener('click', () => alert('Click!'));
```
**Преимущества**:
- Поддержка множества обработчиков.
- Управление фазой обработки (погружение/всплытие).
- Возможность удаления обработчика.

---

### **4. Объект события (Event Object)**
При вызове обработчика передается объект события с полезными свойствами:
```javascript
btn.addEventListener('click', (event) => {
  console.log(event.type);     // Тип события (например, "click")
  console.log(event.target);   // Целевой элемент
  console.log(event.currentTarget); // Элемент, к которому прикреплен обработчик
});
```

---

### **5. Управление событиями**
#### **Отмена действий по умолчанию**
```javascript
// Блокировка отправки формы
form.addEventListener('submit', (e) => {
  e.preventDefault(); 
});
```

#### **Остановка распространения события**
```javascript
btn.addEventListener('click', (e) => {
  e.stopPropagation(); // Останавливает всплытие/погружение
});
```

---

### **6. Делегирование событий (Event Delegation)**
Техника для обработки событий на динамических элементах через родителя:
```html
<ul id="list">
  <li>Item 1</li>
  <li>Item 2</li>
</ul>
```
```javascript
document.getElementById('list').addEventListener('click', (e) => {
  if (e.target.tagName === 'LI') {
    console.log(e.target.textContent); // Работает для новых <li>
  }
});
```
**Преимущества**:
- Экономия памяти (один обработчик вместо множества).
- Поддержка динамически добавленных элементов.

---

### **7. Важные события**
| Тип          | Примеры событий         | Описание                          |
|--------------|-------------------------|-----------------------------------|
| **Мышь**     | `click`, `mouseover`    | Действия мыши.                    |
| **Клавиатура**| `keydown`, `keyup`      | Нажатия клавиш.                   |
| **Формы**    | `submit`, `input`       | Изменения в формах.               |
| **Документ** | `DOMContentLoaded`      | Загрузка DOM (без стилей/изображений). |
| **Окно**     | `load`, `resize`        | Загрузка страницы, изменение размера окна. |

---

### **8. Пользовательские события**
Создание собственных событий:
```javascript
// Создание события
const customEvent = new CustomEvent('custom', {
  detail: { message: 'Hello!' }
});

// Назначение обработчика
element.addEventListener('custom', (e) => {
  console.log(e.detail.message); // "Hello!"
});

// Генерация события
element.dispatchEvent(customEvent);
```

---

### **9. Асинхронность событий**
События обрабатываются асинхронно через **очередь событий (Event Queue)**. Основной поток выполнения сначала завершает синхронный код, затем обрабатывает события из очереди.

---

### **Пример комплексного использования**
```html
<div id="container">
  <button>Click me</button>
</div>
```
```javascript
const container = document.getElementById('container');

// Обработчик на контейнере (делегирование)
container.addEventListener('click', (e) => {
  if (e.target.tagName === 'BUTTON') {
    console.log('Button clicked!');
    e.target.style.background = 'red';
  }
});

// Генерация пользовательского события
container.addEventListener('highlight', () => {
  container.style.border = '2px solid blue';
});

// Триггер события через 2 секунды
setTimeout(() => {
  container.dispatchEvent(new Event('highlight'));
}, 2000);
```

---

### **Итог**
Событийная модель HTML позволяет:
- Реагировать на действия пользователя.
- Управлять потоком событий (погружение/всплытие).
- Использовать делегирование для оптимизации.
- Создавать интерактивные интерфейсы через кастомные события.

Понимание этих концепций критически важно для разработки динамичных веб-приложений.

https://html.spec.whatwg.org/multipage/indices.html#events-2
