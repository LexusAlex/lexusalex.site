Атрибуты slot в HTML используются в контексте Web Components для управления тем, куда будет вставляться контент внутри Shadow DOM компонента. Вот подробнее об этих атрибутах:

1. Атрибут slot (глобальный атрибут)

Назначение: Атрибут slot назначает элемент слоту в Shadow DOM . Элемент с атрибутом slot будет вставлен в <slot> элемент, у которого атрибут name соответствует значению атрибута slot .

Использование: Этот атрибут добавляется к HTML-элементам, которые находятся вне Web Component, но предназначены для отображения внутри него.

Пример:

html
<my-component>
<span slot="my-slot">Этот текст будет вставлен в слот с именем "my-slot"</span>
</my-component>
2. Элемент <slot>

Назначение: Элемент <slot> является плейсхолдером внутри Web Component, который указывает, куда будет вставлен контент, переданный извне .

Атрибуты элемента <slot>:

name: Определяет имя слота. Элементы с атрибутом slot, значение которого совпадает с name слота, будут вставлены в этот слот . Если имя не указано, это будет "default slot".
Пример:

html
<template id="my-component-template">
  <style>
    /* Стили компонента */
  </style>
  <div>
    <p>Контент компонента до слота.</p>
    <slot name="my-slot">
      <!-- Контент по умолчанию, если слот пуст -->
      Здесь должен быть контент.
    </slot>
    <p>Контент компонента после слота.</p>
  </div>
</template>

<script>
  class MyComponent extends HTMLElement {
    constructor() {
      super();
      this.attachShadow({ mode: 'open' });
      const template = document.getElementById('my-component-template');
      this.shadowRoot.appendChild(template.content.cloneNode(true));
    }
  }
  customElements.define('my-component', MyComponent);
</script>
Как это работает вместе:

Вы определяете Web Component с использованием JavaScript и создаете Shadow DOM.
Внутри Shadow DOM вы используете элемент <slot> для указания мест, куда можно вставлять контент.
Когда вы используете свой Web Component в HTML, вы можете добавлять дочерние элементы с атрибутом slot, чтобы указать, в какой слот они должны быть вставлены.
Если слот остается пустым (нет элементов с соответствующим атрибутом slot), отображается контент по умолчанию, указанный внутри <slot>.
Пример полного использования:

html
<!DOCTYPE html>
<html>
<head>
  <title>Slot Example</title>
</head>
<body>

  <my-component>
    <span slot="my-slot">Этот текст будет вставлен в слот с именем "my-slot"</span>
    <p>Этот текст не будет в слоте, так как нет атрибута slot</p>
  </my-component>

  <template id="my-component-template">
    <style>
      div {
        border: 1px solid black;
        padding: 10px;
      }
    </style>
    <div>
      <p>Контент компонента до слота.</p>
      <slot name="my-slot">
        <!-- Контент по умолчанию, если слот пуст -->
        Здесь должен быть контент.
      </slot>
      <p>Контент компонента после слота.</p>
    </div>
  </template>

  <script>
    class MyComponent extends HTMLElement {
      constructor() {
        super();
        this.attachShadow({ mode: 'open' });
        const template = document.getElementById('my-component-template');
        this.shadowRoot.appendChild(template.content.cloneNode(true));
      }
    }
    customElements.define('my-component', MyComponent);
  </script>

</body>
</html>
В этом примере:

<my-component> - это ваш Web Component.
<span slot="my-slot"> - это контент, который будет вставлен в слот.
<slot name="my-slot"> - это место в Shadow DOM, куда будет вставлен контент.
Атрибуты slot позволяют создавать гибкие и переиспользуемые Web Components, в которые можно легко вставлять контент извне.
