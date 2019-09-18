FROM php:7.3-alpine

RUN apk add --virtual --no-cache .build-deps \
    $PHPIZE_DEPS

RUN pecl install \
    xdebug

RUN docker-php-ext-enable \ 
    xdebug

RUN docker-php-ext-install \
    pdo_mysql \
    pdo_pgsql \
    tokenizer

RUN apk del -f .build-deps

ENV COMPOSER_HOME /composer
ENV PATH ./vendor/bin:/composer/vendor/bin:$PATH
RUN curl -s https://getcomposer.org/intaller | php -- --install-dir=/usr/local/bin --filename=composer
COPY index.php /var/www/html
WORKDIR /var/www/html

