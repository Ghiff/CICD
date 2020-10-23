# Prebuild Image
FROM '123majumundur/php-7.1-nginx:cicd'
LABEL maintainer = "Ghifari Indra Gunawan <gunawanghifari21@gmail.com>"

# Prestissimo installation for faster deps installation
RUN composer global require hirak/prestissimo

# Directory for hosting apps
RUN mkdir /home/app/app
WORKDIR /home/app/app

# Install dependencies
COPY composer.json composer.json
RUN composer install --prefer-dist --no-scripts --no-dev --no-autoloader && rm -rf /home/app/.composer

# copy codebase
COPY --chown=app:root . ./

# finish composer
RUN composer dump-autoload --no-scripts --no-dev --optimize

EXPOSE 8080