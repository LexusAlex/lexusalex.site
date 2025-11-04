---
title: Linux основные команды
description: >-
  Часто используемые команды в linux
author: alex
date: 2025-11-04 11:30:00 +0300
categories: [Linux]
tags: [linux]
image:
  path: /assets/img/posts/main/linux.png
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: Часто используемые команды в linux
---

## Поиск внутри файлов grep

````shell
grep -Rnwi /var/log/ -e "udev:/sys/devices/"
````

### Опции

- `-i` - игнорировать регистр
- `-R` - рекурсивный поиск в директориях + следовать символическим ссылкам
- `-n` - показать номера строк при совпадении
- `-w` - искать целые слова
