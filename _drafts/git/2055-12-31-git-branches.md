---
title: Ветки в git
description: >-
  Про использования веток в git
author: alex
date: 2055-11-03 15:20:00 +0300
categories: [Git,Branches]
tags: [git]
image:
  path: /assets/img/posts/main/branches.webp
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: Основные команды и работа с git
---

## Ветки

Ветки позволяют вести разработку сразу в нескольких направлениях.

Они могут создаваться совершенно по разным причинам. 

Например:

- Ветка может отражать состояние проекта `stable`, `development`, `production`.
- Можно разрабатывать одновременно и новую и старую версию проекта в отдельных ветках.
- Считается, что для каждой функциональности нужно заводить отдельную **ветку**.
- Если проект большой каждую задачу или модуль можно делать в отдельной ветке.

## Ветка по умолчанию

Ветка существует с самого рождения репозитория, имя может быть любым, но при инициализации она называется `master` или `main`.

Название можно легко поменять, при создании репозитория, или в конфигурации

````shell
# Глобальное название ветки по умолчанию для всех репозиториев
git config --global init.defaultBranch main
# Или создать ветку по умолчанию с любым названием
git init --initial-branch=test-branch
git init -b abracadabra-branch
````

## Переименовать ветку

Переименовать ветку не сложно. Достаточно указать старое имя и новое имя ветки

````shell
git branch -m test-branch main
````

## Как именовать ветку

- Веткам можно давать иерархические имена вроде `test/8.4/branch-my-test/diff`
- Ветка не может заканчиваться символом `/`, тогда получим ошибку `fatal: 'test/' is not a valid branch name`
- В имени ветки 
