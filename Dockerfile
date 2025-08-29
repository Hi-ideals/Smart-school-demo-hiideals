FROM php:8.2-apache

# Install PHP extensions
RUN apt-get update && apt-get install -y \
    unzip git libzip-dev libpng-dev libjpeg-dev libfreetype6-dev libonig-dev \
    && docker-php-ext-configure gd --with-jpeg --with-freetype \
    && docker-php-ext-install mysqli pdo pdo_mysql gd zip

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Copy source code to Apache web root
COPY ./smart_school_src/ /var/www/html/

# Set correct permissions
RUN mkdir -p /var/www/html/temp \
    && chown -R www-data:www-data /var/www/html \
    && chmod -R 775 /var/www/html/application/config \
    && chmod -R 775 /var/www/html/temp

EXPOSE 80
