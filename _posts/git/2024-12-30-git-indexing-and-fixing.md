---
title: Индексирование и фиксация в git
description: >-
  Рассмотрим индексы и коммиты в git
author: alex
date: 2024-12-30 18:10:00 +0300
categories: [Git,Changes]
image:
  path: /assets/img/posts/main/git-add-commit.png
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: Индексирование и фиксация git
---

В прошлой статье [https://lexusalex.site/posts/git-branches/](https://lexusalex.site/posts/git-branches/) мы пришли к пониманию, что такое ветки.

Сегодня подробнее посмотрим подробнее на индексы и коммиты.

## Индекс

Если кратко, то **индекс** в git это промежуточный слой между рабочим каталогом и репозиторием.

В индексе накапливаются изменения о файлах, который потом пойдут в коммит (то есть будут зафиксированны).

Если рассматривать процесс работы над кодом, то он состоит из редактирования файлов в рабочем каталоге, добавление изменений в индекс и фиксация изменений.

То есть из трех составляющих:

````text
Рабочий каталог
Каталог индексирования
Зафиксированная история
````

При этом добавлять и удалять из индекса до фиксации изменений можно непрерывно.

Если выполнить команду `git status`. Она покажет состояние индекса на текущий момент. По сути команда сравнивает рабочий каталог и зафиксированную историю, и выводит различия файлов.

В индекс не попадают содержимое файлов, а выводится только то, что пойдет в следующий коммит. 

При выполнении коммита изменения будут взяты из индекса.

## Группы файлов в git

`git` делит файлы на группы:

- Отслеживаемые - `tracked` - Это файл уже в репозитории или в индексе, его добавляют командой `git add`.
- Игнорируемые - `ignored` - Это временные файлы, которые не должны быть в репозитории, для этого используется файл `.gitignore`.
- Неотслеживаемые - `untracked` - Это файл, который не принадлежит верхним категориям.

Перейдем к примерам:

Вывод, который дает команда `git commit`: 

Если мы правим уже добавленный файл в репозиторий, он отслеживаемый, и будет добавлен в коммит при добавлении в индекс.

````shell
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
        modified:   file
````

Если мы добавим новый файл, он становиться неотслежиеваемым.

````shell
Untracked files:
  (use "git add <file>..." to include in what will be committed)
        file2
````

А теперь добавим файл `.gitignore`, и включим в него игнорируемый файл `file3`, мой редактор будет подсвечивать это так:

![Файлы в репозитории](/assets/img/posts/git/index/git-index-1.png){: .shadow }
_Файлы в репозитории_

- `.gitignore` и `file2` красные, то есть являются неотслежиеваемыми.
- `file` синий, то есть модифицированный, готовый к коммиту
- `file3` желтый, игнорируемый, через файл `.gitignore`

С файлами мы можем делать следующие операции:

- Добавить
- Редактировать
- Удалить

Для каждой из этой операции есть отдельные команды.

## git add

`git add` добавляет файл в индекс и делает следующее:

- Если файл не отслеживается, он будет добавлен в индекс и ему будет присвоен статус "отслежиеваемый".
- Если файл был модифицирован, то есть он уже был в репозитории, он будет подсвечен зеленым цветом `modified:file`, то есть готовый к коммиту.
- Если файл игнорируемый, то при добавлении его в индекс, получим ошибку `The following paths are ignored by one of your .gitignore files: file3`, что на файл нельзя делать команду `git add`.
- Если `git add` применяется к каталогу, все файлы и подкаталоги будут обработаны рекурсивно. 

Если не выполнить `git add` и модифицировать файл, то получится две версии файла, он был зафиксирован в репозитории, другой в рабочем каталоге.

## git rm

`git rm` удаляет файл из рабочего каталога и из индекса.

Команда работает только с отслеживаемыми файлами.

У нас есть отслеживаемый неизмененный файл, мы его удаляем и его удаление добавляется в индекс.

````shell
git rm file
rm 'file'
git status
On branch main
Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
        deleted:    file
````

Если файл отслеживаемый и измененный, то удалить и проиндексировать файл можно командой

````shell
git rm -f file
rm 'file'
git status
On branch main
Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
        deleted:    file
````

При любом удалении файла `git` будет проверять его версию в последнем коммите и рабочем каталоге, если они различны то не даст удалить, то есть данные не потеряются.  

## git mv

Для переименования или перемещения файла используется `git mv`.

То есть, при выполнении команды, `git` это увидит и занесет в индекс

````shell
git mv file file8
git status
On branch main
Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
        renamed:    file -> file8
````

`git` на самом деле не отслеживает переименование, это повлияет только на объекты деревьев.

## Коммит

Текущее состояние в определенный момент времени в git называют - **коммитом**.

Коммит обеспечивает просмотр истории репозитория. Все изменения в репозиторий вносятся строго через коммит.

Обычно коммиты делают разработчики, чтобы зафиксировать часть своей работы, но так бывает не всегда, иногда коммит создается автоматически, либо с помощью программы. Об этом мы поговорим в дальнейших статьях.

Коммиты можно делать часто или редко - это зависит от разработчика. Желательно делать коммит, когда проект находится в стабильном состоянии.

Коммит представляет собой набор изменений по отношению к предыдущему состоянию.

Если в проекте 1000 файлов и все они будут внесены в коммит, это и будет снимком состояния проекта, на текущий момент времени.

## Идентификаторы

На коммит можно сослаться явным образом (абсолютным) и неявным способом (относительным).

Явный способ - это уникальный ID коммита, а неявный это символическая ссылка `HEAD`, которая указывает на последний коммит в ветке.

Рассмотрим подробнее типы имен коммитов.

## Абсолютное имя

Абсолютное имя, это `SHA-1` хеш объекта коммита.

Например: `98e1addacbfee2d477e1a881409d1f48b751bcc1`.

Его особенности:

- Хеш относится только к конкретному коммиту.
- Неважно где в истории будет находиться коммит.
- ID коммит уникален в рамках всего репозитория.
- 40 символов можно сократить, до уникального префикса внутри репозитория, например `98e1adda`.

Эта ссылка `четко` указывает на объект коммита в дереве объектов git.

## Относительное имя

Так же могут быть символические ссылки, которые указывают на коммит косвенно.

Каждая символическая ссылка имеет полное имя, которое начинается с `refs` в каталоге `.git`.

- `refs/heads` - локальные ветки
- `refs/remotes` - удаленные ветки отслеживания
- `refs/tags` - теги

Например, имя локальной представлено как `refs/heads/main`, а удаленной ветки отслеживания `refs/remotes/origin/main`, а тег как `refs/tags/v0.1.1`.

При поиске ссылки можно использовать полноценное имя или ее псевдоним.

Внутри `git` использует при поиске правило первого совпадения согласно перечню:

- `.git`
- `.git/refs`
- `.git/refs/tags`
- `.git/refs/heads`
- `.git/refs/remotes`
- `.git/refs/remotes/../HEAD`.

В `git` по умолчанию есть следующие символические ссылки:

- `HEAD` - последний коммит в ветке. При переключении веток `HEAD` обновляется и указывает на последний коммит переключенной ветки.
- `ORIG_HEAD` - предыдущая версия `HEAD`, используется для отката к предыдущему состоянию слиянию и сбросу.
- `FETCH_HEAD` - используется для удаленных репозиториев, куда пишутся ID извлекаемых веток
- `MERGE_HEAD` - Используется при слиянии веток.

Мы можем ссылаться относительно последнего коммита в ветке, по истории вверх, например:

````shell
git show-branch --more=100
! [branch-1] commit 6
 ! [branch-2] commit 3
  ! [branch-3] commit 7
   * [branch-4] commit 8
    ! [main] commit 1
-----
   *  [branch-4] commit 8
  +*  [branch-3] commit 7
  +*  [branch-3^] commit 4
 ++*  [branch-2] commit 3
+     [branch-1] commit 6
+     [branch-1^] commit 5
+++*  [branch-2^] commit 2
+++*+ [main] commit 1
````

## История коммитов

Одна из важных вещей - это просмотр истории. Для этого используется команда `git log`.

Если просто выполнить команду, то будут выведены коммиты в обратном хронологическом порядке, от последнего коммита

````shell
git log
commit 5adb352052433ef484e5979be8800dd004e3ce44 (HEAD -> branch-4)
Author:  <>
Date:   Sun Dec 15 17:45:04 2024 +0300

    commit 8
...
````

Чтобы более детально вывести информацию, нужно задать точку откуда смотреть историю

````shell
git log branch-3
````

Также можно сократить кол-во выводимых коммитов, например выведем 1 коммит

````shell
git log branch-3 -1
````

Более подробно команду `git log` рассмотрим отдельно.

