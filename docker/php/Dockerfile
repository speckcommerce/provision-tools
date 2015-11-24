FROM php:7.0

RUN apt-get update && apt-get install -y \
        libpng12-dev \
        libjpeg-dev \
        libpq-dev \
        libicu-dev \
    && rm -rf /var/lib/apt/lists/* \
    && docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
    && docker-php-ext-install \
        intl \
        gd \
        mbstring \
        pdo \
        pdo_mysql \
        pdo_pgsql \
        zip

