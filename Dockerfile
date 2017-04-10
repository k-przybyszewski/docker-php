FROM php:7-fpm-alpine

RUN apk upgrade --update \
    && apk add git vim autoconf libmcrypt-dev libxml2-dev postgresql-dev libpng-dev libxslt-dev bzip2 bzip2-dev icu-dev g++ make ca-certificates \
    && pecl install redis-3.1.1 && docker-php-ext-enable redis \
    && pecl install xdebug-2.5.1 && docker-php-ext-enable xdebug \
    && docker-php-ext-install bz2 zip gd mcrypt mbstring bcmath opcache intl soap pgsql pdo_pgsql pdo_mysql xsl \
    && curl -sS "https://getcomposer.org/installer?v=1.3.1" | php && mv composer.phar /usr/bin/composer \
    && mkdir -p /etc/ssl/certs/ && update-ca-certificates --fresh \
    && apk del --purge g++ make autoconf ca-certificates \

    && echo "xdebug.remote_enable=on" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_host=10.0.2.2" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_autostart=off" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_connect_back=On" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.idekey=PHPSTORM" >> /usr/local/etc/php/conf.d/xdebug.ini \

    && echo "memory_limit = 128M" >> /usr/local/etc/php/conf.d/php.ini \
    && echo "upload_max_filesize = 8M" >> /usr/local/etc/php/conf.d/php.ini

CMD ["php-fpm", "-F"]

EXPOSE 9000
