#!/usr/bin/dumb-init /bin/sh
php-fpm &  # launch a process in the background
my-other-server  # launch another process in the foreground