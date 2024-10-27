---
title: Переход на xubuntu desktop 24.04
description: >-
  Как я переходил на xubuntu desktop 24.04
author: alex
date: 2024-10-27 13:45:00 +0300
categories: [Linux, Xubuntu]
tags: [linux,xubuntu]
image:
  path: /assets/img/posts/main/xubuntu.jpg
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: Переход на xubuntu desktop 24.04
---

Я уже давно использую дистрибутив linux [xubuntu](https://xubuntu.org/). Он легкий, кастомизируемый.

Ранее я уже писал [https://lexusalex.ru/30-switching-to-ubuntu-2204](https://lexusalex.ru/30-switching-to-ubuntu-2204), как переходил хubuntu 22.04 LTS.

Но время идет, пора обновляться, сегодня уже переходим на xubuntu 24.04 LTS. 

Установка стандартная. Ставим максимальную версию со всеми утилитами.

Перечислю здесь основные моменты какие я лично для себя делаю, дабы подготовить систему к работе.

## Избавляемся от snap

Так и не понял его преимущества, поэтому удаляем.

````shell
# Версия snap
snap --version
# Список пакетов snap
snap list
# Удаляем последовательно каждый пакет, например так
snap remove thunderbird 
snap remove firefox
snap remove firmware-updater
snap remove snapd-desktop-integration
snap remove gnome-42-2204
snap remove snap-store
snap remove gtk-common-themes
snap remove bare
snap remove core22
snap remove snapd
# Снова проверка
snap list
# Фиксируем snap
sudo systemctl stop snapd
sudo systemctl disable snapd
sudo systemctl mask snapd
sudo apt purge snapd -y
sudo apt-mark hold snapd
````

Далее в файле `/etc/apt/preferences.d/nosnap.pref`, Нужно добавить строки:

````text
Package: snapd
Pin: release a=*
Pin-Priority: -10
````

Далее делаем стандартное обновление.

````shell
sudo apt update
sudo apt upgrade
````

Подчищаем все остальное, что оставил `snap`.

````shell
rm -rf ~/snap
sudo rm -rf /snap
sudo rm -rf /var/snap
sudo rm -rf /var/lib/snapd
````

От `snap` избавились, делаем `reboot`.

## Chromium Gost

Если нужен хоть какой-то браузер пока нет firefox, то ставим deb пакет

https://github.com/deemru/Chromium-Gost/releases

## Дополнительные пакеты

- `ark` - архиватор, которым пользуюсь
- `network-manager-openvpn-gnome` - для настроек vpn.
- [https://306.antroot.ru/jetbrains-activation](https://306.antroot.ru/jetbrains-activation) - активация `phpstorm`.
- `gnome-system-monitor` - отличный системный монитор

## Firefox

Ставим `firefox`

[https://support.mozilla.org/ru/kb/ustanovka-firefox-na-linux#w_ustanovka-deb-paketa-firefox-dlia-osnovannykh-na-debian-distributivov-rekomenduetsia](https://support.mozilla.org/ru/kb/ustanovka-firefox-na-linux#w_ustanovka-deb-paketa-firefox-dlia-osnovannykh-na-debian-distributivov-rekomenduetsia)

## Libreoffice 

Обновляем `Libreoffice` до последней версии [https://fostips.com/update-libreoffice-office-suite-ubuntu/](https://fostips.com/update-libreoffice-office-suite-ubuntu/)

## git

Стандартная настройка `git`

````shell
sudo add-apt-repository -y ppa:git-core/ppa
apt update
sudo apt install git
git config --global core.excludesfile ~/.gitignore
echo '.idea/' >> ~/.gitignore
git config --global user.name ""
git config --global user.email 
git config --global init.defaultBranch main
````

### gitbub gitlab

````shell
## Общая генерация ключа
ssh-keygen -t ed25519 -C ""
cat ~/.ssh/id_ed25519.pub

## Проверка github
ssh -T git@github.com

## Проверка gitlab
ssh -p 60022 -T git@git.gitlab.com
````

## docker and docker-compose

Просто команды из документации

 ````shell
# Add Docker's official GPG key:
sudo apt-get update # Обновляем пакеты
sudo apt-get install ca-certificates curl # Установка пакета для сертификатов и curl
sudo install -m 0755 -d /etc/apt/keyrings # Права на директорию для ключей
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc # Скачиваем ключ
sudo chmod a+r /etc/apt/keyrings/docker.asc # Всем для чтения

# Add the repository to Apt sources:
echo \ # Добавим репозитории
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update # Обновляем пакеты
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin # Ставим пакеты docker
````

Проверяем, что все установились:

````shell
service docker status
docker -v # Docker version 27.2.0, build 3ab4256
docker compose version # Docker Compose version v2.29.2
````

Дальнейшие шаги, добавляем текущего пользователя в группу docker:

````shell
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker
````

## ansible

Стандартная установка, ничего необычного.

````shell
sudo apt update 
sudo apt install -y software-properties-common 
sudo add-apt-repository --yes --update ppa:ansible/ansible 
sudo apt install -y ansible
````

Возможно, данная информация кому-то поможет с настройкой системы.


