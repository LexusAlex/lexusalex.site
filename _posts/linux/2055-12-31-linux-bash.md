Bash linux

- Нужен для автоматизации задач

Язык сценариев bash

- Объявление переменных
- Условные операторы
- Операторы цикла
- Объявление массивов
- Объявление функций

Несколько частей

Расширение `.sh` требуется только в случае если мы хотим поместить скрипт в автозагрузку, в других случаях это не требуется

https://www.youtube.com/watch?v=lszvBuwGfAo&t=1365s

`+x` или `755` фаил можно запускать, это аналог `.exe` в windows

## Шибанг

`#! /usr/bin/bash` на работу скрипта шибанг не влияет

`./script` - запуск скрипта или
`/root/script` - запуск скрипта

`/usr/local/bin`
Но если скрипт поместить в директории переменой `$PATH`,тогда можно запускать с подсказкой табуляции

https://selectel.ru/blog/tutorials/what-is-shebang-for-in-bash-and-python/

## Переменные
 
Объявить и использовать переменные

````shell
#!/bin/bash
x=12
echo $x
echo "$x"
````

Название переменной должно отражать что в ней хранится

Переменные, введенные в терминале, сохраняются только в текущей сессии


Переменная с цифры не может называться

https://selectel.ru/blog/tutorials/linux-bash-scripting-guide/


