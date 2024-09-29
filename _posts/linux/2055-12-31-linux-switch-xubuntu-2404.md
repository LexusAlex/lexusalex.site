---
title: Переход на xubuntu 24.04
description: >-
  Как я переходил на xubuntu 24.04
author: alex
date: 2055-12-31 20:30:00 +0300
categories: [Linux]
tags: [linux,xubuntu]
image:
  path: /assets/img/posts/main/xubuntu.jpg
  alt: Переход на xubuntu 24.04
---

Когда-то я писал [https://lexusalex.ru/30-switching-to-ubuntu-2204](https://lexusalex.ru/30-switching-to-ubuntu-2204), что переходил на хubuntu 22.04 LTS.

Сегодня уже переходим на xubuntu 24.04 LTS. 

Ставим максимальную версию со всеми утилитами

## Избавляемся от snap

````shell
# Вераия snap
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

Далее в файле `/etc/apt/preferences.d/nosnap.pref`, Нужно добавить строки

````text
Package: snapd
Pin: release a=*
Pin-Priority: -10
````

Далее стандартные обновляшки

````shell
sudo apt update
sudo apt upgrade
````

Подчищаем все остальное

````shell
rm -rf ~/snap
sudo rm -rf /snap
sudo rm -rf /var/snap
sudo rm -rf /var/lib/snapd
````


От snap отвзялись, делаем `reboot`.


Если нужен хоть какой-то браузер пока нет firefox, то ставим deb пакет

https://github.com/deemru/Chromium-Gost/releases

Архиватор, которым пользуюсь

ark

Vpn функционал

network-manager-openvpn-gnome

phpstorm качаем с офф сайта в vpn, далее активация [https://306.antroot.ru/jetbrains-activation](https://306.antroot.ru/jetbrains-activation)

## Firefox

Установка mozilla

[https://support.mozilla.org/ru/kb/ustanovka-firefox-na-linux#w_ustanovka-deb-paketa-firefox-dlia-osnovannykh-na-debian-distributivov-rekomenduetsia](https://support.mozilla.org/ru/kb/ustanovka-firefox-na-linux#w_ustanovka-deb-paketa-firefox-dlia-osnovannykh-na-debian-distributivov-rekomenduetsia)

##  Libreoffice 

Обновляем

https://fostips.com/update-libreoffice-office-suite-ubuntu/
 

Так же хоршая щтука
sudo apt install gnome-system-monitor

## git

````shell
sudo add-apt-repository -y ppa:git-core/ppa
apt update
sudo apt install git
git config --global core.excludesfile ~/.gitignore
echo '.idea/' >> ~/.gitignore
git config --global user.name "Alexey Shmelev"
git config --global user.email alexsey_89@bk.ru
git config --global init.defaultBranch main
````

## gitbub gitlab

````shell
## Общая генерация
ssh-keygen -t ed25519 -C "alexsey_89@bk.ru"
cat ~/.ssh/id_ed25519.pub

````

github

````shell
ssh -T git@github.com
````

gitlab

````shell
ssh -p 60022 -T git@git.lexusalex.ru
````

## docker and docker-compose

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

````shell
sudo apt update 
sudo apt install -y software-properties-common 
sudo add-apt-repository --yes --update ppa:ansible/ansible 
sudo apt install -y ansible
````


