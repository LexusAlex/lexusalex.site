FROM php:8.5-fpm-alpine3.23

ENV XDEBUG_VERSION 3.5.0
ENV COMPOSER_VERSION 2.9.2

# dev режим php
RUN mv $PHP_INI_DIR/php.ini-development $PHP_INI_DIR/php.ini

# Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/bin --filename=composer --version=$COMPOSER_VERSION --quiet

# Пользователь
RUN addgroup -g 1000 tech && adduser -u 1000 -G tech -s /bin/sh -D tech

# Директория
WORKDIR /public

# Текущий пользователь
USER tech

