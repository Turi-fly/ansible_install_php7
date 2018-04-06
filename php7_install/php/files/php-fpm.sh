#!/bin/bash
#
# Startup script for the PHP-FPM server.
#
# description: PHP is an HTML-embedded scripting language
# processname: php-fpm
# config: /usr/local/php/etc/php.ini

# Source function library.
#. /etc/rc.d/init.d/functions

PHP_PATH=$HOME
DESC="php-fpm daemon"
NAME=php-fpm
# php-fpm路径
DAEMON=$PHP_PATH/server/php7/sbin/$NAME
# 配置文件路径
CONFIGFILE=$PHP_PATH/server/php7/etc/php-fpm.conf
# PID文件路径(在php-fpm.conf设置)
PIDFILE=$PHP_PATH/server/php7/var/run/$NAME.pid
SCRIPTNAME=$HOME/server/php7/bin/$NAME

# Gracefully exit if the package has been removed.
test -x $DAEMON || exit 0

rh_start() {
  $DAEMON -y $CONFIGFILE || echo -n " already running"
}

rh_stop() {
  kill -QUIT `cat $PIDFILE` || echo -n " not running"
}


case "$1" in
  start)
        echo -n "Starting $DESC: $NAME"
        rh_start
        echo "."
        ;;
  stop)
        echo -n "Stopping $DESC: $NAME"
        rh_stop
        echo "."
        ;;

  restart)
        echo -n "Restarting $DESC: $NAME"
        rh_stop
        sleep 1
        rh_start
        echo "."
        ;;
  *)
         echo "Usage: $SCRIPTNAME {start|stop|restart}" >&2
         exit 3
        ;;
esac
exit 0

