FROM php:5.6-apache
MAINTAINER James Wade <jpswade@gmail.com>

# Install gd, iconv, mbstring, mcrypt, mysql, soap, sockets, zip, and zlib extensions
# see example at https://hub.docker.com/_/php/
RUN apt-get update && apt-get install -y \
        libbz2-dev \
        libfreetype6-dev \
        libgd-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng-dev \
        libxml2-dev \
        zlib1g-dev \
    && docker-php-ext-install iconv mbstring mcrypt soap sockets zip \
    && docker-php-ext-configure gd --enable-gd-native-ttf --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd \
    && docker-php-ext-configure mysql --with-mysql=mysqlnd \
    && docker-php-ext-install mysql

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# enable mod_rewrite
RUN a2enmod rewrite

# make the webroot a volume
VOLUME /var/www/html/

# In images building upon this image, copy the src/ directory to the webserver
# root and correct the owner.
ONBUILD COPY / /var/www/html/
ONBUILD RUN chown -R www-data:www-data /var/www/html

EXPOSE 80

ENTRYPOINT ["apache2-foreground"]

#EOF
