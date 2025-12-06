---
title: Команды git
description: >-
  Команды и приемы работы с git
author: alex
date: 2055-12-15 18:40:00 +0300
categories: [Git,Branches]
image:
  path: /assets/img/posts/main/branches.webp
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: Индексирование и фиксация git
---

Цель данной заметки показать различные приемы и ситуации работы с `git` из командной строки.

Информация будет добавляться по мере изучения

## git add / git restore добавить/убрать из индекса

````shell
git add . # В область индекса будут добавлены все файлы и каталоги, новые, измененные, удаленные
git add file2 dir1 # Добавить в индекс конкретный файл или папку или несколько файлов/папок
git restore file2 # Убрать изменения из рабочей области, то есть вернуть файл в состояние последнего коммита
git restore --worktree file2 # Убрать изменения из рабочей области, то есть вернуться к версии репозитория
git restore --staged file2 # Убрать только из индекса, даже если там были изменения
git restore --staged --worktree file # Если файл был добавлен в индекс и изменен, команда уберет его из индекса и подзатрет все изменения в рабочей копии
````

## git log

git log --since="1.year ago" --oneline | wc -l // Кол-во коммитов за последний год

## git status

git rm file
git restore --staged  file
git restore file


git rm --cached - сделать фаил неотслежиеваемым

git rm -f - удалить фаил принудительно

git mv file file8

https://r4ven.me/clippings/shpargalka-po-konsolnym-komandam-git/

https://github.com/Oxana-S/Git-Help/blob/main/%D0%A8%D0%BF%D0%B0%D1%80%D0%B3%D0%B0%D0%BB%D0%BA%D0%B0%20%D0%BF%D0%BE%20%D0%BA%D0%BE%D0%BD%D1%81%D0%BE%D0%BB%D1%8C%D0%BD%D1%8B%D0%BC%20%D0%BA%D0%BE%D0%BC%D0%B0%D0%BD%D0%B4%D0%B0%D0%BC%20Git.md

https://github.com/cyberspacedk/Git-commands

https://lexusalex.ru/commands#git
