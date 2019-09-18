FROM php:7.3-alpine

RUN apk add --virtual --no-cache \
    $PHPIZE_DEPS \
    curl-dev \
    imagemagick-dev \
    libtool \
    libxml2-dev \
    postgresql-dev


RUN pecl install \
    xdebug

RUN docker-php-ext-enable \ 
    xdebug

RUN docker-php-ext-install \
    pdo_mysql \
    pdo_pgsql \
    tokenizer && rm -rf /var/lib/apt/lists/*


ENV COMPOSER_HOME /composer
ENV PATH ./vendor/bin:/composer/vendor/bin:$PATH
RUN curl -s https://getcomposer.org/intaller | php -- --install-dir=/usr/local/bin --filename=composer
COPY index.php /var/www/html
WORKDIR /var/www/html

