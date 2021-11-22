# The following adds the Redis php extension to the mediawiki image:
FROM mediawiki:1.35
RUN apt-get update && pecl install -o -f redis \
&&  rm -rf /tmp/pear \
&&  docker-php-ext-enable redis