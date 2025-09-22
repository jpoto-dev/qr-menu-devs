FROM php:7.2.34-fpm

# Update sources.list to use archive for outdated Debian version
RUN echo "deb http://archive.debian.org/debian buster main contrib non-free" > /etc/apt/sources.list && \
    echo "deb http://archive.debian.org/debian-security buster/updates main contrib non-free" >> /etc/apt/sources.list

RUN apt-get update && \
    apt-get install -y --no-install-recommends libssl-dev zlib1g-dev curl git unzip netcat libxml2-dev libpq-dev libzip-dev && \
    #pecl install apcu && \
    #docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql && \
    #docker-php-ext-install -j$(nproc) zip opcache intl pdo_pgsql pgsql && \
    #docker-php-ext-enable apcu pdo_pgsql sodium && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install Symfony CLI
RUN curl -sS https://get.symfony.com/cli/installer | bash && mv ~/.symfony5/bin/symfony /usr/local/bin/symfony

RUN mkdir /opt/app
WORKDIR /opt/app