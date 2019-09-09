#!/usr/local/bin/dumb-init /bin/sh
echo "xdebug.remote_host = ${XDEBUG_REMOTE_HOST:-localhost}" >> $PHP_INI_DIR/conf.d/docker-php-ext-xdebug.ini
php-fpm &
nginx -g "daemon off;"