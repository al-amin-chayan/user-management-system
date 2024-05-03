# Set the base image with the PHP version
ARG PHP_VERSION=8.3-fpm
FROM php:${PHP_VERSION} AS base

# Set default locale and user IDs
ARG UID=10001
ARG GID=10001

# System dependencies
RUN apt-get update && apt-get install -y \
    supervisor \
    libpq-dev \
    locales \
    libzip-dev \
    zip \
    libonig-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*  # Clear apt cache to reduce image size

# Install PHP extensions
RUN docker-php-ext-install gettext pdo pdo_mysql mbstring exif pcntl bcmath opcache

# Copy the OPCache configuration
COPY opcache.ini $PHP_INI_DIR/conf.d/

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Prepare runtime directories and permissions
RUN usermod -u ${UID} www-data \
    && groupmod -g ${GID} www-data \
    && mkdir -p /var/run/supervisor /var/log/supervisor \
    && touch /var/run/supervisor.sock \
    && chown -R www-data:www-data /var/www /var/run/supervisor /var/log/supervisor \
    && chmod 0700 /var/run/supervisor.sock

# Configuration for Supervisor
ENV SUPERVISOR_CONF=/etc/supervisor/supervisord.conf
COPY --chown=www-data:www-data supervisord.conf $SUPERVISOR_CONF

# Set working directory
WORKDIR /var/www

# Run as non-root user
USER www-data

# Expose port for PHP-FPM
EXPOSE 9000

# Command to run the supervisor
CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisor/supervisord.conf"]